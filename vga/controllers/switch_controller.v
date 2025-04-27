`timescale 1ns / 1ps
module switch_controller(
	input        clk,
	input        bright,
	input        rst,         // you can even drop rst if you don’t need it
	input        en,
	input  [9:0] hCount, vCount,
	input [11:0] background,
	output reg [11:0] rgb
	);

	parameter WHITE   = 12'b1111_1111_1111;
	localparam X0 = 260;
	localparam Y0 = 277;
	localparam W  = 150;
	localparam H  = 11;
	localparam ROW_W = 4, COL_W = 8;

	// combinational “on” window
	wire sprite_on = en && (vCount >= Y0) && (vCount < Y0 + H)
		&& (hCount >= X0) && (hCount < X0 + W);

	// pipeline it one cycle
	reg sprite_on_d = 1'b0;
	always @(posedge clk) begin
		sprite_on_d <= sprite_on;
	end

	// address into the ROM  
	wire [ROW_W-1:0] row_addr = vCount - Y0;
	wire [COL_W-1:0] col_addr = hCount - X0;
	wire [11:0]      color;

	use_switches_rom rom_i (
		.clk        (clk),
		.row        (row_addr),
		.col        (col_addr),
		.color_data (color)
	);

	always @(*) begin
		if (!bright)
		rgb = 12'b0;             // VGA blanking
		else if (sprite_on_d && color != WHITE) 
		begin
            rgb = color;             // your prompt
		end
		else
		rgb = background;           // or whatever background you like
	end

	endmodule
