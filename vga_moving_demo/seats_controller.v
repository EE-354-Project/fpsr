`timescale 1ns / 1ps

module seats_controller(
    input clk,
	input bright,
    input rst,
    input [9:0] hCount, vCount,
	input [11:0] background,
	output reg [11:0] rgb
    );
	
	// Define wires for each seat to determine if the current pixel is within a seat
	wire seat1_fill, seat2_fill, seat3_fill, seat4_fill; // First row
	wire seat5_fill, seat6_fill, seat7_fill, seat8_fill; // Second row
	
	// Define the brown color for seats
	parameter BROWN = 12'b1000_0100_0000; // Brown color (RGB: 8,4,0)
	
	// Define seat dimensions
	parameter SEAT_WIDTH = 35; // Width of each seat
	parameter SEAT_HEIGHT = 35; // Height of each seat
	parameter SEAT_SPACING = 15; // Space between seats
	
	// Base positions for the seats (bottom center of the screen)
	reg [9:0] base_x, base_y;
	
	// Initialize base positions
	initial begin
		// Center of the screen horizontally, near bottom vertically
		base_x = 450; // Center of the screen horizontally
		base_y = 400; // Near bottom of the screen vertically
	end
	
	// Define the positions of each seat
	// First row (back row)
	assign seat1_fill = vCount >= (base_y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT) && 
	                   vCount <= (base_y - SEAT_HEIGHT - SEAT_SPACING) && 
	                   hCount >= (base_x - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2) && 
	                   hCount <= (base_x - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2 + SEAT_WIDTH);
	                   
	assign seat2_fill = vCount >= (base_y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT) && 
	                   vCount <= (base_y - SEAT_HEIGHT - SEAT_SPACING) && 
	                   hCount >= (base_x - SEAT_WIDTH - SEAT_SPACING/2) && 
	                   hCount <= (base_x - SEAT_WIDTH - SEAT_SPACING/2 + SEAT_WIDTH);
	                   
	assign seat3_fill = vCount >= (base_y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT) && 
	                   vCount <= (base_y - SEAT_HEIGHT - SEAT_SPACING) && 
	                   hCount >= (base_x + SEAT_SPACING/2) && 
	                   hCount <= (base_x + SEAT_SPACING/2 + SEAT_WIDTH);
	                   
	assign seat4_fill = vCount >= (base_y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT) && 
	                   vCount <= (base_y - SEAT_HEIGHT - SEAT_SPACING) && 
	                   hCount >= (base_x + SEAT_WIDTH + (3*SEAT_SPACING)/2) && 
	                   hCount <= (base_x + SEAT_WIDTH + (3*SEAT_SPACING)/2 + SEAT_WIDTH);
	                   
	// Second row (front row)
	assign seat5_fill = vCount >= (base_y - SEAT_HEIGHT) && 
	                   vCount <= base_y && 
	                   hCount >= (base_x - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2) && 
	                   hCount <= (base_x - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2 + SEAT_WIDTH);
	                   
	assign seat6_fill = vCount >= (base_y - SEAT_HEIGHT) && 
	                   vCount <= base_y && 
	                   hCount >= (base_x - SEAT_WIDTH - SEAT_SPACING/2) && 
	                   hCount <= (base_x - SEAT_WIDTH - SEAT_SPACING/2 + SEAT_WIDTH);
	                   
	assign seat7_fill = vCount >= (base_y - SEAT_HEIGHT) && 
	                   vCount <= base_y && 
	                   hCount >= (base_x + SEAT_SPACING/2) && 
	                   hCount <= (base_x + SEAT_SPACING/2 + SEAT_WIDTH);
	                   
	assign seat8_fill = vCount >= (base_y - SEAT_HEIGHT) && 
	                   vCount <= base_y && 
	                   hCount >= (base_x + SEAT_WIDTH + (3*SEAT_SPACING)/2) && 
	                   hCount <= (base_x + SEAT_WIDTH + (3*SEAT_SPACING)/2 + SEAT_WIDTH);
	
	// RGB output logic
	always@ (*) begin
		if(~bright) // Force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		else if (seat1_fill || seat2_fill || seat3_fill || seat4_fill || 
			    seat5_fill || seat6_fill || seat7_fill || seat8_fill) 
			rgb = BROWN; // Display brown for all seats
		else
			rgb = background; // Otherwise use background color
	end
	
endmodule
