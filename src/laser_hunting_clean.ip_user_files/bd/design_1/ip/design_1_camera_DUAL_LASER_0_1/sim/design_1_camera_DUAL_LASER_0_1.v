// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: utoronto.ca:user:camera_DUAL_LASER:6.0
// IP Revision: 3

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_camera_DUAL_LASER_0_1 (
  clk50,
  clk25,
  OV7670_VSYNC,
  OV7670_HREF,
  OV7670_PCLK,
  OV7670_XCLK,
  OV7670_SIOC,
  OV7670_SIOD,
  OV7670_D,
  LED,
  vga444_red,
  vga444_green,
  vga444_blue,
  vga_hsync,
  vga_vsync,
  BTNC,
  pwdn,
  reset_out,
  x_target,
  y_target,
  x_actual_green,
  y_actual_green,
  x_actual_red,
  y_actual_red
);

input wire clk50;
input wire clk25;
input wire OV7670_VSYNC;
input wire OV7670_HREF;
input wire OV7670_PCLK;
output wire OV7670_XCLK;
output wire OV7670_SIOC;
inout wire OV7670_SIOD;
input wire [7 : 0] OV7670_D;
output wire [3 : 0] LED;
output wire [3 : 0] vga444_red;
output wire [3 : 0] vga444_green;
output wire [3 : 0] vga444_blue;
output wire vga_hsync;
output wire vga_vsync;
input wire BTNC;
output wire pwdn;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_out RST" *)
output wire reset_out;
input wire [31 : 0] x_target;
input wire [31 : 0] y_target;
output wire [31 : 0] x_actual_green;
output wire [31 : 0] y_actual_green;
output wire [31 : 0] x_actual_red;
output wire [31 : 0] y_actual_red;

  ov7670_top inst (
    .clk50(clk50),
    .clk25(clk25),
    .OV7670_VSYNC(OV7670_VSYNC),
    .OV7670_HREF(OV7670_HREF),
    .OV7670_PCLK(OV7670_PCLK),
    .OV7670_XCLK(OV7670_XCLK),
    .OV7670_SIOC(OV7670_SIOC),
    .OV7670_SIOD(OV7670_SIOD),
    .OV7670_D(OV7670_D),
    .LED(LED),
    .vga444_red(vga444_red),
    .vga444_green(vga444_green),
    .vga444_blue(vga444_blue),
    .vga_hsync(vga_hsync),
    .vga_vsync(vga_vsync),
    .BTNC(BTNC),
    .pwdn(pwdn),
    .reset_out(reset_out),
    .x_target(x_target),
    .y_target(y_target),
    .x_actual_green(x_actual_green),
    .y_actual_green(y_actual_green),
    .x_actual_red(x_actual_red),
    .y_actual_red(y_actual_red)
  );
endmodule
