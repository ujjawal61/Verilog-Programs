`timescale 1ns / 1ps 

module Negative(in, out); // module to calculate negative number 

	input wire [5:0] in; // in 6 bit input 
	output wire [5:0] out; // out 6 bit input 

	assign out[0] = ~in[0]; // negate 0 bit
	assign out[1] = ~in[1]; // negate 1 bit 
	assign out[2] = ~in[2]; // negate 2 bit
	assign out[3] = ~in[3]; // negate 3 bit
	assign out[4] = ~in[4]; // negate 4 bit
	assign out[5] = ~in[5]; // negate 5 bit 
	
	
	
endmodule
