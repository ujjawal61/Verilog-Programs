module sixbit_ripple_adder // 6 bit ripple adder to check its functionality 
(
    input wire[5:0] x, y, // 6 bit x and y inputs 
    input wire sel, // sel variable for selection
    output wire ovf, cout, // output overflow and carry out 
    output wire [5:0] out // 6 bit out as output
);

wire e0, e1, e2, e3, e4, e5; // variable declarations
wire c0, c1, c2, c3, c4, c5,c6; // variable declarations 
assign c0 = sel;

assign e0 = y[0] ^ sel; // e0 as y0 xor sel
assign e1 = y[1] ^ sel; // e1 as y1 xor sel
assign e2 = y[2] ^ sel; // e2 as y2 xor sel
assign e3 = y[3] ^ sel; // e3 as y3 xor sel
assign e4 = y[4] ^ sel; // e4 as y4 xor sel
assign e5 = y[5] ^ sel; // e5 as y5 xor sel

full_adder FullAdder_1(.a(x[0]), .b(e0), .cin(c0), .s(out[0]), .cout(c1));
full_adder FullAdder_2(.a(x[1]), .b(e1), .cin(c1), .s(out[1]), .cout(c2));
full_adder FullAdder_3(.a(x[2]), .b(e2), .cin(c2), .s(out[2]), .cout(c3));
full_adder FullAdder_4(.a(x[3]), .b(e3), .cin(c3), .s(out[3]), .cout(c4));
full_adder FullAdder_5(.a(x[4]), .b(e4), .cin(c4), .s(out[4]), .cout(c5));
full_adder FullAdder_6(.a(x[5]), .b(e5), .cin(c5), .s(out[5]), .cout(c6));
  assign cout = c6; // carry out is c6 
 assign ovf = c5^c6; // overflow is c5 xor c6

endmodule