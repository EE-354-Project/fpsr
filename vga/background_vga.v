`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    vga_top 
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
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module background_vga(
	input ClkPort,
	input left, right, up, down,
    input Reset,
	//VGA signal
	output hSync, vSync, bright,
	output [3:0] vgaR, vgaG, vgaB,
	output [9:0] hc, vc
	);

	wire [11:0] me_rgb, board_rgb, seats_rgb, podium_rgb, rgb;
	wire rst;
	
	reg [27:0]	DIV_CLK;
	always @ (posedge ClkPort, posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
	  else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	wire move_clk;
	assign move_clk=DIV_CLK[19]; //slower clock to drive the movement of objects on the vga screen
	// Define color parameters
	parameter WHITE = 12'b1111_1111_1111;

	// Set the background color to white
	reg [11:0] background;
	always @(*) begin
		background = WHITE;
	end

	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));
	me_controller mc(.clk(move_clk), .bright(bright), .rst(BtnC), .en(1'b1), .up(up), .down(down),.left(left),.right(right),.hCount(hc), .vCount(vc), .rgb(me_rgb), .background(background));
	seats_controller sc(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(seats_rgb), .background(background));
	podium_controller pc(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(podium_rgb), .background(background));

	// RGB priority logic - implemented as an always block for scalability
	// This can be easily extended when more controllers are added
	reg [11:0] rgb_reg;
	always @(*) begin
		// Default to background color
		rgb_reg = background;
		
		// Apply board RGB if it's not the background color
		if (board_rgb != background)
			rgb_reg = board_rgb;
		
		// Apply seats RGB if it's not the background color
		if (seats_rgb != background)
			rgb_reg = seats_rgb;

		// Apply podium RGB if it's not the background color
		if (podium_rgb != background)
			rgb_reg = podium_rgb;
		
		// Apply block RGB if it's not the background color (**HIGHEST PRIORITY**)
		if (me_rgb != background)
			rgb_reg = me_rgb;
		
		// Future controllers can be added here with appropriate priority
		// Example:
		// if (new_controller_rgb != background)
		//     rgb_reg = new_controller_rgb;
	end
	
	assign rgb = rgb_reg;
	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];

endmodule
