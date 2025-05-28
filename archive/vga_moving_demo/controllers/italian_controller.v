`timescale 1ns / 1ps

module italian_controller(
    input clk,
    input ClkPort, //faster clock for ROM
    input bright,
    input rst,
    input [9:0] hCount, vCount,
    input [11:0] background,
    output reg [11:0] rgb
);
    wire [11:0] rom_color_data;
    
    // Define position and dimensions
    // Seat 1 (top row, leftmost)
    parameter SEAT_WIDTH = 45;
    parameter SEAT_HEIGHT = 45;
    parameter SEAT_SPACING = 15;
    parameter BASE_X = 450;
    parameter BASE_Y = 400;
    
    // Position in seat 1 (top row, leftmost)
    parameter XPOS = BASE_X - 2*SEAT_WIDTH - (3*SEAT_SPACING)/2 + SEAT_WIDTH/2 - 16; // Center in seat 1
    parameter YPOS = BASE_Y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT/2 - 16; // Center in top row
    parameter W = 32; // Width of sprite
    parameter H = 32; // Height of sprite
    
    // ROM dimensions
    localparam ROW_W = 6, COL_W = 5;
    
    // Determine if current pixel is within sprite area
    wire sprite_on = bright && (vCount >= YPOS) && (vCount < YPOS + H) && 
                    (hCount >= XPOS) && (hCount < XPOS + W);
    
    // Pipeline sprite_on signal for proper timing
    reg sprite_on_d = 1'b0;
    always @(posedge ClkPort) begin
        sprite_on_d <= sprite_on;
    end
    
    // Calculate ROM addresses
    wire [ROW_W-1:0] row_addr = vCount - YPOS;
    wire [COL_W-1:0] col_addr = hCount - XPOS;
    
    // Instantiate the ROM
    italian_rom italian_rom_inst (
        .clk(ClkPort),
        .row(row_addr),
        .col(col_addr),
        .color_data(rom_color_data)
    );
    
    // Extract color components
    wire [3:0] red = rom_color_data[11:8];
    wire [3:0] green = rom_color_data[7:4];
    wire [3:0] blue = rom_color_data[3:0];
    
    // Output RGB value
    always @(*) begin
        if(~bright) // Force black if not in display area
            rgb = 12'b0000_0000_0000;
        else if(sprite_on_d) begin
            
            // Filter out magenta colors - check if red and blue are dominant compared to green
            if((red > green + 4'b0011) && (blue > green + 4'b0001))
                rgb = background; // Transparent if magenta (red and blue dominant, low green)
            else
                rgb = rom_color_data;
        end
        else
            rgb = background;
    end
    
endmodule
