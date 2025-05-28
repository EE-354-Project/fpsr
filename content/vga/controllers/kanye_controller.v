`timescale 1ns / 1ps

module kanye_controller(
    input clk,
    input ClkPort,
    input bright,
    input rst,
    input [9:0] hCount, vCount,
    input [11:0] background,
    output reg [11:0] rgb
    );
    
    wire [11:0] rom_color_data;
    
    // Define the seat6 position (bottom row, leftmost seat)
    // From seats_controller.v:
    // base_x = 450, base_y = 400
    // seat6_fill = vCount >= (base_y - SEAT_HEIGHT) && 
    //              vCount <= base_y && 
    //              hCount >= (base_x - SEAT_WIDTH - SEAT_SPACING/2) && 
    //              hCount <= (base_x - SEAT_WIDTH - SEAT_SPACING/2 + SEAT_WIDTH);
    
    // Calculate the center position of seat2
    localparam SEAT_WIDTH = 40;
    localparam SEAT_HEIGHT = 40;
    localparam SEAT_SPACING = 15;
    localparam BASE_X = 450;
    localparam BASE_Y = 400;
    
    // Calculate position for seat6 (bottom row, leftmost)
    localparam SEAT6_X = BASE_X - SEAT_WIDTH - SEAT_SPACING/2;
    localparam SEAT6_Y = BASE_Y - SEAT_HEIGHT;
    
    // Sprite dimensions (from kanye_rom)
    localparam W = 32;
    localparam H = 35;
    
    // Center the sprite in the seat
    localparam X_POS = SEAT6_X + (SEAT_WIDTH - W)/2;
    localparam Y_POS = SEAT6_Y + (SEAT_HEIGHT - H)/2;
    
    // ROM address width parameters (from kanye_rom.v)
    localparam ROW_W = 6; // 6-bit row address
    localparam COL_W = 5; // 5-bit column address
    
    // Sprite rendering window
    wire sprite_on = (vCount >= Y_POS) && (vCount < Y_POS + H) &&
                    (hCount >= X_POS) && (hCount < X_POS + W);
    
    // Pipeline it one cycle for proper timing
    reg sprite_on_d = 1'b0;
    always @(posedge ClkPort) begin
        sprite_on_d <= sprite_on;
    end
    
    // Address into the ROM
    wire [ROW_W-1:0] row_addr = vCount - Y_POS;
    wire [COL_W-1:0] col_addr = hCount - X_POS;
    
    // Instantiate the ROM module
    kanye_rom kanye_rom_inst (
        .clk(ClkPort),
        .row(row_addr),
        .col(col_addr),
        .color_data(rom_color_data)
    );
    
    // Output RGB value based on sprite position and ROM data
    always@ (*) begin
        if(~bright) // Force black if not inside the display area
            rgb = 12'b0000_0000_0000;
        else if(sprite_on_d) 
            rgb = rom_color_data; // Use color from ROM
        else    
            rgb = background;
    end
    
endmodule
