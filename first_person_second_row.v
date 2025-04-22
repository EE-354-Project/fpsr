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
    input Sw0, Sw1, Sw2, Sw3,
    input BtnC, BtnL, BtnR, BtnU, BtnD,
	input [7:0] minutes,


	output q_INI, q_IDLE, q_GAME, q_QUIZ, q_LOSE, q_WIN,
		q_GAME1, q_GAME2, q_GAME3,
		q_GAME1_S1, q_GAME1_S2, q_GAME1_S3,
		q_GAME2_S1, q_GAME2_S2, q_GAME2_S3,
		q_GAME3_S1, q_GAME3_S2, q_GAME3_S3, screen, 
		
	output reg professor,
	output reg [1:0] game_cnt,
	output reg [2:0] lives,
	output reg [3:0] quiz_cnt

);

reg [17:0] state;
assign screen = ((state == GAME) || (state >= GAME1));

assign {q_GAME3_S3, q_GAME3_S2, q_GAME3_S1, q_GAME2_S3, q_GAME2_S2, q_GAME2_S1, q_GAME1_S3, q_GAME1_S2, 
		q_GAME1_S1, q_GAME3, q_GAME2, q_GAME1, q_WIN, q_LOSE, q_QUIZ, q_GAME, q_IDLE, q_INI} = state;


// State machine states
localparam
 INI       = 18'b000000000000000001,  // 2^0  = 1
 IDLE      = 18'b000000000000000010,  // 2^1  = 2
 GAME      = 18'b000000000000000100,  // 2^2  = 4
 QUIZ      = 18'b000000000000001000,  // 2^3  = 8
 LOSE      = 18'b000000000000010000,  // 2^4  = 16
 WIN       = 18'b000000000000100000,  // 2^5  = 32

 // Game States
 GAME1     = 18'b000000000001000000,  // 2^6  = 64
 GAME2     = 18'b000000000010000000,  // 2^7  = 128
 GAME3     = 18'b000000000100000000,  // 2^8  = 256

 GAME1_S1  = 18'b000000001000000000,  // 2^9  = 512
 GAME1_S2  = 18'b000000010000000000,  // 2^10 = 1024
 GAME1_S3  = 18'b000000100000000000,  // 2^11 = 2048

 GAME2_S1  = 18'b000001000000000000,  // 2^12 = 4096
 GAME2_S2  = 18'b000010000000000000,  // 2^13 = 8192
 GAME2_S3  = 18'b000100000000000000,  // 2^14 = 16384

 GAME3_S1  = 18'b001000000000000000,  // 2^15 = 32768
 GAME3_S2  = 18'b010000000000000000,  // 2^16 = 65536
 GAME3_S3  = 18'b100000000000000000;  // 2^17 = 131072

// min_max is used to keep track of how many minutes we are at. So, in the Quiz state, you only have 3 minutes to answer a question
localparam MAX_TIME = 120;
reg [7:0] min_max;

always @(posedge Clk)
begin 
	if (minutes[3:0] == 15) professor <= 1;
	
	if ((state == QUIZ) || (state == INI)) professor <= 0;
end

