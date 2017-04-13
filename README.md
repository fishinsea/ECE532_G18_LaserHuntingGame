ECE532 2017, G18
Laser Hunting Game

Features:
- Dynamic target-generation scoring
- 2P support with additional green laser
- Responsive audio cues and music
- Adjustable difficulty settings
- Intuitive UI for parsing user commands

Required Hardware:
- Computer with Vivado 2016.2
- Nexys4 DDR Board with UART programming cable
- OV7670 PMod Camera
- Red and/or green laser pointer
- Keyboard for user commands
- Headphones/speakers for audio playback

Instructions:
- download the src folder 
- open laser_hunting_clean.xpr in Vivado 2016.2
- run synthesis, implementation, generate bitstream and export hardware, include bitstream when prompted
- connect board to computer using USB cable
- plug headphones/speakers into audio jack
- plug PMod camera into the JA and JB ports
- connect monitor via VGA cable
- launch SDK and program FPGA using latest version of hardware platform
- link interrupts as the application project, make sure to connect STDIO to Console using COM port
- run laser_hunting.c in the project, the terminal will provide UI instructions in STDOUT


Repository Structure:
- src: the project files
- docs: report, presentation and videos 
- G18_IPSourceFiles: source code for IPs

- src\laser_hunting_clean.sdk\interrupts\src contains c code for the game software
- src\laser_hunting_clean.srcs\sources_1\imports contains the audio ip 
- src\laser_hunting_clean.srcs\sources_1\new contains custom vga controllers for displaying to the screen
- src\laser_hunting_clean.srcs\constrs_1 contains the constraints files complementing the default constraints from the Nexys4 Board files
- G18_IPSourceFiles\Dual_Laser\src\ov7670_capture contains the detection thresholds for color detection
- G18_IPSourceFiles\Dual_Laser\src\marker_detection contains the algorithm for computing the coordinates for the detected lasers

Authors:
Tianyi Yu
Deng Pan
Mingwei Ding
Ming Hsu