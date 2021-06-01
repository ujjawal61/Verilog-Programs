`timescale 1ns / 1ps

module testbench;
    wire clk,rset,a,b,check, finish;
    wire [3:0] count, expected_count;
    wire integer log;
    
    scoreboard score(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .expected_count(expected_count),
        .count(count),
        .check(check),
        .finish(finish),
        .log(log));
    
    stim_gen stim_gen(
        .t_clk(clk),
        .t_reset(reset),
        .t_a(a),
        .t_b(b),
        .expected_count(expected_count),
        .check(check),
        .finish(finish),
        .log(log));
    
    top dut(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .counter(count));   
    

endmodule