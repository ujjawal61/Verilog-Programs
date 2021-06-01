`timescale 1ns / 1ps

module top(clk,reset,a,b,counter);
    input clk, reset;
    input  a,b; 
//	output [6:0] state;
    output [3:0] counter;
	 wire entry,exit;
//modules instantiations
//	 debouncer DB1(.button(sw0),.button_db(a),.clk(clk),.reset(btnR));
//	 debouncer DB2(.button(sw1),.button_db(b),.clk(clk),.reset(btnR));
   	 FSM fsm(.a(a),.b(b),.clk(clk),.rst(reset),.entry(entry),.exit(exit));
	 counter CNT(.clk(clk),.rst(reset),.entry(entry),.exit(exit),.count(counter));
//	 seven_seg_ctrl hex( .clk(clk), .reset(btnR),.number(counter), .led_out(seg), .anode_activate(led));
endmodule
