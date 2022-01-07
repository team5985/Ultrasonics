# Ultrasonics
Ultrasonic hardware and software

This contains the design files for the ultrasonics circuit boards, as well as the software for the microcontroller.

* Hardware
These are the project files from KiCAD and include the circuit diagramme, netlist, and PCB layout. The Gerber directory
contains the final output that was sent to the PCB manufacturer to have the boards made. This should be openable as a
project from within KiCAD.

* Software
These are the project files from AVR Studio (or ATMEL Studio, or Microchip Studio) and contain the setup required to
compile, emulate and debug the microcontroller code. This should be able to be opened by AVR Studio as a project and
used immediately. The main file in this is "main.asm" which is the actual code for the microcontroller, the remaining
files are merely configuration.
