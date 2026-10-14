`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:22:01 12/05/2022 
// Design Name: 
// Module Name:    Edge_detection 
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
module Median_Filter(
    input clk,
    output reg [7:0] output_data,
    output op_finished,
	 output reg flag=1'b0
    );
	reg [15:0] addr=16'h0000;
	reg [15:0] comp=16'h029F;
	wire [7:0] dout;
	reg [7:0] Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8;
	
	Rom M1 (
  .clka(clk75),
  .addra(addr), 
  .douta(dout) 
	);
	
  ClockManager M2
   (// Clock in ports
    .CLK_IN1(clk),      // IN
    // Clock out ports
    .CLK_OUT1(clk25),     // OUT
    .CLK_OUT2(clk75),     // OUT
    // Status and control signals
    .RESET(1'b0),// IN
    .LOCKED(LOCKED));
	 
	localparam [3:0]
		byte1=4'h0,
		byte2=4'h1,
		byte3=4'h2,
		byte4=4'h3,
		byte5=4'h4,
		byte6=4'h5,
		byte7=4'h6,
		byte8=4'h7,
		byte9=4'h8;
	reg [7:0] pic_mat [2:0][2:0];
	reg [3:0] state=4'h0;
	always @(posedge clk25) begin
		if (LOCKED) begin
			case (state)
				byte1:begin
						state <= byte2;
						addr <= addr + 16'h00E0;
						end
				byte2:begin
						pic_mat[0][0] <= dout;
						state <= byte3;
						addr <= addr + 16'h00E0;
						end
				byte3:begin
						pic_mat[1][0] <= dout;
						state <= byte4;
						addr <= addr - 16'h01C0 + 1'b1;
						end
				byte4:begin
						pic_mat[2][0] <= dout;
						state <= byte5;
						addr <= addr + 16'h00E0;
						end
				byte5:begin
						pic_mat[0][1] <= dout;
						state <= byte6;
						addr <= addr + 16'h00E0;
						end
				byte6:begin
						pic_mat[1][1] <= dout;
						state <= byte7;
						addr <= addr - 16'h01C0 + 1'b1;
						end
				byte7:begin
						if (flag==1'b1) begin
							pic_mat[2][2] <= dout;
							if (pic_mat[0][0]>pic_mat[0][1]) begin
								if (pic_mat[0][1]>pic_mat[0][2]) begin
									Q0 <= pic_mat[0][2];
									Q1 <= pic_mat[0][1];
									Q2 <= pic_mat[0][0];
									end
								else
									if (pic_mat[0][0]>pic_mat[0][2]) begin
										Q0 <= pic_mat[0][1];
										Q1 <= pic_mat[0][2];
										Q2 <= pic_mat[0][0];
										end
									else begin
										Q0 <= pic_mat[0][1];
										Q1 <= pic_mat[0][0];
										Q2 <= pic_mat[0][2];
										end
								end
							else begin
								if (pic_mat[0][0]>pic_mat[0][2]) begin
									Q0 <= pic_mat[0][2];
									Q1 <= pic_mat[0][0];
									Q2 <= pic_mat[0][1];
									end
								else
									if (pic_mat[0][1]>pic_mat[0][2]) begin
										Q0 <= pic_mat[0][0];
										Q1 <= pic_mat[0][2];
										Q2 <= pic_mat[0][1];
										end
									else begin
										Q0 <= pic_mat[0][0];
										Q1 <= pic_mat[0][1];
										Q2 <= pic_mat[0][2];
										end
								end
							if (pic_mat[1][0]>pic_mat[1][1]) begin
								if (pic_mat[1][1]>pic_mat[1][2]) begin
									Q3 <= pic_mat[1][2];
									Q4 <= pic_mat[1][1];
									Q5 <= pic_mat[1][0];
									end
								else
									if (pic_mat[1][0]>pic_mat[1][2]) begin
										Q3 <= pic_mat[1][1];
										Q4 <= pic_mat[1][2];
										Q5 <= pic_mat[1][0];
										end
									else begin
										Q3 <= pic_mat[1][1];
										Q4 <= pic_mat[1][0];
										Q5 <= pic_mat[1][2];
										end
								end
							else begin
								if (pic_mat[1][0]>pic_mat[1][2]) begin
									Q3 <= pic_mat[1][2];
									Q4 <= pic_mat[1][0];
									Q5 <= pic_mat[1][1];
									end
								else
									if (pic_mat[1][1]>pic_mat[1][2]) begin
										Q3 <= pic_mat[1][0];
										Q4 <= pic_mat[1][2];
										Q5 <= pic_mat[1][1];
										end
									else begin
										Q3 <= pic_mat[1][0];
										Q4 <= pic_mat[1][1];
										Q5 <= pic_mat[1][2];
										end
								end
							if (pic_mat[2][0]>pic_mat[2][1]) begin
								if (pic_mat[2][1]>dout) begin
									Q6 <= dout;
									Q7 <= pic_mat[2][1];
									Q8 <= pic_mat[2][0];
									end
								else
									if (pic_mat[2][0]>dout) begin
										Q6 <= pic_mat[2][1];
										Q7 <= dout;
										Q8 <= pic_mat[2][0];
										end
									else begin
										Q6 <= pic_mat[2][1];
										Q7 <= pic_mat[2][0];
										Q8 <= dout;
										end
								end
							else begin
								if (pic_mat[2][0]>dout) begin
									Q6 <= dout;
									Q7 <= pic_mat[2][0];
									Q8 <= pic_mat[2][1];
									end
								else
									if (pic_mat[2][1]>dout) begin
										Q6 <= pic_mat[2][0];
										Q7 <= dout;
										Q8 <= pic_mat[2][1];
										end
									else begin
										Q6 <= pic_mat[2][0];
										Q7 <= pic_mat[2][1];
										Q8 <= dout;
										end
								end	
							end			
						else
							pic_mat[2][1] <= dout;
						state <= byte8;
						addr <= addr + 16'h00E0;
						end
				byte8:begin
						if (flag==1'b1) begin
							if (Q0>Q3) begin
								if (Q3>Q6) begin
									Q0 <= Q6;
									Q3 <= Q3;
									Q6 <= Q0;
									end
								else
									if (Q0>Q6) begin
										Q0 <= Q3;
										Q3 <= Q6;
										Q6 <= Q0;
										end
									else begin
										Q0 <= Q3;
										Q3 <= Q0;
										Q6 <= Q6;
										end
								end
							else begin
								if (Q0>Q6) begin
									Q0 <= Q6;
									Q3 <= Q0;
									Q6 <= Q3;
									end
								else
									if (Q3>Q6) begin
										Q0 <= Q0;
										Q3 <= Q6;
										Q6 <= Q3;
										end
									else begin
										Q0 <= Q0;
										Q3 <= Q3;
										Q6 <= Q6;
										end
								end
							if (Q1>Q4) begin
								if (Q4>Q7) begin
									Q1 <= Q7;
									Q4 <= Q4;
									Q7 <= Q1;
									end
								else
									if (Q1>Q7) begin
										Q1 <= Q4;
										Q4 <= Q7;
										Q7 <= Q1;
										end
									else begin
										Q1 <= Q4;
										Q4 <= Q1;
										Q7 <= Q7;
										end
								end
							else begin
								if (Q1>Q7) begin
									Q1 <= Q7;
									Q4 <= Q1;
									Q7 <= Q4;
									end
								else
									if (Q4>Q7) begin
										Q1 <= Q1;
										Q4 <= Q7;
										Q7 <= Q4;
										end
									else begin
										Q1 <= Q1;
										Q4 <= Q4;
										Q7 <= Q7;
										end
								end
							if (Q2>Q5) begin
								if (Q5>Q8) begin
									Q2 <= Q8;
									Q5 <= Q5;
									Q8 <= Q2;
									end
								else
									if (Q2>Q8) begin
										Q2 <= Q5;
										Q5 <= Q8;
										Q8 <= Q2;
										end
									else begin
										Q2 <= Q5;
										Q5 <= Q2;
										Q8 <= Q8;
										end
								end
							else begin
								if (Q2>Q8) begin
									Q2 <= Q8;
									Q5 <= Q2;
									Q8 <= Q5;
									end
								else
									if (Q5>Q8) begin
										Q2 <= Q2;
										Q5 <= Q8;
										Q8 <= Q5;
										end
									else begin
										Q2 <= Q2;
										Q5 <= Q5;
										Q8 <= Q8;
										end
								end
							pic_mat[0][0] <= pic_mat[0][1];
							pic_mat[1][0] <= pic_mat[1][1];
							pic_mat[2][0] <= pic_mat[2][1];
							pic_mat[0][1] <= pic_mat[0][2];
							pic_mat[1][1] <= pic_mat[1][2];
							pic_mat[2][1] <= pic_mat[2][2];
							end
						pic_mat[0][2] <= dout;
						state <= byte9;
						addr <= addr + 16'h00E0;
						end
				byte9:begin
						if (flag==1'b1) begin
							if (Q0>Q4) begin
								if (Q4>Q8) begin
									output_data <= Q4;
									end
								else
									if (Q0>Q8) begin
										output_data <= Q8;
										end
									else begin
										output_data <= Q0;
										end
								end
							else begin
								if (Q0>Q8) begin
									output_data <= Q0;
									end
								else
									if (Q4>Q8) begin
										output_data <= Q8;
										end
									else begin
										output_data <= Q4;
										end
								end
							end
						pic_mat[1][2] <= dout;
						if (addr==comp) begin
							state <= byte1;
							flag <= 1'b0;
							comp <= comp + 16'h00E0;
							end
						else begin 	
							flag <= 1'b1;
							state <= byte7;
							end
						addr <= addr - 16'h01C0 + 1'b1;
						end
				endcase
			end
		end
endmodule

