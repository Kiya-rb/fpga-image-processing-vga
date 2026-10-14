`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:52 12/07/2022 
// Design Name: 
// Module Name:    pixel_gen 
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
module pixel_gen(
    input [9:0] x1, y1, x2, y2,
    input video_on1, video_on2, clk25m, clk40m,
    input [2:0] rgb_in,
	 input select,
    output reg [5:0] rgb_out 
    );
	 
initial
begin
rgb_out = 0;
end

reg [15:0] addra;
wire [2:0] douta;
reg en;

always @(posedge clk_main) begin
	if(select == 0)begin
		if (pixel_x>= 208 && pixel_x< 432 && pixel_y >= 128 && pixel_y < 352) begin
		addra <= 224*(pixel_y - 128) + pixel_x- 208;
		en <= 1;
	end
	else
		en <= 0;
	end
end

always @(*)
begin


//	if(video_on) begin
//		rgb_out[1:0] <= rgb_in[0];
//		rgb_out[3:2] <= rgb_in[1];
//		rgb_out[5:4] <= rgb_in[2];
//	end
//	else rgb_out <= 0; //q1

//	if(video_on)
//		begin
//		
//		if(pixel_x > 47 && pixel_x < 139) //grey 
//				begin
//				rgb_out[3:2] <= 1;
//				rgb_out[1:0] <= 1;
//				rgb_out[5:4] <= 1;
//				end
//		 if(pixel_x > 138 && pixel_x < 230) //yellow 
//				begin
//				rgb_out[3:2] <= 1;
//				rgb_out[1:0] <= 1;
//				rgb_out[5:4] <= 0;
//				end
//		 if(pixel_x > 229 && pixel_x < 321) //cyan
//				begin
//				rgb_out[1:0] <= 0;
//				rgb_out[3:2] <= 1;
//				rgb_out[5:4] <= 1;
//				end
//		if(pixel_x > 320 && pixel_x < 412) //green
//				begin
//				rgb_out[3:2] <= 1;
//				rgb_out[1:0] <= 0;
//				rgb_out[5:4] <= 0;
//				end
//		if(pixel_x > 411 && pixel_x < 503) //magenta
//				begin
//				rgb_out[3:2] <= 0;
//				rgb_out[1:0] <= 1;
//				rgb_out[5:4] <= 1;
//				end
//		if(pixel_x > 502 && pixel_x < 594) //red
//				begin
//				rgb_out[3:2] <= 0;
//				rgb_out[1:0] <= 1;
//				rgb_out[5:4] <= 0;
//				end	
//		if(pixel_x > 593 && pixel_x < 688) //blue
//				begin
//				rgb_out[3:2] <= 0;
//				rgb_out[1:0] <= 0;
//				rgb_out[5:4] <= 1;
//				end
//		end
//		else 
//			rgb_out[5:0] <= 0; //q2

	/*if (video_on)begin		
		if(((pixel_x - 48)/80)%2 == 0 && ((pixel_y-10)/60)%2 == 0)begin
			rgb_out[3:2] <= 1;
			rgb_out[1:0] <= 1;
			rgb_out[5:4] <= 1;
		end
		else if(((pixel_x - 48)/80)%2 == 1 && ((pixel_y-10)/60)%2 == 1)begin
			rgb_out[3:2] <= 1;
			rgb_out[1:0] <= 1;
			rgb_out[5:4] <= 1;
		end
		else begin
			rgb_out[3:2] <= 0;
			rgb_out[1:0] <= 0;
			rgb_out[5:4] <= 0;
		end		
	end
	else begin
		rgb_out[3:2] <= 0;
		rgb_out[1:0] <= 0;
		rgb_out[5:4] <= 0;
	end*/
	
	
	if(video_on)begin 
		if(en)begin
			rgb_out[3:2] = douta[1];
			rgb_out[1:0] = douta[0];
			rgb_out[5:4] = douta[2];
		end	
	end
	else begin
		rgb_out[3:2] = 0;
		rgb_out[1:0] = 0;
		rgb_out[5:4] = 0;
	end
end

image_rom image(
  .clka(clk25m), // input clka
  .addra(addra), // input [15 : 0] addra
  .douta(douta) // output [2 : 0] douta
);

wire clk_main;
wire select;


BUFGMUX(clk_main , clk25m , clk40m , select);

endmodule
