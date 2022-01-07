EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:LED Link1
U 1 1 5E3C9AB4
P 7750 3700
F 0 "Link1" H 7743 3916 50  0000 C CNN
F 1 "Yellow LED" H 7743 3825 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 7750 3700 50  0001 C CNN
F 3 "~" H 7750 3700 50  0001 C CNN
	1    7750 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:LED Power2
U 1 1 5E3CA3D1
P 8400 3700
F 0 "Power2" H 8393 3916 50  0000 C CNN
F 1 "Red LED" H 8393 3825 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 8400 3700 50  0001 C CNN
F 3 "~" H 8400 3700 50  0001 C CNN
	1    8400 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R 200R1
U 1 1 5E3CA9F6
P 7650 4200
F 0 "200R1" H 7720 4246 50  0000 L CNN
F 1 "R" H 7720 4155 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7580 4200 50  0001 C CNN
F 3 "~" H 7650 4200 50  0001 C CNN
	1    7650 4200
	1    0    0    -1  
$EndComp
$Comp
L Device:R 200R2
U 1 1 5E3CADCA
P 8300 4150
F 0 "200R2" H 8370 4196 50  0000 L CNN
F 1 "R" H 8370 4105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8230 4150 50  0001 C CNN
F 3 "~" H 8300 4150 50  0001 C CNN
	1    8300 4150
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male I2C_Bus1
U 1 1 5E3CC5F9
P 3550 3750
F 0 "I2C_Bus1" H 3658 4031 50  0000 C CNN
F 1 "Conn_01x04_Male" H 3658 3940 50  0001 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-AM_1x04_P2.50mm_Vertical" H 3550 3750 50  0001 C CNN
F 3 "~" H 3550 3750 50  0001 C CNN
	1    3550 3750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male US_Sensor1
U 1 1 5E3CCBEB
P 9200 2950
F 0 "US_Sensor1" H 9308 3231 50  0000 C CNN
F 1 "Conn_01x04_Male" H 9308 3140 50  0001 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-AM_1x04_P2.50mm_Vertical" H 9200 2950 50  0001 C CNN
F 3 "~" H 9200 2950 50  0001 C CNN
	1    9200 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3150 9700 3150
Wire Wire Line
	9700 3150 9700 1700
Wire Wire Line
	9400 2850 9650 2850
Wire Wire Line
	9650 2850 9650 4950
Wire Wire Line
	9400 2950 9600 2950
Wire Wire Line
	9400 3050 9500 3050
Wire Wire Line
	3750 3950 4450 3950
Wire Wire Line
	4450 3950 4450 4950
Wire Wire Line
	7250 4350 7650 4350
Wire Wire Line
	7650 4050 7650 3850
Wire Wire Line
	7650 3850 7900 3850
Wire Wire Line
	7900 3850 7900 3700
Wire Wire Line
	7600 3700 7450 3700
Wire Wire Line
	7450 3700 7450 4950
Connection ~ 7450 4950
Wire Wire Line
	7450 4950 8150 4950
Wire Wire Line
	7100 4400 8300 4400
Wire Wire Line
	8300 4400 8300 4300
Wire Wire Line
	8300 4000 8300 3900
Wire Wire Line
	8300 3900 8600 3900
Wire Wire Line
	8600 3900 8600 3700
Wire Wire Line
	8600 3700 8550 3700
Wire Wire Line
	8250 3700 8150 3700
Wire Wire Line
	8150 3700 8150 4950
Connection ~ 8150 4950
Wire Wire Line
	8150 4950 8750 4950
$Comp
L power:GND #PWR0101
U 1 1 5E3E56D6
P 6300 4950
F 0 "#PWR0101" H 6300 4700 50  0001 C CNN
F 1 "GND" H 6305 4777 50  0000 C CNN
F 2 "" H 6300 4950 50  0001 C CNN
F 3 "" H 6300 4950 50  0001 C CNN
	1    6300 4950
	1    0    0    -1  
$EndComp
Connection ~ 6300 4950
$Comp
L power:+5V #PWR0102
U 1 1 5E3E6140
P 6400 1700
F 0 "#PWR0102" H 6400 1550 50  0001 C CNN
F 1 "+5V" H 6415 1873 50  0000 C CNN
F 2 "" H 6400 1700 50  0001 C CNN
F 3 "" H 6400 1700 50  0001 C CNN
	1    6400 1700
	1    0    0    -1  
$EndComp
Connection ~ 6400 1700
$Comp
L MCU_Microchip_ATtiny:ATtiny214-SS U1
U 1 1 6016B157
P 5500 3400
F 0 "U1" H 5500 4281 50  0000 C CNN
F 1 "ATtiny214-SS" H 5500 4190 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5500 3400 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/40001912A.pdf" H 5500 3400 50  0001 C CNN
	1    5500 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 4950 4800 4950
Wire Wire Line
	5500 4100 5500 4400
Connection ~ 5500 4950
Wire Wire Line
	5500 4950 6300 4950