//start of state machine
always @(posedge Clk, posedge Reset) //asynchronous active_high Reset
 begin  
	   if (Reset) 
	       begin
			   game_cnt <= 2'b00;
			   quiz_cnt <= 4'b0000;
			   lives <= 3'b011;
			   state <= INI;
	       end
       else // under positive edge of the clock
         begin
            case (state) // state and data transfers
                 INI:
					begin
						game_cnt <= 2'b00;
						lives <= 3'b011;
						quiz_cnt <= 4'b0000;

						if (Start) state <= IDLE;
					end
				IDLE:
					begin
						if (BtnC & !professor) state <= GAME;
						else if (professor) begin state <= QUIZ; min_max <= minutes + 3; end 

						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME:
					begin
						if (BtnC & !professor) state <= IDLE;
						else if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						

						// Go to Games
						else if (!professor & game_cnt == 0) state <= GAME1;
						else if (!professor & game_cnt == 1) state <= GAME2;
						else if (!professor & game_cnt == 2) state <= GAME3;

						if (minutes >= MAX_TIME) state <= LOSE;
					end 

				// TODO: Add more quizzes
				// In the Quiz state you do not automatically lose if minutes gets above MAX_TIME
				// So if you are in the final stretch, you have as much time as you need to answer a question
				QUIZ:
					begin
						// """Correctly use the switches to represent binary to equal a specific number"""
						if (quiz_cnt == 0)
						begin
							// """Number == 1"""
							if (Sw0 & !Sw1 & !Sw2 & !Sw3 & BtnC) begin state <= IDLE; quiz_cnt <= quiz_cnt + 1; end
							else if (((Sw1 | Sw2 | Sw3) & BtnC) /*|| (minutes >= min_max)*/)
							begin
								if (lives == 1) state <= LOSE;
								else state <= IDLE;
								lives <= lives - 1;
							end 
						end

						else if (quiz_cnt == 1)
						begin
							// """Number == 2"""
							if (!Sw0 & Sw1 & !Sw2 & !Sw3 & BtnC) begin state <= IDLE; quiz_cnt <= quiz_cnt + 1; end
							else if (((Sw0 | Sw2 | Sw3) & BtnC) || ( min_max >= minutes))
							begin
								if (lives == 1) state <= LOSE;
								else state <= IDLE;
								lives <= lives - 1;
							end 
						end

						else if (quiz_cnt >= 2)
						begin
							// """Number == 8"""
							if (!Sw0 & !Sw1 & !Sw2 & Sw3 & BtnC) begin state <= IDLE; quiz_cnt <= quiz_cnt + 1; end
							else if (((Sw0 | Sw2 | Sw1) & BtnC) || (min_max >= minutes))
							begin
								if (lives == 1) state <= LOSE;
								else state <= IDLE;
								lives <= lives - 1;
							end 
						end
					end


				// TODO: For all of the buttons and switches, make sure that ALL of them are off
				// TODO: Also if you fail, maybe you immediately get quizzed.
				GAME1:
					begin
						if (Sw0 & !Sw1 & !Sw2) state <= GAME1_S1;
						else if (Sw1 | Sw2) state <= IDLE;

						// """There should be some preamble explaining the game,
						//    Game 1 will be flipping the three right switches on in order
						//    and to finish all switches must be turned off

						//    Flip the first switch to continue
						// """
						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME1_S1:
					begin
						if (Sw0 & Sw1 & !Sw2) state <= GAME1_S2;
						else if (!Sw0 | Sw2) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME1_S2:
					begin
						if (Sw0 & Sw1 & Sw2) state <= GAME1_S3;
						else if (!Sw0 | !Sw1) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
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
						if (BtnL & !BtnR & !BtnD) state <= GAME2_S1;
						else if (BtnR | BtnD) state <= IDLE;

						// """There should be some preamble explaining the game,
						//    Game 2 will be memorizing the 3 Btn Presses
						//    BtnL, BtnR, BtnD

						//    (we can make this longer if needed)

						//    Press the first Btn to continue
						// """
						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME2_S1:
					begin
						if (!BtnL & BtnR & !BtnD) state <= GAME2_S2;
						else if (BtnL | BtnD) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME2_S2:
					begin
						if (!BtnL & !BtnR & BtnD) state <= GAME2_S3;
						else if (BtnL | BtnD) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
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
						else if (BtnC && (minutes >= MAX_TIME))
						begin
							state <= LOSE;
						end
						// """Game is completed. Press BtnC to conitnue"""
					end

				GAME3:
					begin
						if (Sw3 & !BtnU & !BtnD & (!BtnL & !BtnR & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S1;

						// This game is a combination of Switches and Buttons
						// The sequence is Sw3, BtnU, BtnD
						// (we can make it longer if needed)
						// Press Sw3 to continue
						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end

				GAME3_S1:
					begin
						if (Sw3 & BtnR & !BtnD & (!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S2;
						else if (!Sw3 | BtnD | !(!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME3_S2:
					begin
						if (Sw3 & !BtnR & BtnD & (!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= GAME3_S3;
						else if (!Sw3 | BtnR | !(!BtnL & !BtnU & !BtnC & !Sw2 & !Sw1 & !Sw0)) state <= IDLE;

						if (professor) begin state <= QUIZ; min_max <= minutes + 3; end
						if (minutes >= MAX_TIME) state <= LOSE;
					end
				GAME3_S3:
					begin
						if (!Sw3 && (minutes < MAX_TIME)) 
						begin
							state <= WIN;
							game_cnt <= game_cnt + 1;
						end
						else if (!Sw3 && (minutes >= MAX_TIME))
						begin
							state <= LOSE;
						end
						// """Game is completed. Turn off the switch to continue"""
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