`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:00 12/07/2022 
// Design Name: 
// Module Name:    sync 
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
module sync25(
    input clk,
    output reg [9:0] x1=0, y1=0,
    output reg video_on25=1, hsync=1, vsync=1
    );

reg h_video_on=0, v_video_on=0;

always @(posedge clk)
begin
	if(x1<800) x1 <= x1 + 1;
	if(x1==47) h_video_on <= 1;
	if(x1==47+640) h_video_on <= 0;
	if(x1==47+640+16) hsync <= 0;
	if(x1==47+640+16+96)
		begin 
			hsync <= 1;
			x1 <= 0;
			y1 <= y1 + 1;
		end
		
	if(y1==32) v_video_on <= 1;
	if(y1==32+480) v_video_on <= 0;
	if(y1==32+480+10) vsync <= 0;
	if(y1==32+480+10+2) 
		begin
			vsync <= 1;
			y1 <= 0;
		end
		
	if(h_video_on && v_video_on) video_on25 <= 1;
	else video_on25 <= 0;
end
endmodule
