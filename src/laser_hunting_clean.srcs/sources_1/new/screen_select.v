`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2017 07:33:24 PM
// Design Name: 
// Module Name: compositor
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


module screen_select(
    input clk25,
    input [1:0] select_frame,
    input [3:0] r1,
    input [3:0] g1,
    input [3:0] b1,
    input h1,
    input v1,
    
    input [3:0] r2,
    input [3:0] g2,
    input [3:0] b2,
    input h2,
    input v2,
    
    input [3:0] r3,
    input [3:0] g3,
    input [3:0] b3,
    input h3,
    input v3,
    
    input [3:0] r4,
    input [3:0] g4,
    input [3:0] b4,
    input h4,
    input v4,
        
    output reg[3:0] vga_red,
    output reg[3:0] vga_green,
    output reg[3:0] vga_blue,
    output reg vga_hsync,
    output reg vga_vsync

    );
    
    always @ (posedge clk25) begin
        case (select_frame)
        0: begin
            vga_red <= r1;
            vga_green <= g1;
            vga_blue <= b1;
            vga_hsync <= h1;
            vga_vsync <= v1;
        end
        1: begin
            vga_red <= r2;
            vga_green <= g2;
            vga_blue <= b2;
            vga_hsync <= h2;
            vga_vsync <= v2;
        end
        2: begin
            vga_red <= r3;
            vga_green <= g3;
            vga_blue <= b3;
            vga_hsync <= h3;
            vga_vsync <= v3;        
        end
        3: begin
            vga_red <= r4;
            vga_green <= g4;
            vga_blue <= b4;
            vga_hsync <= h4;
            vga_vsync <= v4;
        end
        default: begin
            vga_red <= r1;
            vga_green <= g1;
            vga_blue <= b1;
            vga_hsync <= h1;
            vga_vsync <= v1;
        end
        endcase
    end
    
endmodule
