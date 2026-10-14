`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:57 12/02/2022 
// Design Name: 
// Module Name:    pixcel_generation 
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
module pixcel_generation(
    input [9:0] pixel_x, pixel_y,
    input video_on, clk25m,
    input [2:0] rgb_in,
    output reg [5:0] rgb_out
    );

always @(posedge clk25m)
begin
	if(video_on) begin
		rgb_out[1:0] <= rgb_in[0];
		rgb_out[3:2] <= rgb_in[1];
		rgb_out[5:4] <= rgb_in[2];
	end
	else rgb_out <= 0;
end
endmodule
