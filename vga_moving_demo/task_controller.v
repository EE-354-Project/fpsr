`timescale 1ns / 1ps

module task_controller(
    input clk,
    input bright,
    input rst,
    input [9:0] hCount, vCount,
    input [11:0] background,
    input switch_enable,  // Switch input to control rectangle visibility
    output reg [11:0] rgb
   );
    wire block_fill;

    // Define the dimensions and position for the black rectangle
    // The visible area is from hCount 144-783 (640 pixels wide) and vCount 35-515 (480 pixels high)
    // For a rectangle that's 75% of the screen size:
    parameter RECT_WIDTH = 480;    // 75% of 640 = 480
    parameter RECT_HEIGHT = 360;   // 75% of 480 = 360
    
    // Calculate the starting positions to center the rectangle
    parameter RECT_START_H = 144 + (640 - RECT_WIDTH)/2;   // Center horizontally
    parameter RECT_END_H = RECT_START_H + RECT_WIDTH - 1;
    parameter RECT_START_V = 35 + (480 - RECT_HEIGHT)/2;   // Center vertically
    parameter RECT_END_V = RECT_START_V + RECT_HEIGHT - 1;
    
    // Create the black rectangle in the center of the screen only when switch is enabled
    assign block_fill = switch_enable && (hCount >= RECT_START_H) && (hCount <= RECT_END_H) && 
                       (vCount >= RECT_START_V) && (vCount <= RECT_END_V);
    
    // Gray color for the rectangle
    parameter GRAY = 12'b1000_1000_1000;
    
    always@ (*) begin
    	if (~bright)	//force black if not inside the display area
            rgb = 12'b0000_0000_0000;
        else if (block_fill) 
            rgb = GRAY; 
        else    
            rgb = background; // Use gray background instead of input parameter
    end
    
endmodule
