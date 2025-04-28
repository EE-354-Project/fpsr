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
	input BtnC,
	input BtnU,
	input BtnR,
	input BtnL,
	input BtnD,
	input Sw0,  // Switch input for controlling the black rectangle
	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	//SSG signal 
	output An0, An1, An2, An3, An4, An5, An6, An7,
	output Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	
	//output MemOE, MemWR, RamCS,
	output  QuadSpiFlashCS
	);
	wire Reset;
	assign Reset=BtnC;
	wire bright;
	wire[9:0] hc, vc;
	wire[15:0] score;
	wire up,down,left,right;
	wire [3:0] anode;

	wire [11:0] me_rgb, board_rgb, seats_rgb, podium_rgb, rgb, door_rgb, task_rgb, roblox_rgb, kanye_rgb, lebron_rgb, italian_rgb, folt_rgb, chillguy_rgb;
	wire task_enable_switch; // open/close task screen
	wire character_in_door; // wire to connect the in_door signal from me_controller
	wire character_in_seat; // wire to connect the in_seat signal from me_controller
	
	// Store the switch state
	assign task_enable_switch = Sw0;
	wire rst;
	
	reg [3:0]	SSD;
	wire [3:0]	SSD3, SSD2, SSD1, SSD0;
	reg [7:0]  	SSD_CATHODES;
	wire [1:0] 	ssdscan_clk;
	
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
	me_controller mc(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .en(1'b1), .up(BtnU), .down(BtnD),.left(BtnL),.right(BtnR),.hCount(hc), .vCount(vc), .rgb(me_rgb), .background(background), .task_enable_switch(task_enable_switch), .in_door(character_in_door), .in_seat(character_in_seat));
	board_controller bc(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(board_rgb), .background(background));
	seats_controller sc(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(seats_rgb), .background(background));
	podium_controller pc(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(podium_rgb), .background(background));
	door_controller door(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(door_rgb), .background(background));
	task_controller task_ctrl(.clk(move_clk), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(task_rgb), .background(background), .switch_enable(task_enable_switch));
	roblox_controller roblox_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(roblox_rgb), .background(background));
	kanye_controller kanye_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(kanye_rgb), .background(background));
	lebron_controller lebron_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(lebron_rgb), .background(background));
	italian_controller italian_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(italian_rgb), .background(background));
	folt_controller folt_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(folt_rgb), .background(background));
	chillguy_controller chillguy_ctrl(.clk(move_clk), .ClkPort(ClkPort), .bright(bright), .rst(BtnC), .hCount(hc), .vCount(vc), .rgb(chillguy_rgb), .background(background));


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
	
	// disable mamory ports
	//assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;
	assign QuadSpiFlashCS = 1'b1;
	
	//------------
// SSD (Seven Segment Display)
	// reg [3:0]	SSD;
	// wire [3:0]	SSD3, SSD2, SSD1, SSD0;
	
	//SSDs display 
	//to show how we can interface our "game" module with the SSD's, we output the 12-bit rgb background value to the SSD's
	assign SSD3 = 4'b0000;
	assign SSD2 = background[11:8];
	assign SSD1 = background[7:4];
	assign SSD0 = background[3:0];


	// need a scan clk for the seven segment display 
	
	// 100 MHz / 2^18 = 381.5 cycles/sec ==> frequency of DIV_CLK[17]
	// 100 MHz / 2^19 = 190.7 cycles/sec ==> frequency of DIV_CLK[18]
	// 100 MHz / 2^20 =  95.4 cycles/sec ==> frequency of DIV_CLK[19]
	
	// 381.5 cycles/sec (2.62 ms per digit) [which means all 4 digits are lit once every 10.5 ms (reciprocal of 95.4 cycles/sec)] works well.
	
	//                  --|  |--|  |--|  |--|  |--|  |--|  |--|  |--|  |   
    //                    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | 
	//  DIV_CLK[17]       |__|  |__|  |__|  |__|  |__|  |__|  |__|  |__|
	//
	//               -----|     |-----|     |-----|     |-----|     |
    //                    |  0  |  1  |  0  |  1  |     |     |     |     
	//  DIV_CLK[18]       |_____|     |_____|     |_____|     |_____|
	//
	//         -----------|           |-----------|           |
    //                    |  0     0  |  1     1  |           |           
	//  DIV_CLK[19]       |___________|           |___________|
	//

	assign ssdscan_clk = DIV_CLK[19:18];
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	=  !((ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	=  !((ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	// Turn off another 4 anodes
	assign {An7, An6, An5, An4} = 4'b1111;
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
				  2'b00: SSD = SSD0;
				  2'b01: SSD = SSD1;
				  2'b10: SSD = SSD2;
				  2'b11: SSD = SSD3;
		endcase 
	end

	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD) // in this solution file the dot points are made to glow by making Dp = 0
		    //                                                                abcdefg,Dp
			4'b0000: SSD_CATHODES = 8'b00000010; // 0
			4'b0001: SSD_CATHODES = 8'b10011110; // 1
			4'b0010: SSD_CATHODES = 8'b00100100; // 2
			4'b0011: SSD_CATHODES = 8'b00001100; // 3
			4'b0100: SSD_CATHODES = 8'b10011000; // 4
			4'b0101: SSD_CATHODES = 8'b01001000; // 5
			4'b0110: SSD_CATHODES = 8'b01000000; // 6
			4'b0111: SSD_CATHODES = 8'b00011110; // 7
			4'b1000: SSD_CATHODES = 8'b00000000; // 8
			4'b1001: SSD_CATHODES = 8'b00001000; // 9
			4'b1010: SSD_CATHODES = 8'b00010000; // A
			4'b1011: SSD_CATHODES = 8'b11000000; // B
			4'b1100: SSD_CATHODES = 8'b01100010; // C
			4'b1101: SSD_CATHODES = 8'b10000100; // D
			4'b1110: SSD_CATHODES = 8'b01100000; // E
			4'b1111: SSD_CATHODES = 8'b01110000; // F    
			default: SSD_CATHODES = 8'bXXXXXXXX; // default is not needed as we covered all cases
		endcase
	end	
	
	// reg [7:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES};

endmodule
