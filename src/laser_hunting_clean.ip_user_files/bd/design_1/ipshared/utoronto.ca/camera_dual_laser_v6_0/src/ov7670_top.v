`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/05/23 16:24:31
// Design Name: 
// Module Name: ov7725_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ov7670_top(
input clk50,
input clk25,
input  OV7670_VSYNC,
input  OV7670_HREF,
input  OV7670_PCLK,
output OV7670_XCLK,
output OV7670_SIOC,
inout  OV7670_SIOD,
input [7:0] OV7670_D,

output[3:0] LED,
output[3:0] vga444_red,
output[3:0] vga444_green,
output[3:0] vga444_blue,
output vga_hsync,
output vga_vsync,
input BTNC,
output pwdn,
output reset_out,

input [31:0] x_target,
input [31:0] y_target,
output [31:0] x_actual_green,
output [31:0] y_actual_green,
output [31:0] x_actual_red,
output [31:0] y_actual_red
);
wire [16:0] frame_addr;
wire [16:0] capture_addr;   
//wire  capture_we;  
wire  config_finished;  
wire  resend;        
wire [15:0] frame_pixel;  
wire [15:0]  data_16;
wire [16:0] laser_coordinate_XR, laser_coordinate_XG;
wire [16:0] laser_coordinate_YR, laser_coordinate_YG;

assign pwdn = 0;
assign reset_out = 1;
  
assign  	OV7670_XCLK = clk25;
assign x_actual_green = laser_coordinate_XG;
assign y_actual_green = laser_coordinate_YG;
assign x_actual_red = laser_coordinate_XR;
assign y_actual_red = laser_coordinate_YR;

// The button (BTNC) is used to resend the configuration bits to the camera.
// The button is debounced with a 50 MHz clock
debounce   btn_debounce(
		.clk(clk50),
		.i(BTNC),
		.o(resend)
);

marker_detectionR laserLocation_XYR (
    .clk            (OV7670_PCLK),
    .vsync          (OV7670_VSYNC),
    .address        (capture_addr),
    .frame_pixel    ({data_16[15:12] , data_16[10:7] , data_16[4:1]}),
    .avg_X          (laser_coordinate_XR),
    .avg_Y          (laser_coordinate_YR)
    );

markerCoordinates laserLocation_XYG (
    .clk            (OV7670_PCLK),
    .vsync          (OV7670_VSYNC),
    .address        (capture_addr),
    .frame_pixel    ({data_16[15:12] , data_16[10:7] , data_16[4:1]}),
    .avg_X          (laser_coordinate_XG),
    .avg_Y          (laser_coordinate_YG)
    );
    
 vga444   Inst_vga(
		.clk25       (clk25),
		.vga_red    (vga444_red),
		.vga_green   (vga444_green),
		.vga_blue    (vga444_blue),
		.vga_hsync   (vga_hsync),
		.vga_vsync  (vga_vsync),
		.HCnt       (),
		.VCnt       (),

		.frame_addr   (frame_addr),
		.frame_pixel  (frame_pixel)
 );

// BRAM using memory generator from IP catalog
// dual-port, 16 bits wide, 76800 deep 
  
blk_mem_gen_0 u_frame_buffer (
   .clka(OV7670_PCLK),    // input wire clka
   .wea(1'b1),      // input wire [0 : 0] wea
   .addra(capture_addr),  // input wire [16 : 0] addra
   .dina(data_16),    // input wire [15 : 0] dina
   .clkb(clk25),    // input wire clkb
   .addrb(frame_addr),  // input wire [16 : 0] addrb
   .doutb(frame_pixel)  // output wire [15 : 0] doutb
 );


 ov7670_capture capture(
 		.pclk  (OV7670_PCLK),
 		.vsync (OV7670_VSYNC),
 		.href  (OV7670_HREF),
 		.d     ( OV7670_D),
 		.avg_X(x_actual_red),
 		.avg_Y(y_actual_red),
 		.avg_Xg(x_actual_green),
        .avg_Yg(y_actual_green),
 		.target_x(x_target),
        .target_y(y_target),
 		.addr  (capture_addr),
 		.dout( data_16),
 		.we   ()
 	);
 
I2C_AV_Config IIC(
 		.iCLK   ( clk25),    
 		.iRST_N (! resend),    
 		.Config_Done ( config_finished),
 		.I2C_SDAT  ( OV7670_SIOD),    
 		.I2C_SCLK  ( OV7670_SIOC),
 		.LUT_INDEX (),
 		.I2C_RDATA ()
 		); 


endmodule
