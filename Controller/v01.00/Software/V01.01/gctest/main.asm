;
; gctest.asm
;
; Created: 12/03/2020 9:13:01 PM
; Author : Graham
;


	;ATTiny2313
;drive timed output pulses to ultrasonic sensor
;Measure duration of received pulses
;Provide this information via I2C bus

;I2C information.
; Clock is always an output, outputting 1
; Data is always set to 1, direction is changed to control line.

;!!!!!!!!!!!!!   SCL DDR and PORT are ALWAYS =1	 !!!!!!!!!!!!!!!!!			*
;!!!!!!!!!!!!!   SDA PORT are ALWAYS =1 		 !!!!!!!!!!!!!!!!!			*
;****************************************************************************
;****************************************************************************

.include "tn2313def.inc"
.include "avr.inc"

.equ MySlaveAddress	= 0x13

.equ DDR_I2C	= DDRB
.equ PORT_I2C	= PORTB
.equ PIN_I2C	= PINB
.equ SCL		= 7				;!!!!!!!!!!!!!SCL DDR and PORT are ALWAYS =1	 !!!!!!!!!!!!!!!!!
.equ SDA 		= 5				;!!!!!!!!!!!!!SDA PORT are ALWAYS =1 			!!!!!!!!!!!!!!!!!
.equ OC1A		= 3				; Output compare pin for ultrasonic trigger
.equ OC0A		= 2				; Output compare pin for ultrasonic trigger
.equ	Flag			= GPIOR1
.equ	I2Cadr			= 7
.equ	I2Crw			= 6			;Read=1
.equ	I2CsubAddr		= 5			;WriteSubAddr=1
.equ	I2Cask			= 4

;=========================================================;
.dseg
.org	SRAM_START					;RAMTOP
I2CsubAddrBuf:	 	.byte 1

;****************************************************************************************
;----------------------------------------------------------;
.cseg
.org 0x0000
	rjmp RESET
.org INT0addr
	rjmp INTH0 ; External Interrupt0 Handler
.org INT1addr
	rjmp INTH1 ; External Interrupt1 Handler
.org ICP1addr
	rjmp TIM1_CAPT ; Timer1 Capture Handler
.org OC1Aaddr
	rjmp TIM1_COMPA ; Timer1 CompareA Handler
.org OVF1addr
	rjmp TIM1_OVF ; Timer1 Overflow Handler
.org OVF0addr
	rjmp TIM0_OVF ; Timer0 Overflow Handler
.org URXCaddr
	rjmp USART0_RXC ; USART0 RX Complete Handler
.org UDREaddr
	rjmp USART0_DRE ; USART0,UDR Empty Handler
.org UTXCaddr
	rjmp USART0_TXC ; USART0 TX Complete Handler
.org ACIaddr
	rjmp ANA_COMP ; Analog Comparator Handler
.org PCIaddr
	rjmp PCINT ; Pin Change Interrupt
.org OC1Baddr
	rjmp TIMER1_COMPB ; Timer1 Compare B Handler
.org OC0Aaddr
	rjmp TIMER0_COMPA ; Timer0 Compare A Handler
.org OC0Baddr
	rjmp TIMER0_COMPB ; Timer0 Compare B Handler
.org USI_STARTaddr		;USI_STRaddr
	rjmp USI_START
.org USI_OVFaddr
	rjmp USI_OVERFLOW
.org ERDYaddr rjmp EE_READY ; EEPROM Ready Handler
.org WDTaddr rjmp WDT_OVERFLOW ; Watchdog Overflow Handler



;----------------------------------------------------------;
USI_START:
	push AL
	in AL,SREG
	push AL

	; Clear the message state tracking bits.
 	cbi DDR_I2C,SDA
	outi Flag,0

	sbic PIN_I2C,SCL	;Wait for SCL to go low to ensure the "Start Condition" has completed.
	rjmp PC-1

	; Enable the 4 bit counter overflow interrupt
	outi USICR,(1<<USISIE)|(1<<USIOIE)|(1<<USIWM1)|(1<<USIWM0)|(1<<USICS1)   
	; Clear the interrupt pending flags in the status register
   	outi USISR,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)
  
	pop	AL
	out	SREG,AL
	pop AL
	reti
;----------------------------------------------------------;
USI_OVERFLOW:
	pushw Y
	pushw A
	in AL,SREG
	push AL

	in AH,USIDR

	; The first receive will always be to check our address.
	; Once checked, this flag is set to skip this in future.
	sbis Flag,I2Cadr
	rjmp CheckAddress

	sbis Flag,I2Crw
	rjmp WriteData
