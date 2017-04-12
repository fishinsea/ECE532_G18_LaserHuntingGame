`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2017 06:17:21 PM
// Design Name: 
// Module Name: markerCoordinates
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

module markerCoordinates(
        input clk,                    //assumed to be the 50 MHz clock driving the camera module
        input vsync,
        input [16:0] address,
        input [11:0] frame_pixel,
        output [16:0] avg_X,
        output [16:0] avg_Y
    );
    
    reg [63:0] frame_avg_X;
    reg [63:0] frame_avg_Y;
    reg [63:0] avg_X_sum;
    reg [63:0] avg_Y_sum;
    reg [63:0] avg_X_handle;
    reg [63:0] avg_Y_handle;
    reg [63:0] sum_X;
    reg [63:0] sum_Y;
    reg [16:0] number_of_pixels;
    reg [31:0] number_of_frames;
    
    assign avg_X = frame_avg_X;
    assign avg_Y = frame_avg_Y;
    
    initial begin
        frame_avg_X = 0;
        frame_avg_Y = 0;
        avg_X_sum = 0;
        avg_Y_sum = 0;
        avg_X_handle = 0;
        avg_Y_handle = 0;
        sum_X = 0;
        sum_Y = 0;
        number_of_pixels = 0;
        number_of_frames = 0;
    end
    
    always @ (posedge clk) begin
        if (vsync == 1) begin // a new frame is processed
            sum_X <= 0;       // set the sum of X and Y coordinates to zero in the beginning
            sum_Y <= 0;
            avg_X_handle = 0; // set the average coordinates of the current frame to zero in the beginning
            avg_Y_handle = 0;
            number_of_pixels <= 0;
        end
        else begin  // within the current process as follow ... 
            if (address < 76800) begin
                //this is where address increments, done in camera module
            end
            else begin  // We are at the end of the frame buffer for the current frame
                if (number_of_frames < 1200) begin              //group every 1200 frames per group
                    number_of_frames = number_of_frames + 1;
                    avg_X_sum = avg_X_handle + avg_X_sum;
                    avg_Y_sum = avg_Y_handle + avg_Y_sum;
                end
                else begin
                    frame_avg_X = avg_X_sum/1200;                //can test out different averaging factors
                    frame_avg_Y = avg_Y_sum/1200;
                    number_of_frames = 0;
                    avg_X_sum = 0;                              //reset the sum of the averages to zero
                    avg_Y_sum = 0;
                end
            end
            // Green Detection
            if (frame_pixel[11:8] == 4'b0111 && frame_pixel[7:4] == 4'b0111 && frame_pixel[3:0] == 4'b0000) begin   //check for post-processed blue pixels
                sum_X = sum_X + (address%320);              //sum_X = sum_X + X;
                sum_Y = sum_Y + (address/240);              //sum_Y = sum_Y + Y;
                number_of_pixels = number_of_pixels + 1;
                avg_X_handle = sum_X / number_of_pixels;
                avg_Y_handle = sum_Y / number_of_pixels;
            end
        end
    end
endmodule