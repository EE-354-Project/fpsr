`timescale 1ns / 1ps

module chillguy_controller(
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
    // Seat 3 (top row, third from left)
    parameter SEAT_WIDTH = 45;
    parameter SEAT_HEIGHT = 45;
    parameter SEAT_SPACING = 15;
    parameter BASE_X = 450;
    parameter BASE_Y = 393;
    
    // Position in seat 3 (top row, third from left)
    parameter XPOS = BASE_X + SEAT_SPACING/2 + SEAT_WIDTH/2 - 16; // Center in seat 3
    parameter YPOS = BASE_Y - SEAT_HEIGHT - SEAT_SPACING - SEAT_HEIGHT/2 - 16; // Center in top row
    parameter W = 32; // Width of sprite
    parameter H = 32; // Height of sprite
    
    // ROM dimensions
    localparam ROW_W = 5, COL_W = 5;
    
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
    chillguy_rom chillguy_rom_inst (
        .clk(ClkPort),
        .row(row_addr),
        .col(col_addr),
        .color_data(rom_color_data)
    );
    
    // Output RGB value
    always @(*) begin
        if(~bright) // Force black if not in display area
            rgb = 12'b0000_0000_0000;
        else if(sprite_on_d) 
            rgb = (rom_color_data == 12'b101100000000) ? background : rom_color_data; // Transparent if red
        else
            rgb = background;
    end
    
endmodule
