`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:53 12/03/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    input clk24m,
    input [2:0] rgb_in,
    output [5:0] rgb_out,
	 output hsync, vsync
    );

wire video_on;
wire [9:0] pixel_x, pixel_y;
wire clk25m;

clk instance_name
   (// Clock in ports
    .CLK_IN1(clk24m),      // IN
    // Clock out ports
    .CLK_OUT1(clk25m),     // OUT
    // Status and control signals
    .RESET(RESET),// IN
    .LOCKED(LOCKED));
	 
//assign video_en = video_on;
pixcel_generation(pixel_x, pixel_y, video_on, clk25m, rgb_in, rgb_out);
vga_sync(clk25m, pixel_x, pixel_y, video_on, hsync, vsync);

endmodule
