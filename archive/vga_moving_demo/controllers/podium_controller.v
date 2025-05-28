`timescale 1ns / 1ps

module podium_controller(
    input clk,
	input bright,
    input rst,  
    input [9:0] hCount, vCount,
	input [11:0] background,
	output reg [11:0] rgb
   );
	// Wires for detecting if current pixel is within each rectangle
	wire podium_top_fill;
	wire podium_leg_left_fill;
	wire podium_leg_right_fill;

	// Position for the podium (lower left side of the screen)
	reg [9:0] xpos, ypos;
	
	// Define brown color for the podium
	parameter BROWN = 12'b1000_0100_0000; // Brown color (RGB: 8,4,0)
	
	/*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
	will output some data to every pixel and not just the images you are trying to display*/
	always@ (*) begin
    	if(~bright) // Force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		else if (podium_top_fill || podium_leg_left_fill || podium_leg_right_fill) 
			rgb = BROWN; // Display brown for the podium parts
		else	
			rgb = background;
	end
	
	// Define the dimensions for the podium
	parameter TOP_WIDTH = 60;    // Width of the top surface
	parameter TOP_HEIGHT = 10;   // Height of the top surface
	parameter LEG_WIDTH = 15;    // Width of each leg
	parameter LEG_HEIGHT = 40;   // Height of the legs
	
	// Define the dimensions and positions of the podium parts
	// Top surface of the podium (wider rectangle)
	assign podium_top_fill = vCount >= (ypos-TOP_HEIGHT) && vCount <= ypos && 
							hCount >= (xpos-TOP_WIDTH/2) && hCount <= (xpos+TOP_WIDTH/2);
	
	// Left leg of the podium (taller rectangle)
	assign podium_leg_left_fill = vCount >= ypos && vCount <= (ypos+LEG_HEIGHT) && 
								 hCount >= (xpos-TOP_WIDTH/3-LEG_WIDTH/2) && hCount <= (xpos-TOP_WIDTH/3+LEG_WIDTH/2);
	
	// Right leg of the podium (taller rectangle)
	assign podium_leg_right_fill = vCount >= ypos && vCount <= (ypos+LEG_HEIGHT) && 
								  hCount >= (xpos+TOP_WIDTH/3-LEG_WIDTH/2) && hCount <= (xpos+TOP_WIDTH/3+LEG_WIDTH/2);
	
	// Initialize the position of the podium
	always@(posedge clk, posedge rst) begin
		if(rst) begin 
			// Position in the lower left side of the screen
			xpos <= 250; // X position (left side)
			ypos <= 215; // Y position (lower part)
		end
	end
	
endmodule
