;
; I2C_US_V02_00.asm
;
; Created: 4/02/2021 10:20:44 PM
; Author : Graham
;
; Device = ATtiny214
;
; Code for I2C to Ultrasonic interface.
; Hardware version v2.0
; (not supported on hardware version v1.0)
;
; Internal 20MHz clock is selected
; Timer A0 - Sends pulses to the ultrasonic sensor
; - Pin 7 - WO2/PB2
; Timer B0 is uses to measure the length of the returning pulses.
; - Pin 6 - PB3
; I2C interface
; - Pin 8 - SDA/PB1
; - Pin 9 - SCL/PB0
; LED Outputs
; - Pin 3 - PA5 - Red LED (Power)
; - Pin 4 - PA6 - Yellow (Comms)
; - Pin 5 - PA7 - Green (Valid Measurement)
; Overhead connections...
; - Pin 1 - VDD +5v
; - Pin 14 - GND
; - Pin 10 - UPDI programming interface
; Unused pins
; - Pin 2 - PA4
; - Pin 11 - PA1
; - Pin 12 - PA2
; - Pin 13 - PA3

.include "tn214def.inc"

; Change this address on some devices to have multiple addressable devices on a single I2C bus.
.equ MySlaveAddress	= 0x14

.equ DDR_I2C	= PORTB_DIR
.equ PORT_I2C	= PORTB_OUT
.equ PIN_I2C	= PORTB_IN
.equ SCL		= 0				;!!!!!!!!!!!!!SCL DDR and PORT are ALWAYS =1	 !!!!!!!!!!!!!!!!!
.equ SDA 		= 1				;!!!!!!!!!!!!!SDA PORT are ALWAYS =1 			!!!!!!!!!!!!!!!!!
.equ OC1A		= 3				; Output compare pin for ultrasonic trigger
.equ LED_RED	= 5
.equ LED_YELLOW	= 6
.equ LED_GREEN	= 7

.def AL = r16
.equ TCA0_WO2 = 2				; WO2 is portB pin 2

	; If we set the prescaler at /24 then we end up with 0.833MHz = 78.6ms / 65536 counts
	;	This gives 50000 counts per 60ms.
	;	The pulse needs to be on for 9 counts to be greater than 10us
.equ TCA0_PERIOD = 50000
.equ TCA0_PWMONTIME = 10

.dseg
.org	SRAM_START					;RAMTOP
I2CsubAddrBuf:	 	.byte 1

;****************************************************************************************
;----------------------------------------------------------;
.cseg
.org 0x0000
	rjmp RESET
.org CRCSCAN_NMI_vect
	rjmp ISR
.org BOD_VLM_vect
	rjmp ISR
.org PORTA_PORT_vect
	rjmp ISR
.org PORTB_PORT_vect
	rjmp ISR
.org RTC_CNT_vect
	rjmp ISR
.org RTC_PIT_vect
	rjmp ISR
.org TCA0_OVF_vect		; Also TCA0_LUNF
	rjmp TCA0_OVF_ISR
.org TCA0_HUNF_vect
	rjmp ISR
.org TCA0_LCMP0_vect		; Also TCA0_CMP0
	rjmp ISR
.org TCA0_LCMP1_vect		; Also TCA0_CMP1
	rjmp ISR
.org TCA0_LCMP2_vect		; Also TCA0_CMP2
	rjmp ISR
.org TCB0_INT_vect
	rjmp TCB0_INT_ISR
.org TCD0_OVF_vect
	rjmp ISR
.org TCD0_TRIG_vect
	rjmp ISR
.org AC0_AC_vect
	rjmp ISR
.org ADC0_RESRDY_vect
	rjmp ISR
.org ADC0_WCOMP_vect
	rjmp ISR
.org TWI0_TWIS_vect
	rjmp TWI0_TWIS_ISR
.org TWI0_TWIM_vect
	rjmp TWI0_TWIM_ISR
.org SPI0_INT_vect
	rjmp ISR
.org USART0_RXC_vect
	rjmp ISR
.org USART0_DRE_vect
	rjmp ISR
.org USART0_TXC_vect
	rjmp ISR
.org NVMCTRL_EE_vect
	rjmp ISR


RESET:

	;It is not required to initialise the stack pointer.
	;ldi r16, low(RAMEND)
	;out SPL, r16

	;set port A pins 5, 6 & 7 to outputs for the LEDs, remainder as inputs/tristate.
	ldi r16, 0x00+(1<<LED_RED)+(1<<LED_YELLOW)+(1<<LED_GREEN)
	sts PORTA_DIR, r16

	ldi r16, 0x00+(1<<LED_RED)+(0<<LED_YELLOW)+(0<<LED_GREEN)
	sts PORTA_OUT, r16

	; I2C clock line, plus PWM pin are outputs
	ldi r16, 0x00+(1<<SCL)+(1<<TCA0_WO2)
	sts PORTB_DIR, r16
	ldi r16, 0x00+(1<<SCL)+(1<<SDA)
	sts PORTB_OUT, r16

	;The analogue comparator is disabled on startup already
	;sbi ACSR,ACD					;disable analogue comparator
	
	;Not sure what to do here - need to read the manual!
	;outi MCUCR,(1<<SE)				;Sleep On///Power-Down Mode

	;This next few lines fills the first 120 bytes of the buffer used for I2C with numbers counting up.
	;It can be used for testing before the ultrasonic code is finished.
	;It will be overwritten as soon as an ultrasonic measurement is made.
	ldi XL,low(I2CsubAddrBuf)
	ldi XH,high(I2CsubAddrBuf)
	ldi r16,1
