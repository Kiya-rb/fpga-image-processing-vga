`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:21 12/02/2022 
// Design Name: 
// Module Name:    vga_sync 
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
module vga_sync(
    input clk,
    output reg [9:0] pixel_x=0, pixel_y=0,
    output reg video_on=1, hsync=1, vsync=1
    );

reg h_video_on=0, v_video_on=0;
always @(posedge clk)
begin
	if(pixel_x<800) pixel_x <= pixel_x + 1;
	if(pixel_x==47) h_video_on <= 1;
	if(pixel_x==47+640) h_video_on <= 0;
	if(pixel_x==47+640+16) hsync <= 0;
	if(pixel_x==47+640+16+96) begin 
		hsync <= 1;
		pixel_x <= 0;
		pixel_y <= pixel_y + 1;
	end
	if(pixel_y==32) v_video_on <= 1;
	if(pixel_y==32+480) v_video_on <= 0;
	if(pixel_y==32+480+10) vsync <= 0;
	if(pixel_y==32+480+10+2) begin
		vsync <= 1;
		pixel_y <= 0;
	end
	if(h_video_on && v_video_on) video_on <= 1;
	else video_on <= 0;
end
endmodule
