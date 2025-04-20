// ---------------------------------------------------------------------------------
//  Module: first_person_second_row
//  File name:  first_person_second_row.v
// 	By: Andrew Sykes, Wesley Chou
//  Date: 04/14/2025

//  Description:
// ---------------------------------------------------------------------------------

`timescale 1 ns / 100 ps

module first_person_second_row (Reset, Clk, Start, Ack, Ms_of_I, Ns_of_J_Write, I, J);

//inputs and outputs declaration
input BtnC, BtnL, BtnR, BtnD, BtnU, Reset, Clk;
input Start, Ack;
input [3:0] Ms_of_I; // Ms_of_I stands for M[I]; similarly Ns_of_J stands for N[J]
output Ns_of_J_Write;
output [3:0] I, J; //I and J are counters for memory indexing

// TODO: Change state width
reg [17:0] state;

// State machine states
localparam
 INI   = 18'b000000000000000000,
 IDLE  = 18'b100000000000000000,
 GAME  = 18'b010000000000000000,
 QUIZ  = 18'b001000000000000000,
 LOSE  = 18'b000100000000000000,
 WIN   = 18'b000010000000000000,

 // Game States
 GAME1 = 18'b000001000000000000,
 GAME2 = 18'b000000100000000000,
 GAME3 = 18'b000000010000000000,

 GAME1_S1 = 18'b000000001000000000,
 GAME1_S2 = 18'b000000000100000000,
 GAME1_S3 = 18'b000000000010000000,

 GAME2_S1 = 18'b000000000001000000,
 GAME2_S2 = 18'b000000000000100000,
 GAME2_S3 = 18'b000000000000010000,

 GAME3_S1 = 18'b000000000000001000,
 GAME3_S2 = 18'b000000000000000100,
 GAME3_S3 = 18'b000000000000000010;

 
localparam 
 screen = 1'b0, professor = 1'b0, minutes = 7'b0000000, game_cnt = 1'b0, lives = 3'b000,

assign 

//start of state machine
always @(posedge Clk, posedge Reset) //asynchronous active_high Reset
 begin  
	   if (Reset) 
	       begin
	           screen = 1'b0;
			   professor = 1'b0;
			   minutes = 7'b0000000;
			   game_cnt = 1'b0;
			   lives = 3'b000;
			   state <= INI;
	       end
       else // under positive edge of the clock
         begin
            case (state) // state and data transfers
                 INI:
					begin
						screen = 1'b0;
						professor = 1'b0;
						minutes = 7'b0000000;
						game_cnt = 1'b0;
						lives = 3'b000;

						if (Start) state <= IDLE;
					end
				IDLE:
					begin
						if (BtnC & !professor) state <= GAME;
						else if (professor) state <= QUIZ;
					end
				GAME:
					begin
						if (BtnC & !professor) state <= IDLE;
						else if (professor) state <= QUIZ;

						// Go to Games
						else if (!professor & game_cnt == 0) state <= GAME1;
						else if (!professor & game_cnt == 1) state <= GAME2;
						else if (!professor & game_cnt == 2) state <= GAME3;
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
					end
				GAME1_S1:
					begin
						if (Sw0 & Sw1 & !Sw2) state <= GAME1_S2;
						else if (!Sw0 | Sw2) state <= IDLE;
					end
				GAME1_S2:
					begin
						if (Sw0 & Sw1 & Sw2) state <= GAME1_S3;
						else if (!Sw0 | !Sw1) state <= IDLE;
					end
				GAME1_S3:
					begin
						if (!Sw0 & !Sw1 & !Sw2) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
						end

						// """Game is completed. Turn off all switches to continue"""
					end
				default: 
                    begin
                         state <= UNKN;    
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
					end
				GAME2_S1:
					begin
						if (!BtnL & BtnR & !BtnD) state <= GAME2_S2;
						else if (BtnL | BtnD) state <= IDLE;
					end
				GAME2_S2:
					begin
						if (!BtnL & !BtnR & BtnD) state <= GAME2_S3;
						else if (BtnL | BtnD) state <= IDLE;
					end
				GAME2_S3:
					begin
						if (BtnC) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
						end

						// """Game is completed. Press BtnC to conitnue"""
					end

				GAME3:
					begin
						if (Sw3 & !BtnU & !BtnD) state <= GAME3_S1;

						// This game is a combination of Switches and Buttons
						// The sequence is Sw3, BtnU, BtnD
						// (we can make it longer if needed)
						// Press Sw3 to continue
					end

				GAME3_S1:
					begin
						if (Sw3 & BtnR & !BtnD) state <= GAME3_S2;
						else if (!Sw3 | BtnD) state <= IDLE;
					end
				GAME2_S2:
					begin
						if (Sw3 & !BtnR & BtnD) state <= GAME3_S3;
						else if (!Sw3 | BtnR) state <= IDLE;
					end
				GAME2_S3:
					begin
						if (!Sw3) 
						begin
							state <= IDLE;
							game_cnt <= game_cnt + 1;
						end

						// """Game is completed. Turn off the switch to continue"""
					end
				
            endcase
         end   
 end // end of always procedural block 
               
 endmodule