initloop1:
	st X+,r16
	inc r16
	cpi r16,120
	brlo initloop1


	;Initialise timer/counter 0
	; TCA0 will drive the hardware pin to trigger an ultrasonic measure.
	; To pulse approximately every 60ms, pulse length at least 10us
	; Also an interrupt to be generated to reset the I2C link LED

	ldi r16, CPU_CCP_IOREG_gc
	ldi r17, 0x00 + (1<<CLKCTRL_PEN_bp) + CLKCTRL_PDIV_24X_gc
	sts CPU_CCP, r16		; Unlock clock controller for change.
	sts CLKCTRL_MCLKCTRLB, r17

	; Set clock period to 50000 counts.
	ldi r16, low(TCA0_PERIOD)
	sts TCA0_SINGLE_PER, r16
	ldi r16, high(TCA0_PERIOD)
	sts TCA0_SINGLE_PER+1, r16

	;Set WO2/CMP2 on time to 10 counts
	ldi r16, low(TCA0_PWMONTIME)
	sts TCA0_SINGLE_CMP2, r16
	ldi r16, high(TCA0_PWMONTIME)
	sts TCA0_SINGLE_CMP2+1, r16

	; Enable counter in normal mode
	ldi r16, (1<<TCA_SINGLE_ENABLE_bp)
	sts TCA0_SINGLE_CTRLA, r16

	; Enable waveform on CMP2 in PWM mode
	ldi r16, (1<<TCA_SINGLE_CMP2EN_bp) + (TCA_SINGLE_WGMODE_SINGLESLOPE_gc <<TCA_SINGLE_WGMODE_gp)
	sts TCA0_SINGLE_CTRLB, r16

	; Enable overflow interrupt.
	ldi r16, (1<<TCA_SINGLE_OVF_bp)
	sts TCA0_SINGLE_INTCTRL, r16




	;Initialise timer/counter 1
	;Normal counter mode, no output compare
;	outi TCCR1A, 0
	; Clock select / 8
;	outi TCCR1B, (1<<CS11) | (1<<ICES1)
	;outi TCCR1B, (1<<CS10) | (1<<CS11)

	ldi r16, (1<<TCB_ENABLE_bp)
	sts TCB0_CTRLA, r16
	ldi r16, (1<<TCB_CCMPEN_bp) + (TCB_CNTMODE_PW_gc<<TCB_CNTMODE_gp)
	ldi r16, (TCB_CNTMODE_PW_gc<<TCB_CNTMODE_gp)
	sts TCB0_CTRLB, r16
	ldi r16, (1<<TCB_CAPTEI_bp)
	sts TCB0_EVCTRL, r16
	ldi r16, (1<<TCB_CAPT_bp)
	sts TCB0_INTCTRL, r16

	ldi r16, EVSYS_ASYNCCH1_PORTB_PIN3_gc
	sts EVSYS_ASYNCCH1, r16
	ldi r16, EVSYS_ASYNCUSER0_ASYNCCH1_gc
	sts EVSYS_ASYNCUSER0, r16


;I2Cinit:

	; Enable the TWI as an I2C slave by writing in our slave address and enabling.
	ldi r16, MySlaveAddress<<1
	sts TWI0_SADDR, r16
	ldi r16, 0x00 + (1<<TWI_ENABLE_bp) + (1<<TWI_DIEN_bp) + (1<<TWI_APIEN_bp) + (1<<TWI_PIEN_bp) + (1<<TWI_SMEN_bp)
	sts TWI0_SCTRLA, r16

	sei

MainLoop:
;	sleep
;	WDR
	rjmp MainLoop


; TWI slave interrupt
; if APIF (address or stop) bit on
;	if AP is on (address interrupt)
;		if R/W bit is off (write)
;		- remember write mode
;		- reset APIF flag
;		- return
;		else (read)
;		- remember read mode
;		- initialise read pointer
;		- reset APIF flag
;		- return
;	else (STOP command)
;	- reset all read / write flags
; else if DIF is on (data transaction complete)
;	if reading
;	- get next byte & increment pointer
;	- write byte
;	- clear DIF flag
;	- return
;	else (writing)
;	- read and discard byte
;	- clear DIF flag
;	- return
TWI0_TWIS_ISR:
	cli
	lds r17, TWI0_SSTATUS
	sbrs r17, TWI_APIF_bp
	rjmp TWI0_NO_APIF
	; APIF flag is on (address or stop interrupt)
	sbrs r17, TWI_AP_bp
	rjmp TWI0_STOP
	; AP flag is on (address interrupt)
	lds r17, TWI0_SDATA
	sbrc r17, 0
	rjmp TWI0_READ
	; Address received was for write
	sbr r18, 0b00000010		; Remember write
	ldi r17, 0x03<<TWI_SCMD_gp
	sts TWI0_SCTRLB, r17	; Command - acknowledge & read next byte
	ldi r17, 1<<TWI_APIF_bp
	sts TWI0_SSTATUS, r17	; clear interrupt flag
	sei
	reti

