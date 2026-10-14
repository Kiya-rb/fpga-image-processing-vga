`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:30 12/26/2022 
// Design Name: 
// Module Name:    sync40 
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
module sync40(
    input clk,
    output reg [9:0] x2=0, y2=0,
    output reg video_on40=1, hsync=1, vsync=1
    );

reg h_video_on=0, v_video_on=0;

always @(posedge clk)
begin
	if(x2<87+800+40+128) x2 <= x2 + 1;
	if(x2==87) h_video_on <= 1;
	if(x2==87+800) h_video_on <= 0;
	if(x2==87+800+40) hsync <= 0;
	if(x2==87+800+40+128)
		begin 
			hsync <= 1;
			x2 <= 0;
			y2 <= y2 + 1;
		end
		
	if(y2==23) v_video_on <= 1;
	if(y2==23+600) v_video_on <= 0;
	if(y2==23+600+1) vsync <= 0;
	if(y2==23+600+1+4) 
		begin
			vsync <= 1;
			y2 <= 0;
		end
		
	if(h_video_on && v_video_on) video_on40 <= 1;
	else video_on40 <= 0;
end
endmodule

