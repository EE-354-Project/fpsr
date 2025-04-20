// ---------------------------------------------------------------------------------
//  Module: first_person_second_row_top
//  File name:  first_person_second_row_top.v
// 	By: Andrew Sykes, Wesley Chou
//  Date: 04/14/2025

//  Description: Top file where we instantiate the "fpsr" game
// ---------------------------------------------------------------------------------

// TODO: Add button debouncing (probably using SCEN) <- read up on different button enables

module first_person_second_row_top (
		//MemOE, MemWR, RamCS, 
		QuadSpiFlashCS, // Disable the three memory chips

        ClkPort, Rest, Ack                 // the 100 MHz incoming clock signal
		
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
    always @(posedge board_clk, posedge Reset) begin
        if (Reset)
            DIV_CLK <= 0;
        else
            DIV_CLK <= DIV_CLK + 1;
    end

    /* Use a DIV_CLK to make this the clock speeds slower*/
    assign sys_clk = board_clk;

    // TODO: Possibly use the inc_5s module
    /* Logic to increment I every ~5 seconds */
    wire timer = DIV_CLK[27]; // Is actually about 6.7 Seconds. If needed, change the DIV_CLK.
    always @ (posedge timer, posedge Reset) begin
        if (Reset) I <= 0;
        else if (timer) I <= I + 1;
    end

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
    wire [7:0] minutes;

    first_person_second_row fpsr (
        /* Inputs (to fpsr) */
        .Clk(sys_clk), .Reset(Reset), .Start(BtnC), .Ack(BtnC),
        .Sw0(Sw0), .Sw1(Sw1), .Sw2(Sw2), .Sw3(Sw3),
        .BtnC(BtnC), .BtnL(BtnL), .BtnR(BtnR), .BtnU(BtnU), .BtnD(BtnD),
        .I(I),

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

    // TODO: Add logic for SSDs & LEDs


endmodule