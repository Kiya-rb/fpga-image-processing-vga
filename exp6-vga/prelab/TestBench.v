`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:15 12/02/2022
// Design Name:   vga_sync
// Module Name:   D:/IUT/Term 7/FPGA Laboratory/Experiment 6/PreLab_VerilogCode/TestBench.v
// Project Name:  PreLab_VerilogCode
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_sync
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg clk;

	// Outputs
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;
	wire video_on;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y), 
		.video_on(video_on), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
	end
   always #1 clk = ~clk;  
endmodule

