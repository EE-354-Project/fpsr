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
module vga_top(
	input ClkPort,
	input left, right, up, down, screen,
	input q_Q1, q_Q2, q_Q3,
    input q_G1, q_G2, q_G3,
	input Reset,
	//VGA signal
	output hSync, vSync, door, seat,
	output [3:0] vgaR, vgaG, vgaB
	);

	wire bright;
	wire[9:0] hc, vc;
	wire[15:0] score;
	wire [3:0] anode;
	wire [11:0] rgb, bc_rgb, fc_rgb, sc_rgb, q1_rgb, q2_rgb, q3_rgb, sq_rgb, sw_rgb, g1_rgb, g2_rgb;
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

	wire [3:0] bg_R, bg_G, bg_B;
	assign bc_rgb = {bg_R, bg_G, bg_B};

	background_vga bg(.ClkPort(ClkPort), .left(left), .right(right), .up(up), .down(down), .Reset(Reset), .hSync(hSync), .vSync(vSync), .vgaR(bg_R), .vgaG(bg_G), .vgaB(bg_B), .bright(bright), .hc(hc), .vc(vc), .character_in_door(door), .character_in_seat(seat), .task_enable_switch(screen));

	// Game Prompts
	g3_controller g3(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(rgb), .en(q_G3), .background(g2_rgb)); // q_G3
	g2_controller g2(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(g2_rgb), .en(q_G2), .background(g1_rgb)); // q_G2
	g1_controller g1(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(g1_rgb), .en(q_G1), .background(sw_rgb)); // q_G1
	sw_off_controller swc(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(sw_rgb), .en(q_G1 | q_G2 | q_G3), .background(sq_rgb));
	sequence_controller sq(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(sq_rgb), .en(q_G1 | q_G2 | q_G3), .background(q3_rgb)); // q_G1, q_G2, q_G3

	// Quiz Prompts
	q3_controller q3(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(q3_rgb), .en(q_Q3), .background(q2_rgb)); // q_Q3
	q2_controller q2(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(q2_rgb), .en(q_Q2), .background(q1_rgb)); // q_Q2
	q1_controller q1(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(q1_rgb), .en(q_Q1), .background(sc_rgb)); // q_Q1
	switch_controller sc(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(sc_rgb), .en(q_Q1 | q_Q2 | q_Q3), .background(fc_rgb)); // enable should be q_QUIZ, q_Q1, q_Q2, q_Q3
	fpsr_controller fc(.clk(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(fc_rgb), .en(q_Q1 | q_Q2 | q_Q3), .background(bc_rgb)); // enable should be "		"
	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];

endmodule
