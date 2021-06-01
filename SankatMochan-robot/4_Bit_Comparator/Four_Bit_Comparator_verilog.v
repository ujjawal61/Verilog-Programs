// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
// CREATED		"Sat Oct 24 17:34:51 2020"

module Four_Bit_Comparator_verilog(
	A,
	B,
	A_Greater,
	Equal,
	B_Greater
);


input wire	[3:0] A;
input wire	[3:0] B;
output wire	A_Greater;
output wire	Equal;
output wire	B_Greater;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;





Two_Bit_Comparator	b2v_inst(
	.A1(A[3]),
	.A0(A[2]),
	.B1(B[3]),
	.B0(B[2]),
	.A_Greater(SYNTHESIZED_WIRE_0),
	
	.B_Greater(SYNTHESIZED_WIRE_1));


Two_Bit_Comparator	b2v_inst8(
	.A1(SYNTHESIZED_WIRE_0),
	.A0(A[1]),
	.B1(SYNTHESIZED_WIRE_1),
	.B0(B[1]),
	.A_Greater(SYNTHESIZED_WIRE_2),
	
	.B_Greater(SYNTHESIZED_WIRE_3));


Two_Bit_Comparator	b2v_inst9(
	.A1(SYNTHESIZED_WIRE_2),
	.A0(A[0]),
	.B1(SYNTHESIZED_WIRE_3),
	.B0(B[0]),
	.A_Greater(A_Greater),
	.Equal(Equal),
	.B_Greater(B_Greater));


endmodule
