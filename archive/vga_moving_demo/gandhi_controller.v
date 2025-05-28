`timescale 1ns / 1ps

module gandhi_controller(
    input clk,
    input ClkPort, // faster clock for ROM operations
    input bright,
    input rst,
    input looking_up, // 1 - look up, 0 - look down
    input [9:0] hCount, vCount,
    input [11:0] background,
    output reg [11:0] rgb
);
    // ROM color data
    wire [11:0] rom_color_data_up;
    wire [11:0] rom_color_data_down;
    
    // Position on top of the podium
    reg [9:0] xpos, ypos;
    
    // Gandhi sprite dimensions (based on ROM)
    localparam W = 45; // Width of the sprite
    localparam H = 45; // Height of the sprite
    localparam ROW_W = 6; // Width of row address (6 bits for 0-63)
    localparam COL_W = 6; // Width of column address (6 bits for 0-63)
    
    // Position on top of the podium
    // The podium is at position (250, 215) with a top width of 60 and height of 10
    // We'll center Gandhi on top of the podium
    localparam X0 = 250;     // Center X position of the podium
    localparam Y0 = 205 - H; // Top of the podium minus the height of Gandhi
    
    // Combinational "on" window
    wire sprite_on = (vCount >= ypos) && (vCount < ypos + H) &&
                     (hCount >= xpos) && (hCount < xpos + W);
    
    // Pipeline it one cycle for proper timing
    reg sprite_on_d = 1'b0;
    always @(posedge ClkPort) begin
        sprite_on_d <= sprite_on;
    end
    
    // Address into the ROM
    wire [ROW_W-1:0] row_addr = vCount - ypos;
    wire [COL_W-1:0] col_addr = hCount - xpos;
    
    // Instantiate the ROM modules
    gandhi_up_rom gandhi_up_rom_inst (
        .clk(ClkPort),
        .row(row_addr),
        .col(col_addr),
        .color_data(rom_color_data_up)
    );
    
    gandhi_down_rom gandhi_down_rom_inst (
        .clk(ClkPort),
        .row(row_addr),
        .col(col_addr),
        .color_data(rom_color_data_down)
    );
    
    // Output RGB value based on sprite position and ROM data
    always @(*) begin
        if(~bright) // Force black if not inside the display area
            rgb = 12'b0000_0000_0000;
        else if(sprite_on_d) begin
            // Choose which ROM data to use based on looking_up input
            if(looking_up)
                rgb = (rom_color_data_up == 12'b111111111111) ? background : rom_color_data_up;
            else
                rgb = (rom_color_data_down == 12'b000000000000) ? background : rom_color_data_down;
        end
        else    
            rgb = background;
    end
    
    // Initialize the position
    always @(posedge clk, posedge rst) begin
        if(rst) begin 
            xpos <= X0 - W/2; // Center on the podium
            ypos <= Y0;
        end
    end
    
endmodule
