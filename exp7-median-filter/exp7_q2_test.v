`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:12:59 12/19/2022
// Design Name:   top
// Module Name:   C:/Users/rabba/Uni/401-402 1/Labs/FPGA Lab/EXP7/exp7_imageProcessing_Median/exp7_q2_test.v
// Project Name:  exp7_imageProcessing_Median
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module exp7_q2_test;

	// Inputs
	reg clk;

	// Outputs
	wire v_sync;
	wire h_sync;
	wire [7:0] vga_out;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.v_sync(v_sync), 
		.h_sync(h_sync), 
		.vga_out(vga_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
always #20.83 clk = ~clk;
      
endmodule

