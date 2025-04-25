module random 
(
    input Clk, Reset
    input reg [1:0] I
);

reg [3:0] states, counter;
reg [1:0] I_prev;

localparam 
    S0 = 4'b0001, 
    S1 = 4'b0010,
    S2 = 4'b0100, 
    S3 = 4'b1000;

assign {q_S3, q_S2, q_S1, q_S0} = states;

always @(posedge Clk, posedge Reset)
begin
    if (Reset) I_prev <= I;
    
    else if (I_prev != I)
        begin
            I_prev <= I;
            counter <= counter + 1;
        end
end

always @(posedge Clk, posedge Reset)
begin
    if (Reset)
        begin
            state <= INI;
            counter <= 4'bx;
        end
    else
        begin
            case (state)
                INI:
                    begin
                        counter <= 0;
                        
                        if (I_prev[1:0] == 2'b00) state <= S0;
                        else if (I_prev[1:0] == 2'b01) state <= S1;
                        else if (I_prev[1:0] == 2'b10) state <= S2;
                        else state <= S3;
                    end
                S0:
                    begin

                    end
                S1:
                    begin

                    end
                S2:
                    begin

                    end
                S3:
                    begin

                    end
            endcase
        end
end

endmodule