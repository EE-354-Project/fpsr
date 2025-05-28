`timescale 1ns / 1ps

module door_controller(
    input clk,
    input bright,
    input rst,  
    input [9:0] hCount, vCount,
    input [11:0] background,
    output reg [11:0] rgb
   );
    wire block_fill;

    // Define the position of the exit door on the right side of the screen
    // The visible area is from hCount 144-783 and vCount 35-515
    parameter DOOR_WIDTH = 40;    // Width of the door
    parameter DOOR_HEIGHT = 80;  // Height of the door (vertical rectangle)
    
    // Gray color for the exit door
    parameter GRAY = 12'b0111_0111_0111;
    
    /*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
    will output some data to every pixel and not just the images you are trying to display*/
    always@ (*) begin
    	if(~bright )	//force black if not inside the display area
            rgb = 12'b0000_0000_0000;
        else if (block_fill) 
            rgb = GRAY; 
        else    
            rgb = background;
    end
    
    // Create the exit door on the right edge of the screen
    // The door is positioned vertically in the center of the right side
    assign block_fill = (hCount >= (784 - DOOR_WIDTH)) && (hCount <= 783) && 
                       (vCount >= (275 - DOOR_HEIGHT/2)) && (vCount <= (275 + DOOR_HEIGHT/2));
    
endmodule
