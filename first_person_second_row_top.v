// ---------------------------------------------------------------------------------
//  Module: first_person_second_row_top
//  File name:  first_person_second_row_top.v
// 	By: Andrew Sykes, Wesley Chou
//  Date: 04/14/2025

//  Description: Top file where we instantiate the "fpsr" game
// ---------------------------------------------------------------------------------

module first_person_second_row_top (
		//MemOE, MemWR, RamCS, 
		QuadSpiFlashCS, // Disable the three memory chips

        // Reset will be controlled by Sw15 (done in XDC file)
        ClkPort, Reset, Ack                 // the 100 MHz incoming clock signal 
		
		BtnL, BtnU, BtnD, BtnR,            // the Left, Up, Down, and the Right buttons BtnL, BtnR,
		BtnC,                              // the center button (this is our reset in most of our designs)
		Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0, // 8 switches
		Ld7, Ld6, Ld5, Ld4, Ld3, Ld2, Ld1, Ld0, // 8 LEDs
		An3, An2, An1, An0,			       // 4 anodes
		An7, An6, An5, An4,                // another 4 anodes which are not used
		Ca, Cb, Cc, Cd, Ce, Cf, Cg,        // 7 cathodes
		Dp                                 // Dot Point Cathode on SSDs
);

	// Clock & Reset I/O
	input		ClkPort;	
	// Project Specific Inputs
	input		BtnL, BtnU, BtnD, BtnR, BtnC;	
	input		Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;
	
	
	/*  OUTPUTS */
	// Control signals on Memory chips 	(to disable them)
	output QuadSpiFlashCS;
	output 	Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7;
	// SSD Outputs
	output 	Cg, Cf, Ce, Cd, Cc, Cb, Ca, Dp;
	output 	An0, An1, An2, An3;	
	output 	An4, An5, An6, An7;	

	
	/*  LOCAL SIGNALS */
	wire		Reset, ClkPort, Ack;
	wire		board_clk, sys_clk;

    // TODO: Ask TAs about this, I have no idea what this even means
    assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;

    /* board_clk is the buffered (and globally routed) clock that the rest of the design uses */
    BUFGP BUFGP1 (board_clk, ClkPort);

    reg [26:0] DIV_CLK;
    always @(posedge board_clk, posedge Reset, posedge q_INI) begin
        if (Reset | q_INI)
            DIV_CLK <= 0;
        else if (!q_QUIZ) // Pause the timer when student is being quizzed
            DIV_CLK <= DIV_CLK + 1;
    end

    /* Use a DIV_CLK to make this the clock speeds slower*/
    assign sys_clk = board_clk;

    // TODO: Possibly use the inc_5s module
    /* Logic to increment I every ~5 seconds */
    wire timer = DIV_CLK[27]; // Is actually about 6.7 Seconds. If needed, change the DIV_CLK.
    always @ (posedge timer, posedge Reset, posedge q_INI) begin
        if (Reset | q_INI) I <= 0;
        else if (timer) I <= I + 1;
    end


    /* Buttons & Switches! */

    // Declare wire signals for each SCEN output
    wire BtnR_Pulse, BtnL_Pulse, BtnU_Pulse, BtnD_Pulse, BtnC_Pulse;
    wire Sw0_Pulse, Sw1_Pulse, Sw2_Pulse, Sw3_Pulse;

    // Instantiate the debouncers and connect them to the wire signals
    ee354_debouncer #(.N_dc(28)) ee354_debouncer_1 
            (.CLK(sys_clk), .RESET(Reset), .PB(BtnR), .DPB( ), 
            .SCEN(BtnR_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_2 
            (.CLK(sys_clk), .RESET(Reset), .PB(BtnL), .DPB( ), 
            .SCEN(BtnL_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_3 
            (.CLK(sys_clk), .RESET(Reset), .PB(BtnU), .DPB( ), 
            .SCEN(BtnU_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_4 
            (.CLK(sys_clk), .RESET(Reset), .PB(BtnD), .DPB( ), 
            .SCEN(BtnD_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_5 
            (.CLK(sys_clk), .RESET(Reset), .PB(BtnC), .DPB( ), 
            .SCEN(BtnC_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_6 
            (.CLK(sys_clk), .RESET(Reset), .PB(Sw0), .DPB( ), 
            .SCEN(Sw0_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_7 
            (.CLK(sys_clk), .RESET(Reset), .PB(Sw1), .DPB( ), 
            .SCEN(Sw1_Pulse), .MCEN( ), .CCEN( ));

    ee354_debouncer #(.N_dc(28)) ee354_debouncer_8 
            (.CLK(sys_clk), .RESET(Reset), .PB(Sw2), .DPB( ), 
            .SCEN(Sw2_Pulse), .MCEN( ), .CCEN( ));
        
    ee354_debouncer #(.N_dc(28)) ee354_debouncer_9 
            (.CLK(sys_clk), .RESET(Reset), .PB(Sw3), .DPB( ), 
            .SCEN(Sw3_Pulse), .MCEN( ), .CCEN( ));


    /* From fpsr module */
    wire q_INI, q_IDLE, q_GAME, q_QUIZ, q_LOSE, q_WIN;
    wire q_GAME1, q_GAME2, q_GAME3;
    wire q_GAME1_S1, q_GAME1_S2, q_GAME1_S3;
    wire q_GAME2_S1, q_GAME2_S2, q_GAME2_S3;
    wire q_GAME3_S1, q_GAME3_S2, q_GAME3_S3;
    wire screen;
    wire professor;
    wire [1:0] game_cnt;
    wire [2:0] lives;
    wire [3:0] quiz_cnt;

    first_person_second_row fpsr (
        /* Inputs (to fpsr) */
        .Clk(sys_clk), .Reset(Reset), .Start(BtnC_Pulse), .Ack(BtnC_Pulse),  // Debounced BtnC signal
        .Sw0(Sw0_Pulse), .Sw1(Sw1_Pulse), .Sw2(Sw2_Pulse), .Sw3(Sw3_Pulse),  // Debounced switch signals
        .BtnC(BtnC_Pulse), .BtnL(BtnL_Pulse), .BtnR(BtnR_Pulse), .BtnU(BtnU_Pulse), .BtnD(BtnD_Pulse), // Debounced button signals
        .minutes(I),

        /* Outports (from fpsr) */
        // regular states
        .q_INI(q_INI), .q_IDLE(q_IDLE), .q_GAME(q_GAME), .q_QUIZ(q_QUIZ), .q_LOSE(q_LOSE), .q_WIN(q_WIN),

        // game states
        .q_GAME1(q_GAME1), .q_GAME2(q_GAME2), .q_GAME3(q_GAME3),
        .q_GAME1_S1(q_GAME1_S1), .q_GAME1_S2(q_GAME1_S2), .q_GAME1_S3(q_GAME1_S3),
        .q_GAME2_S1(q_GAME2_S1), .q_GAME2_S2(q_GAME2_S2), .q_GAME2_S3(q_GAME2_S3),
        .q_GAME3_S1(q_GAME3_S1), .q_GAME3_S2(q_GAME3_S2), .q_GAME3_S3(q_GAME3_S3),

        // non-state variables
        .screen(screen), .professor(professor), .game_cnt(game_cnt), .lives(lives), .quiz_cnt(quiz_cnt), .minutes(minutes)
    );



    /* LOGIC FOR LEDs & SSDs */
    reg [4:0]   SSD;
	reg [7:0]   SSD_CATHODES;
    wire [3:0]  SSD7, SSD6, SSD5, SSD4, SSD3, SSD2, SSD1, SSD0;

    // LEDs keep track of which state we are in (mostly for debugging)
    assign {Ld0, Ld1, Ld2, Ld3} = {q_IDLE, (q_GAME1 | q_GAME1_S1 | q_GAME1_S2 | q_GAME1_S3), (q_GAME2 | q_GAME2_S1 | q_GAME2_S2 | q_GAME2_S3), (q_GAME3 | q_GAME3_S1 | q_GAME3_S2 | q_GAME3_S3)};
    assign {Ld4, Ld5, Ld6, Ld7} = {(q_GAME1_S1 | q_GAME2_S1 | q_GAME3_S1), (q_GAME1_S2 | q_GAME2_S2 | q_GAME3_S2), (q_GAME1_S3 | q_GAME2_S3 | q_GAME3_S3), q_QUIZ};

    assign ssdscan_clk = DIV_CLK[20:18];

    assign An0 = ~(ssdscan_clk == 3'b000);
    assign An1 = ~(ssdscan_clk == 3'b001);
    assign An2 = ~(ssdscan_clk == 3'b010);
    assign An3 = ~(ssdscan_clk == 3'b011);
    assign An4 = ~(ssdscan_clk == 3'b100);
    assign An5 = ~(ssdscan_clk == 3'b101);
    assign An6 = ~(ssdscan_clk == 3'b110);
    assign An7 = ~(ssdscan_clk == 3'b111);

    // 3 Games Status (light up if game is completed)
    assign SSD7 = (game_cnt < 1) ? 5'b10000 : 5'b01000;
	assign SSD6 = (game_cnt < 2) ? 5'b10000 : 5'b01000;
	assign SSD5 = (game_cnt < 3) ? 5'b10000 : 5'b01000;

    // Game Count
	assign SSD4 = game_cnt;

    // Quiz Count
    assign SSD3 = quiz_cnt;

    // Lives
	assign SSD2 = lives;

    // Minutes
	assign SSD1 = (q_INI) ? 15 : minutes[7:4];
	assign SSD0 = (q_INI) ? 15 : minutes[3:0];

    always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3, SSD4, SSD5, SSD6, SSD7) begin : SSD_SCAN_OUT
        case (ssdscan_clk)
            3'b000: SSD = SSD0;
            3'b001: SSD = SSD1;
            3'b010: SSD = SSD2;
            3'b011: SSD = SSD3;
            3'b100: SSD = SSD4;
            3'b101: SSD = SSD5;
            3'b110: SSD = SSD6;
            3'b111: SSD = SSD7;
        endcase
    end

    assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES};

	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD) // abcdefg,Dp
			// Revise the code below so that the dot points do not glow for your design.
			5'b00000: SSD_CATHODES = 8'b00000010; // 0
			5'b00001: SSD_CATHODES = 8'b10011110; // 1
			5'b00010: SSD_CATHODES = 8'b00100100; // 2
			5'b00011: SSD_CATHODES = 8'b00001100; // 3
			5'b00100: SSD_CATHODES = 8'b10011000; // 4
			5'b00101: SSD_CATHODES = 8'b01001000; // 5
			5'b00110: SSD_CATHODES = 8'b01000000; // 6
			5'b00111: SSD_CATHODES = 8'b00011110; // 7
			5'b01000: SSD_CATHODES = 8'b00000000; // 8
			5'b01001: SSD_CATHODES = 8'b00001000; // 9
			5'b01010: SSD_CATHODES = 8'b00010000; // A
			5'b01011: SSD_CATHODES = 8'b11000000; // B
			5'b01100: SSD_CATHODES = 8'b01100010; // C
			5'b01101: SSD_CATHODES = 8'b10000100; // D
			5'b01110: SSD_CATHODES = 8'b01100000; // E
			5'b01111: SSD_CATHODES = 8'b01110000; // F
            5'b10000: SSD_CATHODES = 8'b11111111; // OFF
			default: SSD_CATHODES  = 8'bXXXXXXXX; // default is not needed as we covered all cases
		endcase
	end	

endmodule