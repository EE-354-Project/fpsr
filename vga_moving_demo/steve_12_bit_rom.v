module steve_rom
	(
		input wire clk,
		input wire [4:0] row,
		input wire [4:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [4:0] row_reg;
	reg [4:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=10'b0000000000) && ({row_reg, col_reg}<10'b0000000011)) color_data = 12'b001000100000;

		if(({row_reg, col_reg}>=10'b0000000011) && ({row_reg, col_reg}<10'b0000100000)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}>=10'b0000100000) && ({row_reg, col_reg}<10'b0000100011)) color_data = 12'b001000100000;

		if(({row_reg, col_reg}>=10'b0000100011) && ({row_reg, col_reg}<10'b0001000000)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}>=10'b0001000000) && ({row_reg, col_reg}<10'b0001000010)) color_data = 12'b001000100000;
		if(({row_reg, col_reg}==10'b0001000010)) color_data = 12'b001100100000;
		if(({row_reg, col_reg}>=10'b0001000011) && ({row_reg, col_reg}<10'b0001001000)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0001001000)) color_data = 12'b001100010000;


		if(({row_reg, col_reg}>=10'b0001001001) && ({row_reg, col_reg}<10'b0010001011)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}>=10'b0010001011) && ({row_reg, col_reg}<10'b0010001111)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}>=10'b0010001111) && ({row_reg, col_reg}<10'b0010010110)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==10'b0010010110)) color_data = 12'b001100100001;

		if(({row_reg, col_reg}>=10'b0010010111) && ({row_reg, col_reg}<10'b0010100100)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}>=10'b0010100100) && ({row_reg, col_reg}<10'b0010101011)) color_data = 12'b001000100000;
		if(({row_reg, col_reg}>=10'b0010101011) && ({row_reg, col_reg}<10'b0010101111)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}>=10'b0010101111) && ({row_reg, col_reg}<10'b0010110110)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==10'b0010110110)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}==10'b0010110111)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0010111000)) color_data = 12'b001000100000;

		if(({row_reg, col_reg}>=10'b0010111001) && ({row_reg, col_reg}<10'b0011001111)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}>=10'b0011001111) && ({row_reg, col_reg}<10'b0011010110)) color_data = 12'b001100100000;

		if(({row_reg, col_reg}>=10'b0011010110) && ({row_reg, col_reg}<10'b0011100011)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0011100011)) color_data = 12'b010000110001;
		if(({row_reg, col_reg}>=10'b0011100100) && ({row_reg, col_reg}<10'b0011101011)) color_data = 12'b011101010100;
		if(({row_reg, col_reg}>=10'b0011101011) && ({row_reg, col_reg}<10'b0011110110)) color_data = 12'b100001100100;
		if(({row_reg, col_reg}==10'b0011110110)) color_data = 12'b011101010100;
		if(({row_reg, col_reg}>=10'b0011110111) && ({row_reg, col_reg}<10'b0011111001)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b0011111001)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==10'b0011111010)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}==10'b0011111011)) color_data = 12'b001000010000;

		if(({row_reg, col_reg}>=10'b0011111100) && ({row_reg, col_reg}<10'b0100000000)) color_data = 12'b001000100000;
		if(({row_reg, col_reg}==10'b0100000000)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0100000001)) color_data = 12'b001000100000;
		if(({row_reg, col_reg}==10'b0100000010)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0100000011)) color_data = 12'b010101000010;
		if(({row_reg, col_reg}==10'b0100000100)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b0100000101)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0100000110)) color_data = 12'b101110010111;
		if(({row_reg, col_reg}>=10'b0100000111) && ({row_reg, col_reg}<10'b0100001011)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b0100001011)) color_data = 12'b110010011000;
		if(({row_reg, col_reg}>=10'b0100001100) && ({row_reg, col_reg}<10'b0100001110)) color_data = 12'b110110011000;
		if(({row_reg, col_reg}==10'b0100001110)) color_data = 12'b110010011000;
		if(({row_reg, col_reg}>=10'b0100001111) && ({row_reg, col_reg}<10'b0100010110)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b0100010110)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0100010111) && ({row_reg, col_reg}<10'b0100011001)) color_data = 12'b101101110101;
		if(({row_reg, col_reg}==10'b0100011001)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==10'b0100011010)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}==10'b0100011011)) color_data = 12'b001000100000;

		if(({row_reg, col_reg}>=10'b0100011100) && ({row_reg, col_reg}<10'b0100100000)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}==10'b0100100000)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0100100001)) color_data = 12'b001000100000;
		if(({row_reg, col_reg}==10'b0100100010)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0100100011)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}==10'b0100100100)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}>=10'b0100100101) && ({row_reg, col_reg}<10'b0100101000)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0100101000) && ({row_reg, col_reg}<10'b0100101011)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}>=10'b0100101011) && ({row_reg, col_reg}<10'b0100101111)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}>=10'b0100101111) && ({row_reg, col_reg}<10'b0100110110)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0100110110)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}>=10'b0100110111) && ({row_reg, col_reg}<10'b0100111010)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b0100111010)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==10'b0100111011)) color_data = 12'b001000100000;

		if(({row_reg, col_reg}>=10'b0100111100) && ({row_reg, col_reg}<10'b0101000000)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}>=10'b0101000000) && ({row_reg, col_reg}<10'b0101000010)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0101000010)) color_data = 12'b000100010000;
		if(({row_reg, col_reg}==10'b0101000011)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}==10'b0101000100)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}>=10'b0101000101) && ({row_reg, col_reg}<10'b0101001000)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0101001000) && ({row_reg, col_reg}<10'b0101001011)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0101001011)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}>=10'b0101001100) && ({row_reg, col_reg}<10'b0101001110)) color_data = 12'b110010011000;
		if(({row_reg, col_reg}==10'b0101001110)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}>=10'b0101001111) && ({row_reg, col_reg}<10'b0101010101)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0101010101)) color_data = 12'b101110010111;
		if(({row_reg, col_reg}==10'b0101010110)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0101010111) && ({row_reg, col_reg}<10'b0101011001)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b0101011001)) color_data = 12'b101101110101;
		if(({row_reg, col_reg}==10'b0101011010)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==10'b0101011011)) color_data = 12'b001000010000;

		if(({row_reg, col_reg}>=10'b0101011100) && ({row_reg, col_reg}<10'b0101100000)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}>=10'b0101100000) && ({row_reg, col_reg}<10'b0101100011)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==10'b0101100011)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}>=10'b0101100100) && ({row_reg, col_reg}<10'b0101101000)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0101101000) && ({row_reg, col_reg}<10'b0101101011)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}==10'b0101101011)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0101101100) && ({row_reg, col_reg}<10'b0101101110)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0101101110)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b0101101111) && ({row_reg, col_reg}<10'b0101110011)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0101110011) && ({row_reg, col_reg}<10'b0101110110)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0101110110)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b0101110111)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}>=10'b0101111000) && ({row_reg, col_reg}<10'b0101111010)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}==10'b0101111010)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}==10'b0101111011)) color_data = 12'b100001010011;

		if(({row_reg, col_reg}>=10'b0101111100) && ({row_reg, col_reg}<10'b0110000000)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}>=10'b0110000000) && ({row_reg, col_reg}<10'b0110000111)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b0110000111)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}>=10'b0110001000) && ({row_reg, col_reg}<10'b0110001111)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110001111) && ({row_reg, col_reg}<10'b0110010010)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}==10'b0110010010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110010011) && ({row_reg, col_reg}<10'b0110010110)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0110010110)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}>=10'b0110010111) && ({row_reg, col_reg}<10'b0110011010)) color_data = 12'b100101100100;

		if(({row_reg, col_reg}>=10'b0110011010) && ({row_reg, col_reg}<10'b0110100000)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}>=10'b0110100000) && ({row_reg, col_reg}<10'b0110100100)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110100100) && ({row_reg, col_reg}<10'b0110100111)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b0110100111)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}>=10'b0110101000) && ({row_reg, col_reg}<10'b0110101011)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110101011) && ({row_reg, col_reg}<10'b0110101110)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}==10'b0110101110)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110101111) && ({row_reg, col_reg}<10'b0110110010)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}==10'b0110110010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0110110011) && ({row_reg, col_reg}<10'b0110110101)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0110110101)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b0110110110)) color_data = 12'b101001110101;

		if(({row_reg, col_reg}>=10'b0110110111) && ({row_reg, col_reg}<10'b0111000000)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}>=10'b0111000000) && ({row_reg, col_reg}<10'b0111000011)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}==10'b0111000011)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b0111000100)) color_data = 12'b101110010111;
		if(({row_reg, col_reg}==10'b0111000101)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0111000110)) color_data = 12'b101110010111;
		if(({row_reg, col_reg}==10'b0111000111)) color_data = 12'b101010000111;
		if(({row_reg, col_reg}==10'b0111001000)) color_data = 12'b100101110110;
		if(({row_reg, col_reg}>=10'b0111001001) && ({row_reg, col_reg}<10'b0111001100)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0111001100) && ({row_reg, col_reg}<10'b0111001110)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}==10'b0111001110)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0111001111) && ({row_reg, col_reg}<10'b0111010010)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}==10'b0111010010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0111010011) && ({row_reg, col_reg}<10'b0111010110)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0111010110)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b0111010111) && ({row_reg, col_reg}<10'b0111011010)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b0111011010)) color_data = 12'b100101100101;

		if(({row_reg, col_reg}>=10'b0111011011) && ({row_reg, col_reg}<10'b0111100000)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}>=10'b0111100000) && ({row_reg, col_reg}<10'b0111100010)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b0111100010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}==10'b0111100011)) color_data = 12'b110010101001;
		if(({row_reg, col_reg}>=10'b0111100100) && ({row_reg, col_reg}<10'b0111100111)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b0111100111)) color_data = 12'b100110011011;
		if(({row_reg, col_reg}==10'b0111101000)) color_data = 12'b010000110111;
		if(({row_reg, col_reg}==10'b0111101001)) color_data = 12'b010101001000;
		if(({row_reg, col_reg}==10'b0111101010)) color_data = 12'b010100111000;
		if(({row_reg, col_reg}==10'b0111101011)) color_data = 12'b101001100110;
		if(({row_reg, col_reg}>=10'b0111101100) && ({row_reg, col_reg}<10'b0111101111)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}>=10'b0111101111) && ({row_reg, col_reg}<10'b0111110001)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b0111110001)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b0111110010)) color_data = 12'b100101110111;
		if(({row_reg, col_reg}==10'b0111110011)) color_data = 12'b010100111000;
		if(({row_reg, col_reg}==10'b0111110100)) color_data = 12'b010101001000;
		if(({row_reg, col_reg}==10'b0111110101)) color_data = 12'b010000111000;
		if(({row_reg, col_reg}==10'b0111110110)) color_data = 12'b101010101100;
		if(({row_reg, col_reg}>=10'b0111110111) && ({row_reg, col_reg}<10'b0111111010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b0111111010)) color_data = 12'b101110011000;
		if(({row_reg, col_reg}==10'b0111111011)) color_data = 12'b101001110101;

		if(({row_reg, col_reg}>=10'b0111111100) && ({row_reg, col_reg}<10'b1000000000)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}>=10'b1000000000) && ({row_reg, col_reg}<10'b1000000010)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b1000000010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}==10'b1000000011)) color_data = 12'b110010101001;
		if(({row_reg, col_reg}>=10'b1000000100) && ({row_reg, col_reg}<10'b1000000111)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b1000000111)) color_data = 12'b100110011011;
		if(({row_reg, col_reg}==10'b1000001000)) color_data = 12'b010000101000;
		if(({row_reg, col_reg}==10'b1000001001)) color_data = 12'b010101001000;
		if(({row_reg, col_reg}==10'b1000001010)) color_data = 12'b010100111000;
		if(({row_reg, col_reg}==10'b1000001011)) color_data = 12'b100101100110;
		if(({row_reg, col_reg}>=10'b1000001100) && ({row_reg, col_reg}<10'b1000001111)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}>=10'b1000001111) && ({row_reg, col_reg}<10'b1000010001)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1000010001)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b1000010010)) color_data = 12'b100101110111;
		if(({row_reg, col_reg}==10'b1000010011)) color_data = 12'b010000111000;
		if(({row_reg, col_reg}==10'b1000010100)) color_data = 12'b010101001000;
		if(({row_reg, col_reg}==10'b1000010101)) color_data = 12'b010000101000;
		if(({row_reg, col_reg}==10'b1000010110)) color_data = 12'b101010101100;
		if(({row_reg, col_reg}>=10'b1000010111) && ({row_reg, col_reg}<10'b1000011010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b1000011010)) color_data = 12'b101110011000;
		if(({row_reg, col_reg}==10'b1000011011)) color_data = 12'b101001110101;

		if(({row_reg, col_reg}>=10'b1000011100) && ({row_reg, col_reg}<10'b1000100000)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}==10'b1000100000)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b1000100001)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1000100010)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==10'b1000100011)) color_data = 12'b110010101001;
		if(({row_reg, col_reg}>=10'b1000100100) && ({row_reg, col_reg}<10'b1000100111)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b1000100111)) color_data = 12'b100110011100;
		if(({row_reg, col_reg}==10'b1000101000)) color_data = 12'b001100101000;
		if(({row_reg, col_reg}==10'b1000101001)) color_data = 12'b010100111000;
		if(({row_reg, col_reg}==10'b1000101010)) color_data = 12'b010000111000;
		if(({row_reg, col_reg}==10'b1000101011)) color_data = 12'b101001110111;
		if(({row_reg, col_reg}==10'b1000101100)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b1000101101)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==10'b1000101110)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}>=10'b1000101111) && ({row_reg, col_reg}<10'b1000110001)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1000110001)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b1000110010)) color_data = 12'b100101110111;
		if(({row_reg, col_reg}==10'b1000110011)) color_data = 12'b010000111000;
		if(({row_reg, col_reg}==10'b1000110100)) color_data = 12'b010100111000;
		if(({row_reg, col_reg}==10'b1000110101)) color_data = 12'b001100101000;
		if(({row_reg, col_reg}==10'b1000110110)) color_data = 12'b101010101100;
		if(({row_reg, col_reg}>=10'b1000110111) && ({row_reg, col_reg}<10'b1000111010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b1000111010)) color_data = 12'b110010011000;
		if(({row_reg, col_reg}==10'b1000111011)) color_data = 12'b101001110110;

		if(({row_reg, col_reg}>=10'b1000111100) && ({row_reg, col_reg}<10'b1001000000)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}>=10'b1001000000) && ({row_reg, col_reg}<10'b1001000010)) color_data = 12'b101001110110;
		if(({row_reg, col_reg}==10'b1001000010)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b1001000011)) color_data = 12'b101110011000;
		if(({row_reg, col_reg}==10'b1001000100)) color_data = 12'b111011011101;
		if(({row_reg, col_reg}==10'b1001000101)) color_data = 12'b111011011100;
		if(({row_reg, col_reg}==10'b1001000110)) color_data = 12'b111111101101;
		if(({row_reg, col_reg}==10'b1001000111)) color_data = 12'b101010001010;
		if(({row_reg, col_reg}==10'b1001001000)) color_data = 12'b011001000111;
		if(({row_reg, col_reg}==10'b1001001001)) color_data = 12'b011101011000;
		if(({row_reg, col_reg}==10'b1001001010)) color_data = 12'b011001011000;
		if(({row_reg, col_reg}==10'b1001001011)) color_data = 12'b100101100110;
		if(({row_reg, col_reg}==10'b1001001100)) color_data = 12'b101001100101;
		if(({row_reg, col_reg}>=10'b1001001101) && ({row_reg, col_reg}<10'b1001001111)) color_data = 12'b100101100101;
		if(({row_reg, col_reg}>=10'b1001001111) && ({row_reg, col_reg}<10'b1001010010)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b1001010010)) color_data = 12'b100101100110;
		if(({row_reg, col_reg}>=10'b1001010011) && ({row_reg, col_reg}<10'b1001010101)) color_data = 12'b011101011000;
		if(({row_reg, col_reg}==10'b1001010101)) color_data = 12'b011001000111;
		if(({row_reg, col_reg}==10'b1001010110)) color_data = 12'b101010011010;
		if(({row_reg, col_reg}==10'b1001010111)) color_data = 12'b111011011100;
		if(({row_reg, col_reg}==10'b1001011000)) color_data = 12'b111011001100;
		if(({row_reg, col_reg}==10'b1001011001)) color_data = 12'b111011011100;
		if(({row_reg, col_reg}==10'b1001011010)) color_data = 12'b101010000110;
		if(({row_reg, col_reg}==10'b1001011011)) color_data = 12'b100101100101;

		if(({row_reg, col_reg}>=10'b1001011100) && ({row_reg, col_reg}<10'b1001100000)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}>=10'b1001100000) && ({row_reg, col_reg}<10'b1001100011)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1001100011)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}==10'b1001100100)) color_data = 12'b101101110101;
		if(({row_reg, col_reg}>=10'b1001100101) && ({row_reg, col_reg}<10'b1001100111)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b1001100111)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}>=10'b1001101000) && ({row_reg, col_reg}<10'b1001101011)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1001101011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1001101100) && ({row_reg, col_reg}<10'b1001110010)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1001110010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1001110011)) color_data = 12'b110010010110;
		if(({row_reg, col_reg}>=10'b1001110100) && ({row_reg, col_reg}<10'b1001110110)) color_data = 12'b110010000110;
		if(({row_reg, col_reg}==10'b1001110110)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==10'b1001110111)) color_data = 12'b100101010011;
		if(({row_reg, col_reg}>=10'b1001111000) && ({row_reg, col_reg}<10'b1001111010)) color_data = 12'b100101100011;
		if(({row_reg, col_reg}==10'b1001111010)) color_data = 12'b100001010011;

		if(({row_reg, col_reg}>=10'b1001111011) && ({row_reg, col_reg}<10'b1010000000)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}>=10'b1010000000) && ({row_reg, col_reg}<10'b1010000011)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1010000011)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}>=10'b1010000100) && ({row_reg, col_reg}<10'b1010001000)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==10'b1010001000)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1010001001)) color_data = 12'b101101110111;
		if(({row_reg, col_reg}==10'b1010001010)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1010001011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1010001100)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=10'b1010001101) && ({row_reg, col_reg}<10'b1010010001)) color_data = 12'b011001000011;
		if(({row_reg, col_reg}==10'b1010010001)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1010010010)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}>=10'b1010010011) && ({row_reg, col_reg}<10'b1010010110)) color_data = 12'b101110000110;
		if(({row_reg, col_reg}==10'b1010010110)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}>=10'b1010010111) && ({row_reg, col_reg}<10'b1010011010)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}==10'b1010011010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1010011011)) color_data = 12'b011101010011;

		if(({row_reg, col_reg}>=10'b1010011100) && ({row_reg, col_reg}<10'b1010100000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1010100000) && ({row_reg, col_reg}<10'b1010100011)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1010100011)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}>=10'b1010100100) && ({row_reg, col_reg}<10'b1010100111)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==10'b1010100111)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1010101000)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b1010101001)) color_data = 12'b101110000111;
		if(({row_reg, col_reg}==10'b1010101010)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b1010101011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1010101100)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1010101101)) color_data = 12'b011001000011;
		if(({row_reg, col_reg}>=10'b1010101110) && ({row_reg, col_reg}<10'b1010110000)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1010110000)) color_data = 12'b011001000011;
		if(({row_reg, col_reg}==10'b1010110001)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1010110010)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}==10'b1010110011)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b1010110100)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}==10'b1010110101)) color_data = 12'b110010010111;
		if(({row_reg, col_reg}==10'b1010110110)) color_data = 12'b101101110101;
		if(({row_reg, col_reg}>=10'b1010110111) && ({row_reg, col_reg}<10'b1010111010)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}==10'b1010111010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1010111011)) color_data = 12'b011101010011;

		if(({row_reg, col_reg}>=10'b1010111100) && ({row_reg, col_reg}<10'b1011000000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1011000000) && ({row_reg, col_reg}<10'b1011000100)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1011000100)) color_data = 12'b101001100101;
		if(({row_reg, col_reg}==10'b1011000101)) color_data = 12'b101001100100;
		if(({row_reg, col_reg}==10'b1011000110)) color_data = 12'b101001100101;
		if(({row_reg, col_reg}==10'b1011000111)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}>=10'b1011001000) && ({row_reg, col_reg}<10'b1011010011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1011010011) && ({row_reg, col_reg}<10'b1011010101)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==10'b1011010101)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1011010110)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1011010111) && ({row_reg, col_reg}<10'b1011011010)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1011011010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1011011011)) color_data = 12'b011101010011;

		if(({row_reg, col_reg}>=10'b1011011100) && ({row_reg, col_reg}<10'b1011100000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1011100000) && ({row_reg, col_reg}<10'b1011100011)) color_data = 12'b100001010100;
		if(({row_reg, col_reg}==10'b1011100011)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}>=10'b1011100100) && ({row_reg, col_reg}<10'b1011100110)) color_data = 12'b100101010011;
		if(({row_reg, col_reg}==10'b1011100110)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1011100111)) color_data = 12'b011000110001;
		if(({row_reg, col_reg}>=10'b1011101000) && ({row_reg, col_reg}<10'b1011101011)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}==10'b1011101011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1011101100)) color_data = 12'b100101000100;
		if(({row_reg, col_reg}>=10'b1011101101) && ({row_reg, col_reg}<10'b1011110001)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==10'b1011110001)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}==10'b1011110010)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}>=10'b1011110011) && ({row_reg, col_reg}<10'b1011110110)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}==10'b1011110110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1011110111)) color_data = 12'b100101100100;

		if(({row_reg, col_reg}>=10'b1011111000) && ({row_reg, col_reg}<10'b1100000000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1100000000) && ({row_reg, col_reg}<10'b1100000110)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}==10'b1100000110)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1100000111)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1100001000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1100001001) && ({row_reg, col_reg}<10'b1100001011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1100001011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1100001100) && ({row_reg, col_reg}<10'b1100010010)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==10'b1100010010)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==10'b1100010011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1100010100)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==10'b1100010101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1100010110)) color_data = 12'b011001000010;
		if(({row_reg, col_reg}==10'b1100010111)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1100011000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1100011001)) color_data = 12'b100101010011;

		if(({row_reg, col_reg}>=10'b1100011010) && ({row_reg, col_reg}<10'b1100100000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1100100000) && ({row_reg, col_reg}<10'b1100100100)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}==10'b1100100100)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1100100101)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}==10'b1100100110)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1100100111)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==10'b1100101000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}==10'b1100101001)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1100101010)) color_data = 12'b001100100000;
		if(({row_reg, col_reg}==10'b1100101011)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1100101100)) color_data = 12'b100101000100;
		if(({row_reg, col_reg}>=10'b1100101101) && ({row_reg, col_reg}<10'b1100110001)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==10'b1100110001)) color_data = 12'b100101010100;
		if(({row_reg, col_reg}==10'b1100110010)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1100110011) && ({row_reg, col_reg}<10'b1100110101)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1100110101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1100110110)) color_data = 12'b011001000010;
		if(({row_reg, col_reg}==10'b1100110111)) color_data = 12'b100101100100;
		if(({row_reg, col_reg}==10'b1100111000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1100111001)) color_data = 12'b100101010011;

		if(({row_reg, col_reg}>=10'b1100111010) && ({row_reg, col_reg}<10'b1101000000)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}>=10'b1101000000) && ({row_reg, col_reg}<10'b1101000100)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1101000100) && ({row_reg, col_reg}<10'b1101000110)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==10'b1101000110)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==10'b1101000111)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==10'b1101001000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1101001001) && ({row_reg, col_reg}<10'b1101001011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1101001011)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}>=10'b1101001100) && ({row_reg, col_reg}<10'b1101010011)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}>=10'b1101010011) && ({row_reg, col_reg}<10'b1101010101)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1101010101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1101010110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=10'b1101010111) && ({row_reg, col_reg}<10'b1101011010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1101011010)) color_data = 12'b011101010011;

		if(({row_reg, col_reg}>=10'b1101011011) && ({row_reg, col_reg}<10'b1101100000)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1101100000) && ({row_reg, col_reg}<10'b1101100111)) color_data = 12'b011001000010;
		if(({row_reg, col_reg}==10'b1101100111)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==10'b1101101000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1101101001) && ({row_reg, col_reg}<10'b1101101011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}>=10'b1101101011) && ({row_reg, col_reg}<10'b1101101111)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1101101111) && ({row_reg, col_reg}<10'b1101110101)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1101110101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1101110110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=10'b1101110111) && ({row_reg, col_reg}<10'b1101111010)) color_data = 12'b100001010011;

		if(({row_reg, col_reg}>=10'b1101111010) && ({row_reg, col_reg}<10'b1110000000)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1110000000) && ({row_reg, col_reg}<10'b1110000110)) color_data = 12'b011001000010;
		if(({row_reg, col_reg}==10'b1110000110)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==10'b1110000111)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==10'b1110001000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1110001001) && ({row_reg, col_reg}<10'b1110001011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}>=10'b1110001011) && ({row_reg, col_reg}<10'b1110001111)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}>=10'b1110001111) && ({row_reg, col_reg}<10'b1110010101)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1110010101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1110010110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=10'b1110010111) && ({row_reg, col_reg}<10'b1110011010)) color_data = 12'b100001010011;
		if(({row_reg, col_reg}==10'b1110011010)) color_data = 12'b011101010011;

		if(({row_reg, col_reg}>=10'b1110011011) && ({row_reg, col_reg}<10'b1110100000)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=10'b1110100000) && ({row_reg, col_reg}<10'b1110100110)) color_data = 12'b011001000010;
		if(({row_reg, col_reg}==10'b1110100110)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==10'b1110100111)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==10'b1110101000)) color_data = 12'b001100010000;
		if(({row_reg, col_reg}>=10'b1110101001) && ({row_reg, col_reg}<10'b1110101011)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}>=10'b1110101011) && ({row_reg, col_reg}<10'b1110101111)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}>=10'b1110101111) && ({row_reg, col_reg}<10'b1110110101)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==10'b1110110101)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1110110110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=10'b1110110111) && ({row_reg, col_reg}<10'b1110111010)) color_data = 12'b100001010011;

		if(({row_reg, col_reg}>=10'b1110111010) && ({row_reg, col_reg}<=10'b1110111101)) color_data = 12'b011101000011;
	end
endmodule