## This file is a general .xdc for the Nexys4 DDR Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Configured for ov7670_top on the NEXYS4 DDR board

## Clock signal
##set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
##create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

#set_property BITSTREAM.General.UnconstrainedPins {Allow} [current_design];
#set_property SEVERITY{Warning} [get_drc_checks NSTD-1];
#set_property SEVERITY{Warning} [get_drc_checks UCIO-1];

##Switches
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { mute }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { trans }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
#set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { transtwo }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]




##Pmod Header JB



set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { speaker }]; #IO_L4N_T0_15 Sch=aud_pwm
set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { vcc }]; #IO_L6P_T0_15 Sch=aud_sd