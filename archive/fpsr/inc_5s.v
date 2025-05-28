module increment_5s (
    input clk,  
    input rst, 
    output reg [7:0] I
);

    // 100 MHz × 5 seconds = 500,000,000 cycles
    localparam MAX_COUNT = 500_000_000 - 1;
    reg [28:0] tick_counter;  // Needs to count up to 500 million (2^29 > 500M)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tick_counter <= 0;
            I <= 0;
        end else if (I < 120) begin
            if (tick_counter == MAX_COUNT) begin
                tick_counter <= 0;
                I <= I + 1;
            end else begin
                tick_counter <= tick_counter + 1;
            end
        end
    end

endmodule
