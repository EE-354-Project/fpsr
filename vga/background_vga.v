`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    background_vga
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
    input Reset, task_enable_switch,
	//VGA signal
	output hSync, vSync, bright,
	output character_in_door, character_in_seat,
	output [3:0] vgaR, vgaG, vgaB,
	output [9:0] hc, vc
	);

	wire [11:0] me_rgb, board_rgb, seats_rgb, podium_rgb, rgb, door_rgb, task_rgb, roblox_rgb, kanye_rgb, lebron_rgb, italian_rgb, folt_rgb, chillguy_rgb;
	
	reg [27:0]	DIV_CLK;
	always @ (posedge ClkPort, posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
	  else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	wire move_clk;
	assign move_clk=DIV_CLK[21]; //slower clock to drive the movement of objects on the vga screen
	
	// Define color parameters
	parameter WHITE = 12'b1111_1111_1111;
	parameter GREEN = 12'b0000_1111_0000;

	// Set the background color to white
	reg [11:0] background;
	always @(*) begin
		background = WHITE;
	end

	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));
	me_controller mc(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .en(1'b1), .up(up), .down(down),.left(left),.right(right),.hCount(hc), .vCount(vc), .rgb(me_rgb), .background(background), .task_enable_switch(task_enable_switch), .in_door(character_in_door), .in_seat(character_in_seat));
	board_controller bc(.clk(move_clk), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(board_rgb), .background(background));
	seats_controller sc(.clk(move_clk), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(seats_rgb), .background(background));
	podium_controller pc(.clk(move_clk), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(podium_rgb), .background(background));
	door_controller door(.clk(move_clk), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(door_rgb), .background(background));
	task_controller task_ctrl(.clk(move_clk), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(task_rgb), .background(background), .switch_enable(task_enable_switch));
	roblox_controller roblox_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(roblox_rgb), .background(background));
	kanye_controller kanye_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(kanye_rgb), .background(background));
	lebron_controller lebron_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(lebron_rgb), .background(background));
	italian_controller italian_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(italian_rgb), .background(background));
	folt_controller folt_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(folt_rgb), .background(background));
	chillguy_controller chillguy_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(Reset), .hCount(hc), .vCount(vc), .rgb(chillguy_rgb), .background(background));


	// Logic for the door indicator square
	parameter INDICATOR_SIZE = 20; // Size of the square in pixels
	parameter INDICATOR_X = 750; // X position (right side of screen)
	parameter INDICATOR_Y = 50;  // Y position (top of screen)
	wire indicator_on = character_in_door && 
	                    (hc >= INDICATOR_X) && (hc < INDICATOR_X + INDICATOR_SIZE) && 
	                    (vc >= INDICATOR_Y) && (vc < INDICATOR_Y + INDICATOR_SIZE);
	
	// Logic for the seat indicator square
	parameter SEAT_INDICATOR_X = 700; // X position (right side of screen, left of door indicator)
	parameter SEAT_INDICATOR_Y = 50;  // Y position (top of screen, same height as door indicator)
	parameter BLUE = 12'b0000_0000_1111; // Blue color for seat indicator
	wire seat_indicator_on = character_in_seat && 
	                       (hc >= SEAT_INDICATOR_X) && (hc < SEAT_INDICATOR_X + INDICATOR_SIZE) && 
	                       (vc >= SEAT_INDICATOR_Y) && (vc < SEAT_INDICATOR_Y + INDICATOR_SIZE);
	
	// RGB priority logic - implemented as an always block for scalability
	// This can be easily extended when more controllers are added
	reg [11:0] rgb_reg;
	always @(*) begin
		// Default to background color
		rgb_reg = background;
		
		if (board_rgb != background)
			rgb_reg = board_rgb;
		
		if (seats_rgb != background)
			rgb_reg = seats_rgb;

		if (podium_rgb != background)
			rgb_reg = podium_rgb;
		
		// Add the new sprite controllers with appropriate priority
		if (italian_rgb != background)
			rgb_reg = italian_rgb;
			
		if (folt_rgb != background)
			rgb_reg = folt_rgb;
			
		if (chillguy_rgb != background)
			rgb_reg = chillguy_rgb;
			
		if (roblox_rgb != background)
			rgb_reg = roblox_rgb;
			
		if (lebron_rgb != background)
			rgb_reg = lebron_rgb;
			
		if (kanye_rgb != background)
			rgb_reg = kanye_rgb;
		
		if (task_rgb != background)
			rgb_reg = task_rgb;
		
		if (me_rgb != background)
			rgb_reg = me_rgb;

		if (door_rgb != background)
			rgb_reg = door_rgb;
		
		// Apply the green indicator square with highest priority when character is in door
		if (indicator_on)
			rgb_reg = GREEN;
		
		// Apply the blue indicator square with highest priority when character is in a target seat
		if (seat_indicator_on)
			rgb_reg = BLUE;
	end
	
	assign rgb = rgb_reg;
	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];

endmodule
