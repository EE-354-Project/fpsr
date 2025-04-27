`timescale 1ns / 1ps

module board_controller(
    input clk,
	input bright,
    input rst,
    input [9:0] hCount, vCount,
	output reg [11:0] rgb
	//output reg [11:0] background
   );
	wire block_fill;

    //these two values dictate the center of the block, incrementing and decrementing them leads the block to move in certain directions
	reg [9:0] xpos, ypos;
	
	parameter GREEN = 12'b0000_1111_0000;
	parameter WHITE = 12'b1111_1111_1111;
	
	/*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
	will output some data to every pixel and not just the images you are trying to display*/
	always@ (*) begin
    	if(~bright )	//force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		else if (block_fill) 
			rgb = GREEN; 
		else	
			rgb = 12'b1111_1111_1111; // White
	end
	
    //the +-90 for the positions give the dimension of the block (i.e. it will be 180 pixels tall and 300 pixels wide)
	assign block_fill=vCount>=(ypos-90) && vCount<=(ypos+90) && hCount>=(xpos-150) && hCount<=(xpos+150);
	
	always@(posedge clk, posedge rst) 
	begin
		if(rst)
		begin 
			//rough values for center of screen
			// xpos<=450;
			// ypos<=250;
            xpos <= 450;
            ypos <= 100;
		end
	end
	
	
endmodule
