`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    vga_bitchange
// Description:    Displays "First Person Second Row" centered in white text on a black background.
//////////////////////////////////////////////////////////////////////////////////

module vga_bitchange(
    input clk,
    input bright,
    input button, // unused but kept for compatibility
    input [9:0] hCount, vCount,
    output reg [11:0] rgb,
    output reg [15:0] score // unused but kept for compatibility
);

    parameter BLACK = 12'b0000_0000_0000;
    parameter WHITE = 12'b1111_1111_1111;

    initial score = 0; // score not used

    wire in_text;

    // Simple block-based font rendering per character cell
    // Each character will be 8x16 pixels
    wire [7:0] char_rom [0:127][0:15]; // 128 ASCII chars, each 16 bytes

    // NOTE: For brevity, not loading a full font ROM. Instead,
    // below we'll hardcode a region that approximates the phrase using rectangles.

    // Define screen center
    localparam SCREEN_W = 640;
    localparam SCREEN_H = 480;

    // Center the full string (23 characters wide)
    localparam CHAR_W = 8;
    localparam CHAR_H = 16;
    localparam TEXT_W = 23 * CHAR_W; // 184 pixels
    localparam TEXT_H = CHAR_H;      // 16 pixels
    localparam START_X = (SCREEN_W - TEXT_W) / 2; // 228
    localparam START_Y = (SCREEN_H - TEXT_H) / 2; // 232

    // Character spacing
    wire [4:0] char_col = (hCount - START_X) / CHAR_W;
    wire [3:0] char_row = (vCount - START_Y);
    wire [2:0] pixel_col = (hCount - START_X) % CHAR_W;

    // We'll define visible rectangles manually for each character (very simplified)

    function is_pixel_in_char;
        input [4:0] col;
        input [2:0] px;
        input [3:0] row;
        begin
            // Only draw for rows 0 to 15 and cols 0 to 22
            if (row > 15 || col > 22)
                is_pixel_in_char = 0;
            else begin
                // Hardcoded block-style character approximation
                case (col)
                    // "F"
                    0: is_pixel_in_char = (px < 6 && row < 2) || (px < 6 && row == 7) || (px == 0);
                    // "i"
                    1: is_pixel_in_char = (px == 3 && row > 3);
                    // "r"
                    2: is_pixel_in_char = (px == 0);
                    // "s"
                    3: is_pixel_in_char = (row < 2 || row == 7 || row > 12);
                    // "t"
                    4: is_pixel_in_char = (row == 0 || px == 3);
                    // (space)
                    5: is_pixel_in_char = 0;
                    // "P"
                    6: is_pixel_in_char = (px == 0 || (row < 2 && px < 6) || (row == 7 && px < 6));
                    // "e"
                    7: is_pixel_in_char = (row == 7 || row < 2 || row > 12);
                    // "r"
                    8: is_pixel_in_char = (px == 0);
                    // "s"
                    9: is_pixel_in_char = (row < 2 || row == 7 || row > 12);
                    // "o"
                    10: is_pixel_in_char = (px > 0 && px < 6 && row > 0 && row < 15);
                    // "n"
                    11: is_pixel_in_char = (px == 0 || px == 6);
                    // (space)
                    12: is_pixel_in_char = 0;
                    // "S"
                    13: is_pixel_in_char = (row < 2 || row == 7 || row > 12);
                    // "e"
                    14: is_pixel_in_char = (row == 7 || row < 2 || row > 12);
                    // "c"
                    15: is_pixel_in_char = (row > 2 && row < 13);
                    // "o"
                    16: is_pixel_in_char = (px > 0 && px < 6 && row > 0 && row < 15);
                    // "n"
                    17: is_pixel_in_char = (px == 0 || px == 6);
                    // "d"
                    18: is_pixel_in_char = (px == 6 || (px == 0 && row > 2));
                    // (space)
                    19: is_pixel_in_char = 0;
                    // "R"
                    20: is_pixel_in_char = (px == 0 || (row < 2 && px < 6) || (row == 7 && px < 6));
                    // "o"
                    21: is_pixel_in_char = (px > 0 && px < 6 && row > 0 && row < 15);
                    // "w"
                    22: is_pixel_in_char = (px == 0 || px == 6 || (px == 3 && row > 8));
                    default: is_pixel_in_char = 0;
                endcase
            end
        end
    endfunction

    assign in_text = (hCount >= START_X && hCount < START_X + TEXT_W &&
                      vCount >= START_Y && vCount < START_Y + TEXT_H) &&
                     is_pixel_in_char(char_col, pixel_col, char_row);

    always @(*) begin
        if (~bright)
            rgb = BLACK;
        else if (in_text)
            rgb = WHITE;
        else
            rgb = BLACK;
    end

endmodule