;------------------------------------
;ReadData:
	sbis Flag,I2Cask
	rjmp ReadData1

	; This seems to skip the compare of AH to 0 for the first byte of read data.
	sbis Flag,I2CsubAddr
	rjmp Ask0
	cpi AH,0
	brne ResetUSI			;NACK
PutData:
	cbi Flag,I2Cask
	;Loads the address stored in I2CsubAddrBuf, adds the start location of SRAM
	; then retrieves the data from that location into AL (incrementing the pointer,
	; then subtracts the location of SRAM before writing the new (incremented) pointer
	; back to I2CsubAddrBuf.
	; The read valud (AL) is written to the data register USIDR.
	lds YL,I2CsubAddrBuf
	clr YH
	addiw Y,SRAM_START
	ld AL,Y+
	out USIDR,AL
	subiw Y,SRAM_START
	sts I2CsubAddrBuf,YL

	;GC code start
	; copy port D into data output.
	;in AL, PIND
	;in AL, TCNT0
	;in AL, TCNT1L
	;in AL, ICR1L
	;in AL, ICR1H
	;in AL, OCR0A
	;ldi AL, 0x23
	;out USIDR, AL
	;GC code end

	sbi DDR_I2C,SDA			;Set SDA as output
	; Set AL to clear interrupt pending bits & return from interrupt
   	ldi AL,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)
	rjmp I2CdataRX_outAL
Ask0:
	sbi Flag,I2CsubAddr
	;Create message
	ldi YL, 1
	sts I2CsubAddrBuf, YL
	mov YL, BL
	sts I2CsubAddrBuf+1, YL
	mov YL, CL
	sts I2CsubAddrBuf+2, YL
	mov YL, CH
	sts I2CsubAddrBuf+3, YL
	mov YL, BL
	eor YL, CL
	eor YL, CH
	sts I2CsubAddrBuf+4, YL
	rjmp PutData
ReadData1:
	sbi Flag,I2Cask
	cbi DDR_I2C,SDA			;Set SDA as input
	outi USIDR,0			;Prepare ACK 
	rjmp I2CdataRX_out7E
;------------------------------------
WriteData:
	sbis Flag,I2Cask
	rjmp WriteData0
	cbi Flag,I2Cask 
 	cbi DDR_I2C,SDA
   	ldi AL,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)
	rjmp I2CdataRX_outAL
ResetUSI:
 	cbi DDR_I2C,SDA
	outi Flag,0
	outi USICR,(1<<USISIE)|(1<<USIWM1)|(0<<USIWM0)|(1<<USICS1); ;Start Condition Interrupt;Set USI in Two-wire mode;Clock Source = External, positive edge        */  \
    ldi AL,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)|(1<<USIDC)		;Clear all flags, except Start Cond 
	rjmp I2CdataRX_outAL
WriteData0:
	sbic Flag,I2CsubAddr
	rjmp DoData
;Save SubAddress
	sts I2CsubAddrBuf,AH
	sbi Flag,I2CsubAddr
	sbi Flag,I2Cask
	rjmp Send_ASK
DoData:
	lds YL,I2CsubAddrBuf
	clr YH
	addiw Y,SRAM_START
	st Y+,AH
	subiw Y,SRAM_START
	sts I2CsubAddrBuf,YL
	sbi Flag,I2Cask
	rjmp Send_ASK
;---------------------------------
CheckAddress:
	; Stores the read/write flag into "T"
	bst AH,0
	; Cleares the read/write flag, then compares to our address. Resets interface if not our address.
	cbr AH,1
	cpi AH,(MySlaveAddress<<1)
	brne ResetUSI
	; If our address, sets I2Cadr and I2Cask flags, (and I2Crw if "T" was set)
	ldi AL,(1<<I2Cadr)|(1<<I2Cask)
	bld AL,I2Crw
	out Flag,AL
	ldi BH, 4
	sbi PORTD, 3
Send_ASK:
	; Send ACK. Clear data register and set SDA on.
	outi USIDR,0
	sbi DDR_I2C,SDA
	; Clear start, overflow and stop interrupt pending bits.
	; initialise the counter value to 14.
I2CdataRX_out7E:
  	ldi AL,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)|(0x0E<<USICNT0)
I2CdataRX_outAL:
   	out USISR,AL

	pop	AL
	out	SREG,AL
	popw A
	popw Y
	reti
