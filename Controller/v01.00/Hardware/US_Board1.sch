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
L Device:C C1
U 1 1 5E3C8CC4
P 3350 2900
F 0 "C1" H 3465 2946 50  0000 L CNN
F 1 "C" H 3465 2855 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3388 2750 50  0001 C CNN
F 3 "~" H 3350 2900 50  0001 C CNN
	1    3350 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5E3C9297
P 4100 2900
F 0 "C2" H 4215 2946 50  0000 L CNN
F 1 "C" H 4215 2855 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 4138 2750 50  0001 C CNN
F 3 "~" H 4100 2900 50  0001 C CNN
	1    4100 2900
	1    0    0    -1  
$EndComp
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
L Connector:AVR-ISP-10 J1
U 1 1 5E3CB7BB
P 7750 2200
F 0 "J1" H 7420 2296 50  0000 R CNN
F 1 "AVR-ISP-10" H 7420 2205 50  0000 R CNN
F 2 "Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical" V 7500 2250 50  0001 C CNN
F 3 " ~" H 6475 1650 50  0001 C CNN
	1    7750 2200
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male Power1
U 1 1 5E3CC021
P 3400 1700
F 0 "Power1" H 3508 1881 50  0000 C CNN
F 1 "Conn_01x02_Male" H 3508 1790 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 3400 1700 50  0001 C CNN
F 3 "~" H 3400 1700 50  0001 C CNN
	1    3400 1700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male I2C_Bus1
U 1 1 5E3CC5F9
P 3550 3750
F 0 "I2C_Bus1" H 3658 4031 50  0000 C CNN
F 1 "Conn_01x04_Male" H 3658 3940 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 3550 3750 50  0001 C CNN
F 3 "~" H 3550 3750 50  0001 C CNN
	1    3550 3750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male US_Sensor1
U 1 1 5E3CCBEB
P 9200 2950
F 0 "US_Sensor1" H 9308 3231 50  0000 C CNN
F 1 "Conn_01x04_Male" H 9308 3140 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 9200 2950 50  0001 C CNN
F 3 "~" H 9200 2950 50  0001 C CNN
	1    9200 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 1700 5600 1700
Wire Wire Line
	5600 1700 5600 2250
Wire Wire Line
	7650 1700 6400 1700
Connection ~ 5600 1700
Wire Wire Line
	8150 2550 8150 2300
$Comp
L MCU_Microchip_ATtiny:ATtiny2313-20PU U1
U 1 1 5E3C7A5C
P 5600 3350
F 0 "U1" H 5600 4631 50  0000 C CNN
F 1 "ATtiny2313-20PU" H 5600 4540 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 5600 3350 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2543-AVR-ATtiny2313_Datasheet.pdf" H 5600 3350 50  0001 C CNN
	1    5600 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 2550 6800 2150
Wire Wire Line
	6800 2150 4700 2150
Wire Wire Line
	4700 2150 4700 2550
Wire Wire Line
	4700 2550 5000 2550
Wire Wire Line
	6800 2550 8150 2550
Wire Wire Line
	3600 1800 4450 1800
Wire Wire Line
	4450 4950 5600 4950
Wire Wire Line
	5600 4950 5600 4450
Wire Wire Line
	3900 2900 3900 2750
Wire Wire Line
	3900 2750 4100 2750
Wire Wire Line
	4100 2750 4600 2750
Wire Wire Line
	4600 2750 4600 2950
Wire Wire Line
	4600 2950 5000 2950
Connection ~ 4100 2750
Wire Wire Line
	3600 2900 3600 2750
Wire Wire Line
	3600 2750 3350 2750
Wire Wire Line
	3350 2750 3350 2650
Wire Wire Line
	3350 2650 4850 2650
Wire Wire Line
	4850 2650 4850 2750
Wire Wire Line
	4850 2750 5000 2750
Connection ~ 3350 2750
Wire Wire Line
	3350 3050 4100 3050
Wire Wire Line
	4100 3000 4150 3000
Wire Wire Line
	4450 1800 4450 3000
Connection ~ 4450 3000
Wire Wire Line
	4450 3000 4450 3950
Wire Wire Line
	6200 3250 6600 3250
Wire Wire Line
	8550 3250 8550 2200
Wire Wire Line
	8550 2200 8150 2200
Wire Wire Line
	6200 3150 8500 3150
Wire Wire Line
	8500 3150 8500 2000
Wire Wire Line
	8500 2000 8150 2000
Wire Wire Line
	6200 3050 6550 3050
Wire Wire Line
	8450 3050 8450 2100
Wire Wire Line
	8450 2100 8150 2100
Wire Wire Line
	9400 3150 9700 3150
Wire Wire Line
	9700 3150 9700 1700
Wire Wire Line
	9700 1700 7650 1700
Connection ~ 7650 1700
Wire Wire Line
	9400 2850 9650 2850
Wire Wire Line
	9650 2850 9650 4950
Connection ~ 5600 4950
Wire Wire Line
	9400 2950 9600 2950
Wire Wire Line
	9600 2950 9600 3950
Wire Wire Line
	9600 3950 6800 3950
Wire Wire Line
	6800 3950 6800 4050
Wire Wire Line
	6800 4050 6200 4050
Wire Wire Line
	9400 3050 9500 3050
Wire Wire Line
	9500 3050 9500 2550
Wire Wire Line
	9500 2550 8300 2550
Wire Wire Line
	8300 2550 8300 2750
Wire Wire Line
	8300 2750 6200 2750
Wire Wire Line
	3750 3950 4450 3950
Connection ~ 4450 3950
Wire Wire Line
	4450 3950 4450 4950
Wire Wire Line
	3750 3650 4900 3650
Wire Wire Line
	4900 3650 4900 4650
Wire Wire Line
	4900 4650 6550 4650
Wire Wire Line
	6550 4650 6550 3050
Connection ~ 6550 3050
Wire Wire Line
	6550 3050 8450 3050
Wire Wire Line
	4850 3750 4850 4700
Wire Wire Line
	4850 4700 6600 4700
Wire Wire Line
	6600 4700 6600 3250
Connection ~ 6600 3250
Wire Wire Line
	6600 3250 8550 3250
Wire Wire Line
	6200 3750 7250 3750
Wire Wire Line
	7250 3750 7250 4350
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
Wire Wire Line
	5600 4950 6300 4950
Connection ~ 7450 4950
Wire Wire Line
	7450 4950 8150 4950
Wire Wire Line
	6200 3850 7100 3850
Wire Wire Line
	7100 3850 7100 4400
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
	8150 4950 9650 4950
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
Wire Wire Line
	6300 4950 7000 4950
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
Wire Wire Line
	6400 1700 5600 1700
$Comp
L Device:Crystal 4MHz1
U 1 1 5E3C8580
P 3750 2900
F 0 "4MHz1" H 3750 3168 50  0000 C CNN
F 1 "Crystal" H 3750 3077 50  0000 C CNN
F 2 "Crystal:Crystal_HC49-U_Vertical" H 3750 2900 50  0001 C CNN
F 3 "~" H 3750 2900 50  0001 C CNN
	1    3750 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3750 4850 3750
Wire Wire Line
	4150 3000 4150 3050
Wire Wire Line
	4150 3050 4100 3050
Connection ~ 4150 3000
Wire Wire Line
	4150 3000 4450 3000
Connection ~ 4100 3050
Wire Wire Line
	7650 2600 7650 2900
Wire Wire Line
	7650 2900 7000 2900
Wire Wire Line
	7000 2900 7000 4950
Connection ~ 7000 4950
Wire Wire Line
	7000 4950 7450 4950
$EndSCHEMATC
