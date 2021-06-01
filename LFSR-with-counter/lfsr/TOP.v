module TOP
    (
    //I/O:
    input wire _CCLK, _RESET,
    output wire MAX_T, 
    output wire [12:0] _LFSR_REG,
    output wire test_bit,lfsr_clk
    );
    
    //INSTANTIATING CLOCK MODULE
    CLOCK clock_signal (.cclk(_CCLK), .clkscale(50000000), .clk_out(lfsr_clk));
    //INSTANTIATING LFSR MODULE
    LFSR_13 lfsr_module (.clk(lfsr_clk), .reset(_RESET), .lfsr_out(_LFSR_REG), .max_tick_reg(MAX_T),
                         .bit(test_bit));
   
endmodule
