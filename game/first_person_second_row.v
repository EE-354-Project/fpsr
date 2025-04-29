// ---------------------------------------------------------------------------------
//  Module: first_person_second_row
//  File name:  first_person_second_row.v
// 	By: Andrew Sykes, Wesley Chou
//  Date: 04/14/2025

//  Description: Module with the state machine that controlls the game states
// ---------------------------------------------------------------------------------

`timescale 1 ns / 100 ps

module first_person_second_row (
    input Clk,
    input Reset,
    input Start,
    input Ack,
    input Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7, move, door, seat,
    input BtnC, BtnL, BtnR, BtnU, BtnD,
	input [7:0] minutes,


	output q_INI, q_IDLE, q_GAME, q_MOVE, q_QUIZ, q_QUIZ_1, q_QUIZ_2, q_QUIZ_3, q_LOSE, q_WIN,
		q_GAME1, q_GAME2, q_GAME3,
		q_GAME1_S1, q_GAME1_S2, q_GAME1_S3,
		q_GAME2_S1, q_GAME2_S2, q_GAME2_S3,
		q_GAME3_S1, q_GAME3_S2, q_GAME3_S3, screen, 
		
	output professor,
	output reg [1:0] game_cnt,
	output reg [2:0] lives,
	output reg [3:0] quiz_cnt

);

reg flag;
reg [21:0] state;

// Only allow movement when 1 hr has passed or when we complete all of the games
assign move_en = (minutes >= 60 || game_cnt >= 3);

reg game_en;

assign {
    q_GAME3_S3, q_GAME3_S2, q_GAME3_S1,
    q_GAME2_S3, q_GAME2_S2, q_GAME2_S1,
    q_GAME1_S3, q_GAME1_S2, q_GAME1_S1,
    q_GAME3,    q_GAME2,    q_GAME1,
    q_WIN,      q_LOSE,
    q_QUIZ_3,   q_QUIZ_2,   q_QUIZ_1,   q_QUIZ,
    q_GAME,     q_MOVE,     q_IDLE,     q_INI
} = state;


// State machine states
localparam
  INI       = 22'b0000000000000000000001, // bit  0
  IDLE      = 22'b0000000000000000000010, // bit  1
  MOVE      = 22'b0000000000000000000100, // bit  2
  GAME      = 22'b0000000000000000001000, // bit  3

  QUIZ      = 22'b0000000000000000010000, // bit  4
  QUIZ_1    = 22'b0000000000000000100000, // bit  5
  QUIZ_2    = 22'b0000000000000001000000, // bit  6
  QUIZ_3    = 22'b0000000000000010000000, // bit  7

  LOSE      = 22'b0000000000000100000000, // bit  8
  WIN       = 22'b0000000000001000000000, // bit  9

  GAME1     = 22'b0000000000010000000000, // bit 10
  GAME2     = 22'b0000000000100000000000, // bit 11
  GAME3     = 22'b0000000001000000000000, // bit 12

  GAME1_S1  = 22'b0000000010000000000000, // bit 13
  GAME1_S2  = 22'b0000000100000000000000, // bit 14
  GAME1_S3  = 22'b0000001000000000000000, // bit 15

  GAME2_S1  = 22'b0000010000000000000000, // bit 16
  GAME2_S2  = 22'b0000100000000000000000, // bit 17
  GAME2_S3  = 22'b0001000000000000000000, // bit 18

  GAME3_S1  = 22'b0010000000000000000000, // bit 19
  GAME3_S2  = 22'b0100000000000000000000, // bit 20
  GAME3_S3  = 22'b1000000000000000000000; // bit 21

// min_max is used to keep track of how many minutes we are at. So, in the Quiz state, you only have 3 minutes to answer a question
localparam MAX_TIME = 120;
reg [7:0] min_max;
assign screen = ((state == GAME) || (state >= GAME1));

assign professor = (minutes[3:0] == 4'b1111);

//start of state machine
always @(posedge Clk, posedge Reset) //asynchronous active_high Reset
 begin  
	   if (Reset) 
	       begin
			   game_cnt <= 2'b00;
			   quiz_cnt <= 4'b0000;
			   lives <= 3'b011;
			   flag <= 1'bx; // Used in Quiz states
			   state <= INI;
			   game_en <= 1'bx;
	       end
       else // under positive edge of the clock
         begin
			// Professor update
            case (state) // state and data transfers
                 INI:
					begin
						game_cnt <= 2'b00;
						lives <= 3'b001;
						quiz_cnt <= 4'b0000;
						flag <= 1'b0;
						game_en <= 1'b1;

						if (Start) state <= IDLE;
					end
				IDLE:
					begin
						if (BtnC & !professor & game_en) state <= GAME;
						else if (professor) begin state <= QUIZ; min_max <= minutes + 10; end 
						else if ((!BtnC & !professor & move) & move_en) state <= MOVE;

						if (minutes >= MAX_TIME) state <= LOSE;

					end
				GAME:
					begin
						if (BtnC & !professor) state <= IDLE;
						else if (professor) begin state <= QUIZ; min_max <= minutes + 10; end

						// Go to Games
						else if (!professor & (game_cnt == 0)) state <= GAME1;
						else if (!professor & (game_cnt == 1)) state <= GAME2;
						else if (!professor & (game_cnt == 2)) state <= GAME3;

						if (minutes >= MAX_TIME) state <= LOSE;
					end 

				// In the Quiz state you do not automatically lose if minutes gets above MAX_TIME
				// So if you are in the final stretch, you have as much time as you need to answer a question
				QUIZ:
					begin
						// """Correctly use the switches to represent binary to equal a specific number"""
						if (quiz_cnt == 0) state <= QUIZ_1;

						else if (quiz_cnt == 1) state <= QUIZ_2;

						else if (quiz_cnt >= 2) state <= QUIZ_3;

						if (!seat) lives <= lives - 1;
					end
				QUIZ_1:
					begin
						// Submit correct answer: pattern was latched and switches now cleared + BtnC
						if (flag && BtnC && {Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'b00000000) begin
						state    <= IDLE;
						quiz_cnt <= quiz_cnt + 1;
						flag     <= 1'b0;
						end
						// Latch that the student has set the correct pattern
						else if ({Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'b11010011) begin
						flag <= 1'b1;
						end
						// Wrong answer: BtnC pressed before the pattern was latched
						else if (!flag && BtnC) begin
						if (lives == 1) state <= LOSE;
						else             state <= IDLE;
						lives <= lives - 1;
						end
					end

				QUIZ_2: 
					begin
						if (flag && BtnC && {Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'b00000000) begin
							state      <= IDLE;
							quiz_cnt   <= quiz_cnt + 1;
							flag       <= 1'b0;
						end
						else if ({Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'hA4) begin
							flag       <= 1'b1;
						end
						else if (!flag && (BtnC && {Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} != 8'hA4 || minutes >= min_max)) begin
							if (lives == 1) state <= LOSE;
							else            state <= IDLE;
							lives <= lives - 1;
						end
					end

				QUIZ_3: 
					begin
						if (flag && BtnC && {Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'b00000000) begin
							state      <= IDLE;
							quiz_cnt   <= quiz_cnt + 1;
							flag       <= 1'b0;
						end
						else if ({Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} == 8'd49) begin
							flag       <= 1'b1;
						end
						else if (!flag && (BtnC && {Sw7,Sw6,Sw5,Sw4,Sw3,Sw2,Sw1,Sw0} != 8'd49
										|| minutes >= min_max)) begin
							if (lives == 1) state <= LOSE;
							else           state <= IDLE;
							lives <= lives - 1;
						end
					end


				GAME1:
					begin
						if (Sw0 & !Sw1 & !Sw2) state <= GAME1_S1;
						else if (Sw1 | Sw2 | BtnC) state <= IDLE;

						// """There should be some preamble explaining the game,
						//    Game 1 will be flipping the three right switches on in order
						//    and to finish all switches must be turned off

						//    Flip the first switch to continue
						// """
						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME1_S1:
					begin
						if (Sw0 & Sw1 & !Sw2) state <= GAME1_S2;
						else if (!Sw0 | Sw2 | BtnC) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME1_S2:
					begin
						if (Sw0 & Sw1 & Sw2) state <= GAME1_S3;
						else if (!Sw0 | !Sw1 | BtnC) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME1_S3:
					begin
						if ((!Sw0 & !Sw1 & !Sw2) && (minutes < MAX_TIME)) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
						end
						else if ((!Sw0 & !Sw1 & !Sw2) && (minutes >= MAX_TIME))
						begin
							state <= LOSE;
						end
						// """Game is completed. Turn off all switches to continue"""
					end

				GAME2:
					begin
						if (BtnL & !BtnR & !BtnD & !BtnC) state <= GAME2_S1;
						else if (BtnR | BtnD | BtnC) state <= IDLE;

						// """There should be some preamble explaining the game,
						//    Game 2 will be memorizing the 3 Btn Presses
						//    BtnL, BtnR, BtnD

						//    (we can make this longer if needed)

						//    Press the first Btn to continue
						// """
						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME2_S1:
					begin
						if (!BtnL & BtnR & !BtnD & !BtnC) state <= GAME2_S2;
						else if (BtnL | BtnD | BtnC) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME2_S2:
					begin
						if (!BtnL & !BtnR & BtnD) state <= GAME2_S3;
						else if (BtnL | BtnD | BtnC) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME2_S3:
					begin
						// In the last states of the game, you are alloewd to avoid being instantly pulled by the professor to the quiz state
						if (BtnC && (minutes < MAX_TIME)) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
						end
						else if (BtnD && (minutes >= MAX_TIME))
						begin
							state <= LOSE;
						end
						// """Game is completed. Press BtnC to conitnue"""
					end

				GAME3:
					begin
						if (Sw3 & !BtnU & !BtnD & (!BtnL & !BtnR & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S1;
						else if (!(!BtnU & !BtnD & (!BtnL & !BtnR & !BtnC & !Sw2 & !Sw1 & !Sw0))) state <= IDLE;

						// This game is a combination of Switches and Buttons
						// The sequence is Sw3, BtnU, BtnD
						// (we can make it longer if needed)
						// Press Sw3 to continue
						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end

				GAME3_S1:
					begin
						if (Sw3 & BtnR & !BtnD & (!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S2;
						else if (!Sw3 | BtnD | !(!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME3_S2:
					begin
						if (Sw3 & !BtnR & BtnD & (!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S3;
						else if (!Sw3 | BtnR | !(!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME3_S3:
					begin
						if (!Sw3 && (minutes < MAX_TIME)) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
							game_en <= 1'b0;
						end
						else if (!Sw3 && (minutes >= MAX_TIME))
						begin
							state <= LOSE;
						end
						// """Game is completed. Turn off the switch to continue"""
					end
				MOVE:
					begin
						if (!move) state <= IDLE;
						else if (door) state <= WIN;

						if (professor) begin state <= QUIZ; min_max <= minutes + 10; end
					end
				WIN:
				begin
					if (Ack) state <= INI;
				end
				LOSE:
				begin
					if (Ack) state <= INI;
				end
				
            endcase
         end   
 end // end of always procedural block 
               
 endmodule