Text Notes 1050 1850 0    50   ~ 0
Timer A0 - Pulse timer for US transmit\nPin 7 - WO2/PB2 (optional Pin6 Alt WO0/PB3)\nTimer B0 - DIstance counter for US receive\nPin ?? - need to use the "event system"??\nClock is now internal\nI2C Interface\nPin 8 - SDA/PB1\nPin 9 - SCL/PB0\nLED Outputs\nPin ? - Red LED (Power)\nPin ? - Orange LED (Comms)\nPin ? - Green LED (Valid Measurement)
Wire Wire Line
	3750 3850 4800 3850
Wire Wire Line
	4800 3850 4800 1700
Wire Wire Line
	4800 1700 5500 1700
Wire Wire Line
	5500 2700 5500 1700
Connection ~ 5500 1700
Wire Wire Line
	5500 1700 6400 1700
Wire Wire Line
	4900 3000 4300 3000
Wire Wire Line
	4900 3100 4400 3100
Wire Wire Line
	4400 3100 4400 3650
Wire Wire Line
	4900 3200 4700 3200
Wire Wire Line
	4700 3200 4700 4600
Wire Wire Line
	4700 4600 9500 4600
Wire Wire Line
	9500 4600 9500 3050
Wire Wire Line
	4900 3300 4600 3300
Wire Wire Line
	4600 3300 4600 4700
Wire Wire Line
	4600 4700 9600 4700
Wire Wire Line
	9600 2950 9600 4700
Wire Wire Line
	6100 3500 7100 3500
Wire Wire Line
	6100 3600 7250 3600
Wire Wire Line
	7250 3600 7250 4350
Wire Wire Line
	7100 3500 7100 4400
$Comp
L Device:LED Measure1
U 1 1 60290DED
P 9000 3700
F 0 "Measure1" H 8993 3916 50  0000 C CNN
F 1 "Green LED" H 8993 3825 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm" H 9000 3700 50  0001 C CNN
F 3 "~" H 9000 3700 50  0001 C CNN
	1    9000 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R 200R3
U 1 1 60290DF3
P 8900 4150
F 0 "200R3" H 8970 4196 50  0000 L CNN
F 1 "R" H 8970 4105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8830 4150 50  0001 C CNN
F 3 "~" H 8900 4150 50  0001 C CNN
	1    8900 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 4000 8900 3900
Wire Wire Line
	8900 3900 9200 3900
Wire Wire Line
	9200 3900 9200 3700
Wire Wire Line
	9200 3700 9150 3700
Wire Wire Line
	8850 3700 8750 3700
Wire Wire Line
	6100 3700 6900 3700
Wire Wire Line
	6900 3700 6900 4500
Wire Wire Line
	6900 4500 8900 4500
Wire Wire Line
	8900 4300 8900 4500
Wire Wire Line
	6400 1700 6750 1700
Wire Wire Line
	6300 4950 6750 4950
$Comp
L Connector_Generic:Conn_01x03 Programmer1
U 1 1 60297102
P 7550 2500
F 0 "Programmer1" H 7630 2542 50  0000 L CNN
F 1 "Conn_01x03" H 7630 2451 50  0001 L CNN
F 2 "Connector_JST:JST_XH_B3B-XH-AM_1x03_P2.50mm_Vertical" H 7550 2500 50  0001 C CNN
F 3 "~" H 7550 2500 50  0001 C CNN
	1    7550 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 2400 6750 2400
Wire Wire Line
	6750 2400 6750 1700
Connection ~ 6750 1700
Wire Wire Line
	6750 1700 9700 1700
Wire Wire Line
	7350 2600 6750 2600
Wire Wire Line
	6750 2600 6750 4950
Connection ~ 6750 4950
Wire Wire Line
	6750 4950 7450 4950
Wire Wire Line
	7350 2500 6300 2500
Wire Wire Line
	6300 2500 6300 3000
Wire Wire Line
	6300 3000 6100 3000
Wire Wire Line
	8750 3700 8750 4950
Connection ~ 8750 4950
Wire Wire Line
	8750 4950 9650 4950
$Comp
L Device:C C1
U 1 1 603599F8
P 4800 4250
F 0 "C1" H 4915 4296 50  0000 L CNN
F 1 "4.7uF" H 4915 4205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.1mm_W3.2mm_P5.00mm" H 4838 4100 50  0001 C CNN
F 3 "~" H 4800 4250 50  0001 C CNN
	1    4800 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4400 4800 4950
Connection ~ 4800 4950
Wire Wire Line
	4800 4950 5500 4950
Wire Wire Line
	4800 4100 4800 3850
Connection ~ 4800 3850
$Comp
L Device:C C2
U 1 1 6035F22E
P 5250 4250
F 0 "C2" H 5365 4296 50  0000 L CNN
F 1 "100nF" H 5365 4205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 5288 4100 50  0001 C CNN
F 3 "~" H 5250 4250 50  0001 C CNN
	1    5250 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4400 5500 4400
Connection ~ 5500 4400
Wire Wire Line
	5500 4400 5500 4950
Wire Wire Line
	5250 4100 4800 4100
Connection ~ 4800 4100
Wire Wire Line
	4300 3750 3750 3750
Wire Wire Line
	4300 3000 4300 3750
Wire Wire Line
	3750 3650 4400 3650
$EndSCHEMATC
