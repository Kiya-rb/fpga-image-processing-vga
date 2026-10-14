`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:41:16 12/07/2022 
// Design Name: 
// Module Name:    Top 
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
module Top(
	
    input clk24m,
	 input select,
    input [2:0] rgb_in,
    output [5:0] rgb_out,
	 output hsync, vsync
    );

wire video_on25,video_on40;
wire [9:0] x1, y1, x2, y2;
wire clk25m;
wire clk40m;
wire select;

	 
clk_gen clkGen
   (// Clock in ports
    .CLK_IN1(clk24m),      // IN
    // Clock out ports
    .CLK_OUT1(clk25m),     // OUT
    .CLK_OUT2(clk40m),     // OUT
    // Status and control signals
    .RESET(1'b0),// IN
    .LOCKED(LOCKED));
	 


sync25 sync25 (
    .clk(clk25m), 
    .x1(x1), 
    .y1(y1), 
    .video_on25(video_on25), 
    .hsync(hsync), 
    .vsync(vsync)
    );


sync40 sync40 (
    .clk(clk40), 
    .x2(x2), 
    .y2(y2), 
    .video_on40(video_on40), 
    .hsync(hsync), 
    .vsync(vsync)
    );
	 
pixel_gen gen (
    .x1(x1), 
    .y1(y1), 
    .x2(x2), 
    .y2(y2), 
    .video_on1(video_on25), 
	 .video_on2(video_on40)
    .clk25m(clk25m), 
    .clk40m(clk40m), 
    .rgb_in(rgb_in), 
	 .select(select),
    .rgb_out(rgb_out)
    );


endmodule
