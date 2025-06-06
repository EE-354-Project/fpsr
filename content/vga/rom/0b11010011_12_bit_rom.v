module _0b11010011_rom (
    input wire clk,
    input wire [3:0] row,
    input wire [5:0] col,
    output reg [11:0] color_data
);

    (* rom_style = "block" *)

    reg [3:0] row_reg;
    reg [5:0] col_reg;

    always @(posedge clk) begin
        row_reg <= row;
        col_reg <= col;
    end

    always @(*) begin
        case ({row_reg, col_reg})
            10'b0000000000: color_data = 12'b111111111111;
            10'b0000000001: color_data = 12'b111111111111;
            10'b0000000010: color_data = 12'b111111111111;
            10'b0000000011: color_data = 12'b111111111111;
            10'b0000000100: color_data = 12'b111111111111;
            10'b0000000101: color_data = 12'b111111111111;
            10'b0000000110: color_data = 12'b111111111111;
            10'b0000000111: color_data = 12'b111111111111;
            10'b0000001000: color_data = 12'b111111111111;
            10'b0000001001: color_data = 12'b111111111111;
            10'b0000001010: color_data = 12'b111111111111;
            10'b0000001011: color_data = 12'b111111111111;
            10'b0000001100: color_data = 12'b111111111111;
            10'b0000001101: color_data = 12'b111111111111;
            10'b0000001110: color_data = 12'b111111111111;
            10'b0000001111: color_data = 12'b111111111111;
            10'b0000010000: color_data = 12'b111111111111;
            10'b0000010001: color_data = 12'b111111111111;
            10'b0000010010: color_data = 12'b111111111111;
            10'b0000010011: color_data = 12'b111111111111;
            10'b0000010100: color_data = 12'b111111111111;
            10'b0000010101: color_data = 12'b111111111111;
            10'b0000010110: color_data = 12'b111111111111;
            10'b0000010111: color_data = 12'b111111111111;
            10'b0000011000: color_data = 12'b111111111111;
            10'b0000011001: color_data = 12'b111111111111;
            10'b0000011010: color_data = 12'b111111111111;
            10'b0000011011: color_data = 12'b111111111111;
            10'b0000011100: color_data = 12'b111111111111;
            10'b0000011101: color_data = 12'b111111111111;
            10'b0000011110: color_data = 12'b111111111111;
            10'b0000011111: color_data = 12'b111111111111;
            10'b0000100000: color_data = 12'b111111111111;
            10'b0000100001: color_data = 12'b111111111111;
            10'b0000100010: color_data = 12'b111111111111;
            10'b0000100011: color_data = 12'b111111111111;
            10'b0000100100: color_data = 12'b111111111111;
            10'b0000100101: color_data = 12'b111111111111;
            10'b0000100110: color_data = 12'b111111111111;
            10'b0000100111: color_data = 12'b111111111111;
            10'b0000101000: color_data = 12'b111111111111;
            10'b0000101001: color_data = 12'b111111111111;
            10'b0000101010: color_data = 12'b111111111111;
            10'b0000101011: color_data = 12'b111111111111;
            10'b0000101100: color_data = 12'b111111111111;
            10'b0000101101: color_data = 12'b111111111111;
            10'b0000101110: color_data = 12'b111111111111;
            10'b0000101111: color_data = 12'b111111111111;
            10'b0000110000: color_data = 12'b111111111111;
            10'b0000110001: color_data = 12'b111111111111;
            10'b0000110010: color_data = 12'b111111111111;
            10'b0000110011: color_data = 12'b111111111111;
            10'b0000110100: color_data = 12'b111111111111;
            10'b0000110101: color_data = 12'b111111111111;
            10'b0000110110: color_data = 12'b111111111111;
            10'b0000110111: color_data = 12'b111111111111;
            10'b0000111000: color_data = 12'b111111111111;
            10'b0000111001: color_data = 12'b111111111111;
            10'b0000111010: color_data = 12'b111111111111;
            10'b0000111011: color_data = 12'b111111111111;
            10'b0001000000: color_data = 12'b111111111111;
            10'b0001000001: color_data = 12'b111111111111;
            10'b0001000010: color_data = 12'b111111111111;
            10'b0001000011: color_data = 12'b111111111111;
            10'b0001000100: color_data = 12'b111111111111;
            10'b0001000101: color_data = 12'b111111111111;
            10'b0001000110: color_data = 12'b111111111111;
            10'b0001000111: color_data = 12'b111111111111;
            10'b0001001000: color_data = 12'b111111111111;
            10'b0001001001: color_data = 12'b111111111111;
            10'b0001001010: color_data = 12'b111111111111;
            10'b0001001011: color_data = 12'b111111111111;
            10'b0001001100: color_data = 12'b111111111111;
            10'b0001001101: color_data = 12'b111111111111;
            10'b0001001110: color_data = 12'b111111111111;
            10'b0001001111: color_data = 12'b111111111111;
            10'b0001010000: color_data = 12'b111111111111;
            10'b0001010001: color_data = 12'b111111111111;
            10'b0001010010: color_data = 12'b111111111111;
            10'b0001010011: color_data = 12'b111111111111;
            10'b0001010100: color_data = 12'b111111111111;
            10'b0001010101: color_data = 12'b111111111111;
            10'b0001010110: color_data = 12'b111111111111;
            10'b0001010111: color_data = 12'b111111111111;
            10'b0001011000: color_data = 12'b111111111111;
            10'b0001011001: color_data = 12'b111111111111;
            10'b0001011010: color_data = 12'b111111111111;
            10'b0001011011: color_data = 12'b111111111111;
            10'b0001011100: color_data = 12'b111111111111;
            10'b0001011101: color_data = 12'b111111111111;
            10'b0001011110: color_data = 12'b111111111111;
            10'b0001011111: color_data = 12'b111111111111;
            10'b0001100000: color_data = 12'b111111111111;
            10'b0001100001: color_data = 12'b111111111111;
            10'b0001100010: color_data = 12'b111111111111;
            10'b0001100011: color_data = 12'b111111111111;
            10'b0001100100: color_data = 12'b111111111111;
            10'b0001100101: color_data = 12'b111111111111;
            10'b0001100110: color_data = 12'b111111111111;
            10'b0001100111: color_data = 12'b111111111111;
            10'b0001101000: color_data = 12'b111111111111;
            10'b0001101001: color_data = 12'b111111111111;
            10'b0001101010: color_data = 12'b111111111111;
            10'b0001101011: color_data = 12'b111111111111;
            10'b0001101100: color_data = 12'b111111111111;
            10'b0001101101: color_data = 12'b111111111111;
            10'b0001101110: color_data = 12'b111111111111;
            10'b0001101111: color_data = 12'b111111111111;
            10'b0001110000: color_data = 12'b111111111111;
            10'b0001110001: color_data = 12'b111111111111;
            10'b0001110010: color_data = 12'b111111111111;
            10'b0001110011: color_data = 12'b111111111111;
            10'b0001110100: color_data = 12'b111111111111;
            10'b0001110101: color_data = 12'b111111111111;
            10'b0001110110: color_data = 12'b111111111111;
            10'b0001110111: color_data = 12'b111111111111;
            10'b0001111000: color_data = 12'b111111111111;
            10'b0001111001: color_data = 12'b111111111111;
            10'b0001111010: color_data = 12'b111111111111;
            10'b0001111011: color_data = 12'b111111111111;
            10'b0010000000: color_data = 12'b111111111111;
            10'b0010000001: color_data = 12'b000000000000;
            10'b0010000010: color_data = 12'b000000000000;
            10'b0010000011: color_data = 12'b000000000000;
            10'b0010000100: color_data = 12'b111111111111;
            10'b0010000101: color_data = 12'b000000000000;
            10'b0010000110: color_data = 12'b000000000000;
            10'b0010000111: color_data = 12'b000000000000;
            10'b0010001000: color_data = 12'b111111111111;
            10'b0010001001: color_data = 12'b111111111111;
            10'b0010001010: color_data = 12'b111111111111;
            10'b0010001011: color_data = 12'b111111111111;
            10'b0010001100: color_data = 12'b111111111111;
            10'b0010001101: color_data = 12'b111111111111;
            10'b0010001110: color_data = 12'b000000000000;
            10'b0010001111: color_data = 12'b000000000000;
            10'b0010010000: color_data = 12'b111111111111;
            10'b0010010001: color_data = 12'b111111111111;
            10'b0010010010: color_data = 12'b111111111111;
            10'b0010010011: color_data = 12'b111111111111;
            10'b0010010100: color_data = 12'b000000000000;
            10'b0010010101: color_data = 12'b000000000000;
            10'b0010010110: color_data = 12'b111111111111;
            10'b0010010111: color_data = 12'b111111111111;
            10'b0010011000: color_data = 12'b111111111111;
            10'b0010011001: color_data = 12'b000000000000;
            10'b0010011010: color_data = 12'b000000000000;
            10'b0010011011: color_data = 12'b000000000000;
            10'b0010011100: color_data = 12'b111111111111;
            10'b0010011101: color_data = 12'b111111111111;
            10'b0010011110: color_data = 12'b111111111111;
            10'b0010011111: color_data = 12'b111111111111;
            10'b0010100000: color_data = 12'b000000000000;
            10'b0010100001: color_data = 12'b000000000000;
            10'b0010100010: color_data = 12'b111111111111;
            10'b0010100011: color_data = 12'b111111111111;
            10'b0010100100: color_data = 12'b111111111111;
            10'b0010100101: color_data = 12'b000000000000;
            10'b0010100110: color_data = 12'b000000000000;
            10'b0010100111: color_data = 12'b000000000000;
            10'b0010101000: color_data = 12'b111111111111;
            10'b0010101001: color_data = 12'b111111111111;
            10'b0010101010: color_data = 12'b111111111111;
            10'b0010101011: color_data = 12'b000000000000;
            10'b0010101100: color_data = 12'b000000000000;
            10'b0010101101: color_data = 12'b000000000000;
            10'b0010101110: color_data = 12'b111111111111;
            10'b0010101111: color_data = 12'b111111111111;
            10'b0010110000: color_data = 12'b111111111111;
            10'b0010110001: color_data = 12'b111111111111;
            10'b0010110010: color_data = 12'b000000000000;
            10'b0010110011: color_data = 12'b000000000000;
            10'b0010110100: color_data = 12'b111111111111;
            10'b0010110101: color_data = 12'b111111111111;
            10'b0010110110: color_data = 12'b111111111111;
            10'b0010110111: color_data = 12'b111111111111;
            10'b0010111000: color_data = 12'b000000000000;
            10'b0010111001: color_data = 12'b000000000000;
            10'b0010111010: color_data = 12'b111111111111;
            10'b0010111011: color_data = 12'b111111111111;
            10'b0011000000: color_data = 12'b000000000000;
            10'b0011000001: color_data = 12'b000000000000;
            10'b0011000010: color_data = 12'b111111111111;
            10'b0011000011: color_data = 12'b000000000000;
            10'b0011000100: color_data = 12'b000000000000;
            10'b0011000101: color_data = 12'b111111111111;
            10'b0011000110: color_data = 12'b000000000000;
            10'b0011000111: color_data = 12'b000000000000;
            10'b0011001000: color_data = 12'b111111111111;
            10'b0011001001: color_data = 12'b111111111111;
            10'b0011001010: color_data = 12'b111111111111;
            10'b0011001011: color_data = 12'b111111111111;
            10'b0011001100: color_data = 12'b000000000000;
            10'b0011001101: color_data = 12'b000000000000;
            10'b0011001110: color_data = 12'b000000000000;
            10'b0011001111: color_data = 12'b000000000000;
            10'b0011010000: color_data = 12'b111111111111;
            10'b0011010001: color_data = 12'b111111111111;
            10'b0011010010: color_data = 12'b000000000000;
            10'b0011010011: color_data = 12'b000000000000;
            10'b0011010100: color_data = 12'b000000000000;
            10'b0011010101: color_data = 12'b000000000000;
            10'b0011010110: color_data = 12'b111111111111;
            10'b0011010111: color_data = 12'b111111111111;
            10'b0011011000: color_data = 12'b000000000000;
            10'b0011011001: color_data = 12'b000000000000;
            10'b0011011010: color_data = 12'b111111111111;
            10'b0011011011: color_data = 12'b000000000000;
            10'b0011011100: color_data = 12'b000000000000;
            10'b0011011101: color_data = 12'b111111111111;
            10'b0011011110: color_data = 12'b000000000000;
            10'b0011011111: color_data = 12'b000000000000;
            10'b0011100000: color_data = 12'b000000000000;
            10'b0011100001: color_data = 12'b000000000000;
            10'b0011100010: color_data = 12'b111111111111;
            10'b0011100011: color_data = 12'b111111111111;
            10'b0011100100: color_data = 12'b000000000000;
            10'b0011100101: color_data = 12'b000000000000;
            10'b0011100110: color_data = 12'b111111111111;
            10'b0011100111: color_data = 12'b000000000000;
            10'b0011101000: color_data = 12'b000000000000;
            10'b0011101001: color_data = 12'b111111111111;
            10'b0011101010: color_data = 12'b000000000000;
            10'b0011101011: color_data = 12'b000000000000;
            10'b0011101100: color_data = 12'b111111111111;
            10'b0011101101: color_data = 12'b000000000000;
            10'b0011101110: color_data = 12'b000000000000;
            10'b0011101111: color_data = 12'b111111111111;
            10'b0011110000: color_data = 12'b000000000000;
            10'b0011110001: color_data = 12'b000000000000;
            10'b0011110010: color_data = 12'b000000000000;
            10'b0011110011: color_data = 12'b000000000000;
            10'b0011110100: color_data = 12'b111111111111;
            10'b0011110101: color_data = 12'b111111111111;
            10'b0011110110: color_data = 12'b000000000000;
            10'b0011110111: color_data = 12'b000000000000;
            10'b0011111000: color_data = 12'b000000000000;
            10'b0011111001: color_data = 12'b000000000000;
            10'b0011111010: color_data = 12'b111111111111;
            10'b0011111011: color_data = 12'b111111111111;
            10'b0100000000: color_data = 12'b000000000000;
            10'b0100000001: color_data = 12'b000000000000;
            10'b0100000010: color_data = 12'b111111111111;
            10'b0100000011: color_data = 12'b000000000000;
            10'b0100000100: color_data = 12'b000000000000;
            10'b0100000101: color_data = 12'b111111111111;
            10'b0100000110: color_data = 12'b000000000000;
            10'b0100000111: color_data = 12'b000000000000;
            10'b0100001000: color_data = 12'b000000000000;
            10'b0100001001: color_data = 12'b000000000000;
            10'b0100001010: color_data = 12'b111111111111;
            10'b0100001011: color_data = 12'b111111111111;
            10'b0100001100: color_data = 12'b111111111111;
            10'b0100001101: color_data = 12'b111111111111;
            10'b0100001110: color_data = 12'b000000000000;
            10'b0100001111: color_data = 12'b000000000000;
            10'b0100010000: color_data = 12'b111111111111;
            10'b0100010001: color_data = 12'b111111111111;
            10'b0100010010: color_data = 12'b111111111111;
            10'b0100010011: color_data = 12'b111111111111;
            10'b0100010100: color_data = 12'b000000000000;
            10'b0100010101: color_data = 12'b000000000000;
            10'b0100010110: color_data = 12'b111111111111;
            10'b0100010111: color_data = 12'b111111111111;
            10'b0100011000: color_data = 12'b000000000000;
            10'b0100011001: color_data = 12'b000000000000;
            10'b0100011010: color_data = 12'b111111111111;
            10'b0100011011: color_data = 12'b000000000000;
            10'b0100011100: color_data = 12'b000000000000;
            10'b0100011101: color_data = 12'b111111111111;
            10'b0100011110: color_data = 12'b111111111111;
            10'b0100011111: color_data = 12'b111111111111;
            10'b0100100000: color_data = 12'b000000000000;
            10'b0100100001: color_data = 12'b000000000000;
            10'b0100100010: color_data = 12'b111111111111;
            10'b0100100011: color_data = 12'b111111111111;
            10'b0100100100: color_data = 12'b000000000000;
            10'b0100100101: color_data = 12'b000000000000;
            10'b0100100110: color_data = 12'b111111111111;
            10'b0100100111: color_data = 12'b000000000000;
            10'b0100101000: color_data = 12'b000000000000;
            10'b0100101001: color_data = 12'b111111111111;
            10'b0100101010: color_data = 12'b000000000000;
            10'b0100101011: color_data = 12'b000000000000;
            10'b0100101100: color_data = 12'b111111111111;
            10'b0100101101: color_data = 12'b000000000000;
            10'b0100101110: color_data = 12'b000000000000;
            10'b0100101111: color_data = 12'b111111111111;
            10'b0100110000: color_data = 12'b111111111111;
            10'b0100110001: color_data = 12'b111111111111;
            10'b0100110010: color_data = 12'b000000000000;
            10'b0100110011: color_data = 12'b000000000000;
            10'b0100110100: color_data = 12'b111111111111;
            10'b0100110101: color_data = 12'b111111111111;
            10'b0100110110: color_data = 12'b111111111111;
            10'b0100110111: color_data = 12'b111111111111;
            10'b0100111000: color_data = 12'b000000000000;
            10'b0100111001: color_data = 12'b000000000000;
            10'b0100111010: color_data = 12'b111111111111;
            10'b0100111011: color_data = 12'b111111111111;
            10'b0101000000: color_data = 12'b000000000000;
            10'b0101000001: color_data = 12'b000000000000;
            10'b0101000010: color_data = 12'b111111111111;
            10'b0101000011: color_data = 12'b000000000000;
            10'b0101000100: color_data = 12'b000000000000;
            10'b0101000101: color_data = 12'b111111111111;
            10'b0101000110: color_data = 12'b000000000000;
            10'b0101000111: color_data = 12'b000000000000;
            10'b0101001000: color_data = 12'b111111111111;
            10'b0101001001: color_data = 12'b000000000000;
            10'b0101001010: color_data = 12'b000000000000;
            10'b0101001011: color_data = 12'b111111111111;
            10'b0101001100: color_data = 12'b111111111111;
            10'b0101001101: color_data = 12'b111111111111;
            10'b0101001110: color_data = 12'b000000000000;
            10'b0101001111: color_data = 12'b000000000000;
            10'b0101010000: color_data = 12'b111111111111;
            10'b0101010001: color_data = 12'b111111111111;
            10'b0101010010: color_data = 12'b111111111111;
            10'b0101010011: color_data = 12'b111111111111;
            10'b0101010100: color_data = 12'b000000000000;
            10'b0101010101: color_data = 12'b000000000000;
            10'b0101010110: color_data = 12'b111111111111;
            10'b0101010111: color_data = 12'b111111111111;
            10'b0101011000: color_data = 12'b000000000000;
            10'b0101011001: color_data = 12'b000000000000;
            10'b0101011010: color_data = 12'b111111111111;
            10'b0101011011: color_data = 12'b000000000000;
            10'b0101011100: color_data = 12'b000000000000;
            10'b0101011101: color_data = 12'b111111111111;
            10'b0101011110: color_data = 12'b111111111111;
            10'b0101011111: color_data = 12'b111111111111;
            10'b0101100000: color_data = 12'b000000000000;
            10'b0101100001: color_data = 12'b000000000000;
            10'b0101100010: color_data = 12'b111111111111;
            10'b0101100011: color_data = 12'b111111111111;
            10'b0101100100: color_data = 12'b000000000000;
            10'b0101100101: color_data = 12'b000000000000;
            10'b0101100110: color_data = 12'b111111111111;
            10'b0101100111: color_data = 12'b000000000000;
            10'b0101101000: color_data = 12'b000000000000;
            10'b0101101001: color_data = 12'b111111111111;
            10'b0101101010: color_data = 12'b000000000000;
            10'b0101101011: color_data = 12'b000000000000;
            10'b0101101100: color_data = 12'b111111111111;
            10'b0101101101: color_data = 12'b000000000000;
            10'b0101101110: color_data = 12'b000000000000;
            10'b0101101111: color_data = 12'b111111111111;
            10'b0101110000: color_data = 12'b111111111111;
            10'b0101110001: color_data = 12'b111111111111;
            10'b0101110010: color_data = 12'b000000000000;
            10'b0101110011: color_data = 12'b000000000000;
            10'b0101110100: color_data = 12'b111111111111;
            10'b0101110101: color_data = 12'b111111111111;
            10'b0101110110: color_data = 12'b111111111111;
            10'b0101110111: color_data = 12'b111111111111;
            10'b0101111000: color_data = 12'b000000000000;
            10'b0101111001: color_data = 12'b000000000000;
            10'b0101111010: color_data = 12'b111111111111;
            10'b0101111011: color_data = 12'b111111111111;
            10'b0110000000: color_data = 12'b000000000000;
            10'b0110000001: color_data = 12'b000000000000;
            10'b0110000010: color_data = 12'b111111111111;
            10'b0110000011: color_data = 12'b000000000000;
            10'b0110000100: color_data = 12'b000000000000;
            10'b0110000101: color_data = 12'b111111111111;
            10'b0110000110: color_data = 12'b000000000000;
            10'b0110000111: color_data = 12'b000000000000;
            10'b0110001000: color_data = 12'b111111111111;
            10'b0110001001: color_data = 12'b000000000000;
            10'b0110001010: color_data = 12'b000000000000;
            10'b0110001011: color_data = 12'b111111111111;
            10'b0110001100: color_data = 12'b111111111111;
            10'b0110001101: color_data = 12'b111111111111;
            10'b0110001110: color_data = 12'b000000000000;
            10'b0110001111: color_data = 12'b000000000000;
            10'b0110010000: color_data = 12'b111111111111;
            10'b0110010001: color_data = 12'b111111111111;
            10'b0110010010: color_data = 12'b111111111111;
            10'b0110010011: color_data = 12'b111111111111;
            10'b0110010100: color_data = 12'b000000000000;
            10'b0110010101: color_data = 12'b000000000000;
            10'b0110010110: color_data = 12'b111111111111;
            10'b0110010111: color_data = 12'b111111111111;
            10'b0110011000: color_data = 12'b000000000000;
            10'b0110011001: color_data = 12'b000000000000;
            10'b0110011010: color_data = 12'b111111111111;
            10'b0110011011: color_data = 12'b000000000000;
            10'b0110011100: color_data = 12'b000000000000;
            10'b0110011101: color_data = 12'b111111111111;
            10'b0110011110: color_data = 12'b111111111111;
            10'b0110011111: color_data = 12'b111111111111;
            10'b0110100000: color_data = 12'b000000000000;
            10'b0110100001: color_data = 12'b000000000000;
            10'b0110100010: color_data = 12'b111111111111;
            10'b0110100011: color_data = 12'b111111111111;
            10'b0110100100: color_data = 12'b000000000000;
            10'b0110100101: color_data = 12'b000000000000;
            10'b0110100110: color_data = 12'b111111111111;
            10'b0110100111: color_data = 12'b000000000000;
            10'b0110101000: color_data = 12'b000000000000;
            10'b0110101001: color_data = 12'b111111111111;
            10'b0110101010: color_data = 12'b000000000000;
            10'b0110101011: color_data = 12'b000000000000;
            10'b0110101100: color_data = 12'b111111111111;
            10'b0110101101: color_data = 12'b000000000000;
            10'b0110101110: color_data = 12'b000000000000;
            10'b0110101111: color_data = 12'b111111111111;
            10'b0110110000: color_data = 12'b111111111111;
            10'b0110110001: color_data = 12'b111111111111;
            10'b0110110010: color_data = 12'b000000000000;
            10'b0110110011: color_data = 12'b000000000000;
            10'b0110110100: color_data = 12'b111111111111;
            10'b0110110101: color_data = 12'b111111111111;
            10'b0110110110: color_data = 12'b111111111111;
            10'b0110110111: color_data = 12'b111111111111;
            10'b0110111000: color_data = 12'b000000000000;
            10'b0110111001: color_data = 12'b000000000000;
            10'b0110111010: color_data = 12'b111111111111;
            10'b0110111011: color_data = 12'b111111111111;
            10'b0111000000: color_data = 12'b000000000000;
            10'b0111000001: color_data = 12'b000000000000;
            10'b0111000010: color_data = 12'b111111111111;
            10'b0111000011: color_data = 12'b000000000000;
            10'b0111000100: color_data = 12'b000000000000;
            10'b0111000101: color_data = 12'b111111111111;
            10'b0111000110: color_data = 12'b000000000000;
            10'b0111000111: color_data = 12'b000000000000;
            10'b0111001000: color_data = 12'b111111111111;
            10'b0111001001: color_data = 12'b000000000000;
            10'b0111001010: color_data = 12'b000000000000;
            10'b0111001011: color_data = 12'b111111111111;
            10'b0111001100: color_data = 12'b111111111111;
            10'b0111001101: color_data = 12'b111111111111;
            10'b0111001110: color_data = 12'b000000000000;
            10'b0111001111: color_data = 12'b000000000000;
            10'b0111010000: color_data = 12'b111111111111;
            10'b0111010001: color_data = 12'b111111111111;
            10'b0111010010: color_data = 12'b111111111111;
            10'b0111010011: color_data = 12'b111111111111;
            10'b0111010100: color_data = 12'b000000000000;
            10'b0111010101: color_data = 12'b000000000000;
            10'b0111010110: color_data = 12'b111111111111;
            10'b0111010111: color_data = 12'b111111111111;
            10'b0111011000: color_data = 12'b000000000000;
            10'b0111011001: color_data = 12'b000000000000;
            10'b0111011010: color_data = 12'b111111111111;
            10'b0111011011: color_data = 12'b000000000000;
            10'b0111011100: color_data = 12'b000000000000;
            10'b0111011101: color_data = 12'b111111111111;
            10'b0111011110: color_data = 12'b111111111111;
            10'b0111011111: color_data = 12'b111111111111;
            10'b0111100000: color_data = 12'b000000000000;
            10'b0111100001: color_data = 12'b000000000000;
            10'b0111100010: color_data = 12'b111111111111;
            10'b0111100011: color_data = 12'b111111111111;
            10'b0111100100: color_data = 12'b000000000000;
            10'b0111100101: color_data = 12'b000000000000;
            10'b0111100110: color_data = 12'b111111111111;
            10'b0111100111: color_data = 12'b000000000000;
            10'b0111101000: color_data = 12'b000000000000;
            10'b0111101001: color_data = 12'b111111111111;
            10'b0111101010: color_data = 12'b000000000000;
            10'b0111101011: color_data = 12'b000000000000;
            10'b0111101100: color_data = 12'b111111111111;
            10'b0111101101: color_data = 12'b000000000000;
            10'b0111101110: color_data = 12'b000000000000;
            10'b0111101111: color_data = 12'b111111111111;
            10'b0111110000: color_data = 12'b111111111111;
            10'b0111110001: color_data = 12'b111111111111;
            10'b0111110010: color_data = 12'b000000000000;
            10'b0111110011: color_data = 12'b000000000000;
            10'b0111110100: color_data = 12'b111111111111;
            10'b0111110101: color_data = 12'b111111111111;
            10'b0111110110: color_data = 12'b111111111111;
            10'b0111110111: color_data = 12'b111111111111;
            10'b0111111000: color_data = 12'b000000000000;
            10'b0111111001: color_data = 12'b000000000000;
            10'b0111111010: color_data = 12'b111111111111;
            10'b0111111011: color_data = 12'b111111111111;
            10'b1000000000: color_data = 12'b111111111111;
            10'b1000000001: color_data = 12'b000000000000;
            10'b1000000010: color_data = 12'b000000000000;
            10'b1000000011: color_data = 12'b000000000000;
            10'b1000000100: color_data = 12'b111111111111;
            10'b1000000101: color_data = 12'b000000000000;
            10'b1000000110: color_data = 12'b000000000000;
            10'b1000000111: color_data = 12'b000000000000;
            10'b1000001000: color_data = 12'b000000000000;
            10'b1000001001: color_data = 12'b000000000000;
            10'b1000001010: color_data = 12'b111111111111;
            10'b1000001011: color_data = 12'b111111111111;
            10'b1000001100: color_data = 12'b000000000000;
            10'b1000001101: color_data = 12'b000000000000;
            10'b1000001110: color_data = 12'b000000000000;
            10'b1000001111: color_data = 12'b000000000000;
            10'b1000010000: color_data = 12'b000000000000;
            10'b1000010001: color_data = 12'b000000000000;
            10'b1000010010: color_data = 12'b000000000000;
            10'b1000010011: color_data = 12'b000000000000;
            10'b1000010100: color_data = 12'b000000000000;
            10'b1000010101: color_data = 12'b000000000000;
            10'b1000010110: color_data = 12'b000000000000;
            10'b1000010111: color_data = 12'b000000000000;
            10'b1000011000: color_data = 12'b111111111111;
            10'b1000011001: color_data = 12'b000000000000;
            10'b1000011010: color_data = 12'b000000000000;
            10'b1000011011: color_data = 12'b000000000000;
            10'b1000011100: color_data = 12'b111111111111;
            10'b1000011101: color_data = 12'b111111111111;
            10'b1000011110: color_data = 12'b000000000000;
            10'b1000011111: color_data = 12'b000000000000;
            10'b1000100000: color_data = 12'b000000000000;
            10'b1000100001: color_data = 12'b000000000000;
            10'b1000100010: color_data = 12'b000000000000;
            10'b1000100011: color_data = 12'b000000000000;
            10'b1000100100: color_data = 12'b111111111111;
            10'b1000100101: color_data = 12'b000000000000;
            10'b1000100110: color_data = 12'b000000000000;
            10'b1000100111: color_data = 12'b000000000000;
            10'b1000101000: color_data = 12'b111111111111;
            10'b1000101001: color_data = 12'b111111111111;
            10'b1000101010: color_data = 12'b111111111111;
            10'b1000101011: color_data = 12'b000000000000;
            10'b1000101100: color_data = 12'b000000000000;
            10'b1000101101: color_data = 12'b000000000000;
            10'b1000101110: color_data = 12'b111111111111;
            10'b1000101111: color_data = 12'b111111111111;
            10'b1000110000: color_data = 12'b000000000000;
            10'b1000110001: color_data = 12'b000000000000;
            10'b1000110010: color_data = 12'b000000000000;
            10'b1000110011: color_data = 12'b000000000000;
            10'b1000110100: color_data = 12'b000000000000;
            10'b1000110101: color_data = 12'b000000000000;
            10'b1000110110: color_data = 12'b000000000000;
            10'b1000110111: color_data = 12'b000000000000;
            10'b1000111000: color_data = 12'b000000000000;
            10'b1000111001: color_data = 12'b000000000000;
            10'b1000111010: color_data = 12'b000000000000;
            10'b1000111011: color_data = 12'b000000000000;
            10'b1001000000: color_data = 12'b111111111111;
            10'b1001000001: color_data = 12'b111111111111;
            10'b1001000010: color_data = 12'b111111111111;
            10'b1001000011: color_data = 12'b111111111111;
            10'b1001000100: color_data = 12'b111111111111;
            10'b1001000101: color_data = 12'b111111111111;
            10'b1001000110: color_data = 12'b111111111111;
            10'b1001000111: color_data = 12'b111111111111;
            10'b1001001000: color_data = 12'b111111111111;
            10'b1001001001: color_data = 12'b111111111111;
            10'b1001001010: color_data = 12'b111111111111;
            10'b1001001011: color_data = 12'b111111111111;
            10'b1001001100: color_data = 12'b111111111111;
            10'b1001001101: color_data = 12'b111111111111;
            10'b1001001110: color_data = 12'b111111111111;
            10'b1001001111: color_data = 12'b111111111111;
            10'b1001010000: color_data = 12'b111111111111;
            10'b1001010001: color_data = 12'b111111111111;
            10'b1001010010: color_data = 12'b111111111111;
            10'b1001010011: color_data = 12'b111111111111;
            10'b1001010100: color_data = 12'b111111111111;
            10'b1001010101: color_data = 12'b111111111111;
            10'b1001010110: color_data = 12'b111111111111;
            10'b1001010111: color_data = 12'b111111111111;
            10'b1001011000: color_data = 12'b111111111111;
            10'b1001011001: color_data = 12'b111111111111;
            10'b1001011010: color_data = 12'b111111111111;
            10'b1001011011: color_data = 12'b111111111111;
            10'b1001011100: color_data = 12'b111111111111;
            10'b1001011101: color_data = 12'b111111111111;
            10'b1001011110: color_data = 12'b111111111111;
            10'b1001011111: color_data = 12'b111111111111;
            10'b1001100000: color_data = 12'b111111111111;
            10'b1001100001: color_data = 12'b111111111111;
            10'b1001100010: color_data = 12'b111111111111;
            10'b1001100011: color_data = 12'b111111111111;
            10'b1001100100: color_data = 12'b111111111111;
            10'b1001100101: color_data = 12'b111111111111;
            10'b1001100110: color_data = 12'b111111111111;
            10'b1001100111: color_data = 12'b111111111111;
            10'b1001101000: color_data = 12'b111111111111;
            10'b1001101001: color_data = 12'b111111111111;
            10'b1001101010: color_data = 12'b111111111111;
            10'b1001101011: color_data = 12'b111111111111;
            10'b1001101100: color_data = 12'b111111111111;
            10'b1001101101: color_data = 12'b111111111111;
            10'b1001101110: color_data = 12'b111111111111;
            10'b1001101111: color_data = 12'b111111111111;
            10'b1001110000: color_data = 12'b111111111111;
            10'b1001110001: color_data = 12'b111111111111;
            10'b1001110010: color_data = 12'b111111111111;
            10'b1001110011: color_data = 12'b111111111111;
            10'b1001110100: color_data = 12'b111111111111;
            10'b1001110101: color_data = 12'b111111111111;
            10'b1001110110: color_data = 12'b111111111111;
            10'b1001110111: color_data = 12'b111111111111;
            10'b1001111000: color_data = 12'b111111111111;
            10'b1001111001: color_data = 12'b111111111111;
            10'b1001111010: color_data = 12'b111111111111;
            10'b1001111011: color_data = 12'b111111111111;
            10'b1010000000: color_data = 12'b111111111111;
            10'b1010000001: color_data = 12'b111111111111;
            10'b1010000010: color_data = 12'b111111111111;
            10'b1010000011: color_data = 12'b111111111111;
            10'b1010000100: color_data = 12'b111111111111;
            10'b1010000101: color_data = 12'b111111111111;
            10'b1010000110: color_data = 12'b111111111111;
            10'b1010000111: color_data = 12'b111111111111;
            10'b1010001000: color_data = 12'b111111111111;
            10'b1010001001: color_data = 12'b111111111111;
            10'b1010001010: color_data = 12'b111111111111;
            10'b1010001011: color_data = 12'b111111111111;
            10'b1010001100: color_data = 12'b111111111111;
            10'b1010001101: color_data = 12'b111111111111;
            10'b1010001110: color_data = 12'b111111111111;
            10'b1010001111: color_data = 12'b111111111111;
            10'b1010010000: color_data = 12'b111111111111;
            10'b1010010001: color_data = 12'b111111111111;
            10'b1010010010: color_data = 12'b111111111111;
            10'b1010010011: color_data = 12'b111111111111;
            10'b1010010100: color_data = 12'b111111111111;
            10'b1010010101: color_data = 12'b111111111111;
            10'b1010010110: color_data = 12'b111111111111;
            10'b1010010111: color_data = 12'b111111111111;
            10'b1010011000: color_data = 12'b111111111111;
            10'b1010011001: color_data = 12'b111111111111;
            10'b1010011010: color_data = 12'b111111111111;
            10'b1010011011: color_data = 12'b111111111111;
            10'b1010011100: color_data = 12'b111111111111;
            10'b1010011101: color_data = 12'b111111111111;
            10'b1010011110: color_data = 12'b111111111111;
            10'b1010011111: color_data = 12'b111111111111;
            10'b1010100000: color_data = 12'b111111111111;
            10'b1010100001: color_data = 12'b111111111111;
            10'b1010100010: color_data = 12'b111111111111;
            10'b1010100011: color_data = 12'b111111111111;
            10'b1010100100: color_data = 12'b111111111111;
            10'b1010100101: color_data = 12'b111111111111;
            10'b1010100110: color_data = 12'b111111111111;
            10'b1010100111: color_data = 12'b111111111111;
            10'b1010101000: color_data = 12'b111111111111;
            10'b1010101001: color_data = 12'b111111111111;
            10'b1010101010: color_data = 12'b111111111111;
            10'b1010101011: color_data = 12'b111111111111;
            10'b1010101100: color_data = 12'b111111111111;
            10'b1010101101: color_data = 12'b111111111111;
            10'b1010101110: color_data = 12'b111111111111;
            10'b1010101111: color_data = 12'b111111111111;
            10'b1010110000: color_data = 12'b111111111111;
            10'b1010110001: color_data = 12'b111111111111;
            10'b1010110010: color_data = 12'b111111111111;
            10'b1010110011: color_data = 12'b111111111111;
            10'b1010110100: color_data = 12'b111111111111;
            10'b1010110101: color_data = 12'b111111111111;
            10'b1010110110: color_data = 12'b111111111111;
            10'b1010110111: color_data = 12'b111111111111;
            10'b1010111000: color_data = 12'b111111111111;
            10'b1010111001: color_data = 12'b111111111111;
            10'b1010111010: color_data = 12'b111111111111;
            10'b1010111011: color_data = 12'b111111111111;
            default:       color_data = 12'b000000000000;
        endcase
    end
endmodule
