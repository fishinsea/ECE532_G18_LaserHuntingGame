//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Fri Mar 31 14:30:03 2017
//Host        : SFB520WS12 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (BTNC,
    OV7670_D,
    OV7670_HREF,
    OV7670_PCLK,
    OV7670_SIOC,
    OV7670_SIOD,
    OV7670_VSYNC,
    OV7670_XCLK,
    pwdn,
    reset,
    reset_out,
    speaker,
    sys_clock,
    usb_uart_1_rxd,
    usb_uart_1_txd,
    vcc,
    vga444_blue,
    vga444_green,
    vga444_red,
    vga_hsync,
    vga_vsync);
  input BTNC;
  input [7:0]OV7670_D;
  input OV7670_HREF;
  input OV7670_PCLK;
  output OV7670_SIOC;
  inout OV7670_SIOD;
  input OV7670_VSYNC;
  output OV7670_XCLK;
  output pwdn;
  input reset;
  output reset_out;
  output speaker;
  input sys_clock;
  input usb_uart_1_rxd;
  output usb_uart_1_txd;
  output vcc;
  output [3:0]vga444_blue;
  output [3:0]vga444_green;
  output [3:0]vga444_red;
  output vga_hsync;
  output vga_vsync;

  wire BTNC;
  wire [7:0]OV7670_D;
  wire OV7670_HREF;
  wire OV7670_PCLK;
  wire OV7670_SIOC;
  wire OV7670_SIOD;
  wire OV7670_VSYNC;
  wire OV7670_XCLK;
  wire pwdn;
  wire reset;
  wire reset_out;
  wire speaker;
  wire sys_clock;
  wire usb_uart_1_rxd;
  wire usb_uart_1_txd;
  wire vcc;
  wire [3:0]vga444_blue;
  wire [3:0]vga444_green;
  wire [3:0]vga444_red;
  wire vga_hsync;
  wire vga_vsync;

  design_1 design_1_i
       (.BTNC(BTNC),
        .OV7670_D(OV7670_D),
        .OV7670_HREF(OV7670_HREF),
        .OV7670_PCLK(OV7670_PCLK),
        .OV7670_SIOC(OV7670_SIOC),
        .OV7670_SIOD(OV7670_SIOD),
        .OV7670_VSYNC(OV7670_VSYNC),
        .OV7670_XCLK(OV7670_XCLK),
        .pwdn(pwdn),
        .reset(reset),
        .reset_out(reset_out),
        .speaker(speaker),
        .sys_clock(sys_clock),
        .usb_uart_1_rxd(usb_uart_1_rxd),
        .usb_uart_1_txd(usb_uart_1_txd),
        .vcc(vcc),
        .vga444_blue(vga444_blue),
        .vga444_green(vga444_green),
        .vga444_red(vga444_red),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync));
endmodule