;----------------------------------------------------------;
RESET:
	outi SPL,low(RAMEND)

	outi DDRD, 0x18
	outi PORTD, 0x10
	; I2C clock line, plus PWM pin are utputs
	;outi DDRB, 0b00000000+(1<<SCL)
	outi DDRB, 0b00000000+(1<<SCL)+(1<<OC0A)
	outi PORTB,0b00000000+(1<<SCL)+(1<<SDA)			;Port 1=OUTputs

	sbi ACSR,ACD					;disable analogue comparator
	
	outi MCUCR,(1<<SE)				;Sleep On///Power-Down Mode

	ldiw X,I2CsubAddrBuf
	ldi AL,1
initloop1:
	st X+,AL
	inc AL
	cpi AL,120
	brlo initloop1

	;Initialise timer/counter 0
	;FastPWM, set at TOP, clear at OCR0A match
	outi TCCR0A, (1<<COM0A1) | (1<<WGM00) | (1<<WGM01)
	; Clock select / 1024 (for initial test)
	outi TCCR0B, (1<<CS00) | (1<<CS02)
	; Set to 0.4% duty cycle (one clock cycle)
	outi OCR0A, 0x00
	;Output is port B pin 3


	;Initialise timer/counter 1
	;Normal counter mode, no output compare
	outi TCCR1A, 0
	; Clock select / 8
	outi TCCR1B, (1<<CS11) | (1<<ICES1)
	;outi TCCR1B, (1<<CS10) | (1<<CS11)


;I2Cinit:
	outi USICR,(1<<USISIE)|(1<<USIWM1)|(0<<USIWM0)|(1<<USICS1)	;| ;Start Condition Interrupt;Set USI in Two-wire mode;Clock Source = External, positive edge        */  \
    outi USISR,(1<<USISIF)|(1<<USIOIF)|(1<<USIPF)|(1<<USIDC)	;Clear all flags
	outi Flag,0

	;Enable interrupt on timer capture
	outi TIMSK, (1<<ICIE1)
	outi TIMSK, (1<<TOIE0)

	sei

MainLoop:
;	sleep
;	WDR
	rjmp MainLoop

TIM1_CAPT:
;	pushw Y
	pushw A
	in AL,SREG
	push AL

	;sbic TCCR1B, ICES1
	in AL, TCCR1B
	sbrc AL, ICES1
	rjmp ICR_Rising
ICR_Falling:
	in CL, ICR1L
	in CH, ICR1H
	sub CL, DL
	sbc CH, DH
	inc BL
	; Set ICES1 to next look for a rising edge.
	outi TCCR1B, (1<<CS11) | (1<<ICES1)
	; Disable interrupt for input capture until next output pulse.
	outi TIMSK, (1<<TOIE0)
	rjmp ICR_End
ICR_Rising:
	in DL, ICR1L
	in DH, ICR1H
	; Clear ICES1 to now look for a falling edge.
	outi TCCR1B, (1<<CS11)

ICR_End:
	pop	AL
	out	SREG,AL
	popw A
;	popw Y
	reti

TIM0_OVF: ; Timer0 Overflow Handler
	pushw A
	in AL,SREG
	push AL

	in AL, TIMSK
	sbrs AL, ICIE1
	rjmp LastOK
	; If executing here, we did not see a pulse back from the ultrasonic
	; Clear the last counters so that the master knows we are not getting
	; a reading.
	ldi CL, 0
	ldi CH, 0
LastOK:
	; Enable interrupt for input capture
	outi TIMSK, (1<<ICIE1) | (1<<TOIE0)
	outi TCCR1B, (1<<CS11) | (1<<ICES1)

	dec BH
	brne LEDLit
	cbi PORTD, 3
LEDLit:

	pop	AL
	out	SREG,AL
	popw A
	reti

INTH0: ; External Interrupt0 Handler
INTH1: ; External Interrupt1 Handler
TIM1_COMPA: ; Timer1 CompareA Handler
TIM1_OVF: ; Timer1 Overflow Handler
USART0_RXC: ; USART0 RX Complete Handler
USART0_DRE: ; USART0,UDR Empty Handler
USART0_TXC: ; USART0 TX Complete Handler
ANA_COMP: ; Analog Comparator Handler
PCINT: ; Pin Change Interrupt
TIMER1_COMPB: ; Timer1 Compare B Handler
TIMER0_COMPA: ; Timer0 Compare A Handler
TIMER0_COMPB: ; Timer0 Compare B Handler
EE_READY: ; EEPROM Ready Handler
WDT_OVERFLOW: ; Watchdog Overflow Handler
	reti


