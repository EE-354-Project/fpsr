`timescale 1ns / 1ps

module me_controller(
	input clk, //this clock must be a slow enough clock to view the changing positions of the objects
	input ClkPort, //faster clock for ROM
	input bright,
	input rst,
	input en,
	input up, input down, input left, input right,
	input [9:0] hCount, vCount,
	input [11:0] background,
	input task_enable_switch, // Input to disable rendering when task controller is active
	output reg [11:0] rgb,
	output reg in_door, // Output signal to indicate when character is inside the door (1 - inside, 0 - outside)
	output reg in_seat // Output signal to indicate when character is inside a target seat (1 - inside, 0 - outside)
   );
	wire [11:0] rom_color_data;
	reg [9:0] xpos, ypos;

	localparam X0 = BASE_X - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2 + SEAT_WIDTH/2 - W/2; // initial x position (center of bottom left seat)
	localparam Y0 = BASE_Y - SEAT_HEIGHT/2 - H/2; // initial y position (center of bottom left seat)
	localparam W  = 32;
	localparam H  = 30;
	localparam ROW_W = 5, COL_W = 5;

	// combinational “on” window
	// Only enable sprite rendering when task_enable_switch is off (0)
	wire sprite_on = en && !task_enable_switch && (vCount >= ypos) && (vCount < ypos + H)
		&& (hCount >= xpos) && (hCount < xpos + W);

	// pipeline it one cycle
	reg sprite_on_d = 1'b0;
	always @(posedge ClkPort) begin
		sprite_on_d <= sprite_on;
	end

	// address into the ROM
	wire [ROW_W-1:0] row_addr = vCount - ypos;
	wire [COL_W-1:0] col_addr = hCount - xpos;

	// Instantiate the ROM module
	steve_rom steve_rom_inst (
		.clk(ClkPort),
		.row(row_addr),
		.col(col_addr),
		.color_data(rom_color_data)
	);
	
	// Output RGB value based on sprite position and ROM data
	always@ (*) begin
		if(~bright)	//force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		else if(sprite_on_d)
			rgb = rom_color_data; // Use color from ROM for other pixels
		else	
			rgb = background;
	end
	
	always@(posedge clk, posedge rst) 
	begin
		if (rst) begin 
			xpos <= X0;
			ypos <= Y0;
		end

		else if (clk && en) begin
			/* Note that the top left of the screen does NOT correlate to vCount=0 and hCount=0. The display_controller.v file has the 
				synchronizing pulses for both the horizontal sync and the vertical sync begin at vcount=0 and hcount=0. Recall that after 
				the length of the pulse, there is also a short period called the back porch before the display area begins. So effectively, 
				the top left corner corresponds to (hcount,vcount)~(144,35). Which means with a 640x480 resolution, the bottom right corner 
				corresponds to ~(783,515).  
			*/
			if (right) begin
				if (xpos < 785)
					xpos<=xpos+1; //change the amount you increment to make the speed faster 
			end
			else if (left) begin
				if (xpos > 150)
					xpos<=xpos-1;
			end
			else if (up) begin
				if (ypos > 34)
					ypos<=ypos-1;
			end
			else if (down) begin
				if (ypos < 514)
					ypos<=ypos+1;
			end
		end
	end
	
    // Door position parameters (from door_controller.v)
    parameter DOOR_WIDTH = 40;
    parameter DOOR_HEIGHT = 80;
    parameter DOOR_LEFT = 784 - DOOR_WIDTH; // Left edge of door (744)
    parameter DOOR_RIGHT = 783; // Right edge of door
    parameter DOOR_TOP = 275 - DOOR_HEIGHT/2; // Top edge of door (235)
    parameter DOOR_BOTTOM = 275 + DOOR_HEIGHT/2; // Bottom edge of door (315)
    
    // Logic to detect if character is inside the door
    // Character is inside if its entire body is within the door rectangle
    wire [9:0] character_right = xpos + W - 1; // Right edge of character
    wire [9:0] character_bottom = ypos + H - 1; // Bottom edge of character
    
    // Seat position parameters (from seats_controller.v)
    parameter SEAT_WIDTH = 45; // Width of each seat
    parameter SEAT_HEIGHT = 45; // Height of each seat
    parameter SEAT_SPACING = 15; // Space between seats
    parameter BASE_X = 450; // Center of the screen horizontally
    parameter BASE_Y = 400; // Near bottom of the screen vertically
    
    // Define the positions of bottom left seat (seat5) and top right seat (seat4)
    // Bottom left seat (seat5)
    parameter SEAT5_LEFT = BASE_X - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2;
    parameter SEAT5_RIGHT = BASE_X - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2 + SEAT_WIDTH;
    parameter SEAT5_TOP = BASE_Y - SEAT_HEIGHT;
    parameter SEAT5_BOTTOM = BASE_Y;
    
    // Top right seat (seat4)
    parameter SEAT4_LEFT = BASE_X + SEAT_WIDTH + (3*SEAT_SPACING)/2;
    parameter SEAT4_RIGHT = BASE_X + SEAT_WIDTH + (3*SEAT_SPACING)/2 + SEAT_WIDTH;
    parameter SEAT4_TOP = BASE_Y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT;
    parameter SEAT4_BOTTOM = BASE_Y - SEAT_HEIGHT - SEAT_SPACING;
    
    // Check if the entire character is inside the door area
    always @(posedge clk) begin
        if (rst) begin
            in_door <= 1'b0;
            in_seat <= 1'b0;
        end
        else begin
            // Character is in door if all four corners are within the door rectangle
            if ((xpos >= DOOR_LEFT) && (character_right <= DOOR_RIGHT) &&
                (ypos >= DOOR_TOP) && (character_bottom <= DOOR_BOTTOM))
                in_door <= 1'b1;
            else
                in_door <= 1'b0;
                
            // Character is in target seat if all four corners are within either the bottom left seat (seat5) or top right seat (seat4)
            if (((xpos >= SEAT5_LEFT) && (character_right <= SEAT5_RIGHT) &&
                 (ypos >= SEAT5_TOP) && (character_bottom <= SEAT5_BOTTOM)) ||
                ((xpos >= SEAT4_LEFT) && (character_right <= SEAT4_RIGHT) &&
                 (ypos >= SEAT4_TOP) && (character_bottom <= SEAT4_BOTTOM)))
                in_seat <= 1'b1;
            else
                in_seat <= 1'b0;
        end
    end
    
endmodule
