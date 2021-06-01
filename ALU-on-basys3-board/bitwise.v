`timescale 1ns / 1ps
module bitwise(a, b, out); // module to calculate the functionality fo bitwise function
	input wire [5:0] a; // a 6 bit input 
	input wire [5:0] b; // b 6 bit input 
	output wire [5:0] out; // out 6 bit output
	
	assign out[0] = a[0]^b[0]; // a0 xor b0 = out0
	assign out[1] = a[1]^b[1]; // a1 xor b1 = put1 
	assign out[2] = a[2]^b[2]; // a2 xor b2 = out2
	assign out[3] = a[3]^b[3]; // a3 xor b3 = out3
	assign out[4] = a[4]^b[4]; // a4 xor b4 = out4 
	assign out[5] = a[5]^b[5]; // a5 xor b5 = out5
	
	 

endmodule