TWI0_READ:
	sbr r18, 0b00000001		; Remember read

	; Create message
	ldi YL, 1
	sts I2CsubAddrBuf, YL
	mov YL, r10
	sts I2CsubAddrBuf+1, YL
	mov YL, r8
	sts I2CsubAddrBuf+2, YL
	mov YL, r9
	sts I2CsubAddrBuf+3, YL
	mov YL, r10
	eor YL, r8
	eor YL, r9
	sts I2CsubAddrBuf+4, YL


	ldi r19, 0x01			; initialise pointer
	sts I2CsubAddrBuf, r19
	ldi r17, 0x03<<TWI_SCMD_gp
	sts TWI0_SCTRLB, r17	; Command - acknowledge & generate data interrupt for first byte
	ldi r17, 1<<TWI_APIF_bp
	sts TWI0_SSTATUS, r17	; clear interrupt flag

	; Turn yellow LED on for Rx indication
	ldi r20, 4
	ldi r16, (1<<LED_YELLOW)
	sts PORTA_OUTSET, r16
	sei
	reti

TWI0_STOP:
	ldi r18, 0b00000000		; clear read/write flags
	ldi r17, 1<<TWI_APIF_bp
	sts TWI0_SSTATUS, r17	; clear interrupt flag
	sei
	reti

TWI0_NO_APIF:
	sbrc r18,0
	rjmp TWI0_DATAR
	sbrc r18,1
	rjmp TWI0_DATAW
	lds r17, TWI0_SDATA
	; data interrupt when we are not reading or writing - turn on yellow LED
	ldi r16, (1<<LED_YELLOW)
	sts PORTA_OUTSET, r16
	sei
	reti

TWI0_DATAR:
	lds YL,I2CsubAddrBuf
	clr YH
	;addiw Y,SRAM_START
    subi    YL,low(-(SRAM_START))
    sbci    YH,high(-(SRAM_START))

	ld r16,Y+
	sts TWI0_SDATA,r16
	;subiw Y,SRAM_START
    subi    YL,low(SRAM_START)
    sbci    YH,high(SRAM_START)
	
	sts I2CsubAddrBuf,YL
	sei
	reti

TWI0_DATAW:
	; Ignore all writes!
	lds r17, TWI0_SDATA
	sei
	reti



	ldi r16, (1<<LED_YELLOW)
	sts PORTA_OUTSET, r16



TWI0_TWIM_ISR:
	reti

TCA0_OVF_ISR:
	cli
	; Clear TCA interrupt flag.
	ldi r21, (1<<TCA_SINGLE_OVF_bp)
	sts TCA0_SINGLE_INTFLAGS, r21
	; Turn off yellow LED if no messages recently.	
	dec r20
	brne YLEDLit
	ldi r21, (1<<LED_YELLOW)
	sts PORTA_OUTCLR, r21
YLEDLit:
	; Turn off green LED if no measurements last tick.	
	dec r22
	brne GLEDLit
	ldi r21, (1<<LED_GREEN)
	sts PORTA_OUTCLR, r21
	ldi r21, 0
	mov r8, r21
	mov r9, r21
GLEDLit:
	; r23 will be zero if sensor feedback bit is off.
	; r23 will be one if sensor feedback bit is on and green LED is turned off.
	; PB3 is the bit
	lds r21, PORTB_IN
	sbrs r21, 3
	rjmp FBOff
FBOn:
	ldi r23,2
	ldi r21, (1<<LED_GREEN)
	sts PORTA_OUTCLR, r21
	ldi r21, 0
	mov r8, r21
	mov r9, r21
	rjmp FBEnd
FBOff:
	cpi r23, 0
	breq FBEnd
	dec r23
FBEnd:
	sei
	reti

TCB0_INT_ISR:
; Check if input was off when pulse was last run. If on, then ignore reading and return immediately.
	cli
	cpi r23, 0
	breq GoodMeas
	; Read data to clear interrupt.
	lds r21, TCB0_CCMPL
	lds r21, TCB0_CCMPH
	sei
	reti
GoodMeas:
	ldi r21, (1<<LED_GREEN)
	sts PORTA_OUTSET, r21
	ldi r22, 2
	; Must read low before high when reading 16 bit register.
	lds r8, TCB0_CCMPL
	lds r9, TCB0_CCMPH
	inc r10
	sei
	reti

ISR:
	reti

