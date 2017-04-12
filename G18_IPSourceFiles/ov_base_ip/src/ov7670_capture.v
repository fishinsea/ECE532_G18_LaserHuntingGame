`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/05/23 15:11:30
// Design Name: 
// Module Name: ov7725_capture
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

module ov7670_capture(
    input pclk,
    input vsync,
    input href,
    input[7:0] d,
    input [16:0] avg_X,
    input [16:0] avg_Y,
    input [16:0] target_x,
    input [16:0] target_y,
    input disappear,
    output[16:0] addr,
    output reg[15:0] dout,
    output reg we
);  
    reg [15:0] d_latch;
    reg [16:0] address;
    reg [16:0] address_next; 
    reg [1:0] wr_hold;    
    reg [1:0] cnt;
    
    reg[16:0] address_X;
    reg[16:0] address_Y;
    reg[16:0] X_diff;
    reg[16:0] Y_diff;
    
    initial d_latch = 16'b0;
    initial address = 19'b0;
    initial address_next = 19'b0;
    initial wr_hold = 2'b0;   
    initial cnt = 2'b0;
    initial address_X = 17'b0;
    initial address_Y = 17'b0;
    initial X_diff = 17'b0;
    initial Y_diff = 17'b0;
            
    assign addr = address;
    
    always@(posedge pclk) begin
        if( vsync == 1 ) begin
            address <=17'b0;
            address_next <= 17'b0;
            wr_hold <=  2'b0;
            cnt <=  2'b0;
        end
        else begin
            if (address<76800)  // Check if at end of frame buffer
                address <= address_next;
            else
                address <= 76800;
            // Get 1 byte from camera each cycle.  Have to get two bytes to form a pixel.
            // wr_hold is used to generate the write enable every other cycle.
            // No changes until href = 1 indicating valid data
            we      <= wr_hold[1];  // Set to 1 one cycle after dout is updated
            wr_hold <= {wr_hold[0] , (href &&( ! wr_hold[0])) };
            d_latch <= {d_latch[7:0] , d};
    
            if (wr_hold[1] ==1) begin  // increment write address and output new pixel
            address_next <= address_next+1;
            address_X = address%320;
            address_Y = address/240;
                if ((d_latch[15:12] > 4'b1100)) begin
                    
                    //Computing the difference range
                    if (address_X > avg_X)
                        X_diff = address_X - avg_X;
                    else
                        X_diff = avg_X - address_X;
                                    
                    if (address_Y > avg_Y)
                        Y_diff = address_Y - avg_Y;
                    else
                        Y_diff = avg_Y - address_Y;
                    
                    if ( X_diff < 3 && Y_diff < 3 )
                        dout[15:0] = {5'b0, 6'b111111, 5'b0};
                    else if (address_X >= target_x  && address_X < target_x + 15 && address_Y >= target_y && address_Y < target_y + 15 && disappear == 1'b0)
                        dout[15:0] <= {5'b11111, 6'b0, 5'b0};
                    else
                        dout[15:0] <= {5'b0, 6'b0, 5'b11111};
                end
                else begin
                    //Computing the difference range
                                    if (address_X > avg_X)
                                        X_diff = address_X - avg_X;
                                    else
                                        X_diff = avg_X - address_X;
                                                    
                                    if (address_Y > avg_Y)
                                        Y_diff = address_Y - avg_Y;
                                    else
                                        Y_diff = avg_Y - address_Y;
                                    
                     if ( X_diff < 3 && Y_diff < 3 )
                          dout[15:0] = {5'b0, 6'b111111, 5'b0};
                     else if (address_X >= target_x  && address_X < target_x + 15 && address_Y >= target_y && address_Y < target_y + 15 && disappear == 1'b0)
                        dout[15:0] <= {5'b11111, 6'b0, 5'b0};
                     else
                        dout[15:0] <= {d_latch[15:11] , d_latch[10:5] , d_latch[4:0]};
                end
            end
        end
    end
    
endmodule
