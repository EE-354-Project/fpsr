`timescale 1ns / 1ps

module me_controller(
	input clk, //this clock must be a slow enough clock to view the changing positions of the objects
	input bright,
	input rst,
	input en,
	input [9:0] hCount, vCount,
	input [11:0] background,
	output reg [11:0] rgb
   );
	wire [11:0] rom_color_data;
	reg [9:0] xpos, ypos;

	// Define the transparent color (white)
	parameter WHITE = 12'b1111_1111_1111;
	localparam X0 = 450; // initial x position
	localparam Y0 = 250; // initial y position (rough values of center of screen)
	localparam W  = 32;
	localparam H  = 32;
	localparam ROW_W = 5, COL_W = 5;

	// combinational “on” window
	// Only enable sprite rendering when task_enable_switch is off (0)
	wire sprite_on = en && !task_enable_switch && (vCount >= ypos) && (vCount < ypos + H)
		&& (hCount >= xpos) && (hCount < xpos + W);

	// pipeline it one cycle
	reg sprite_on_d = 1'b0;
	always @(posedge ClkPort) begin
		sprite_on_d <= sprite_on;
	end

	// address into the ROM
	wire [ROW_W-1:0] row_addr = vCount - ypos;
	wire [COL_W-1:0] col_addr = hCount - xpos;

	// Instantiate the ROM module
	steve_rom steve_rom_inst (
		.clk(ClkPort),
		.row(row_addr),
		.col(col_addr),
		.color_data(rom_color_data)
	);
	
	// Output RGB value based on sprite position and ROM data
	always@ (*) begin
		if(~bright)	//force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		else if(sprite_on_d && rom_color_data != WHITE) 
			rgb = rom_color_data; // Use color from ROM
		else	
			rgb = background;
	end
   
    
endmodule
