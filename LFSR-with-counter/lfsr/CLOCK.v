module CLOCK
    (
    input wire cclk,
    input wire [31:0] clkscale,
    output reg clk_out
    );
    reg [31:0] clkq = 0;
    
    always@(posedge cclk)
        begin
            clkq = clkq + 2;
                if(clkq>=clkscale)
                    begin
                        clk_out=~clk_out;
                        clkq=0;
                    end
        end
endmodule
