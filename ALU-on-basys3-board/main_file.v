`timescale 1ns / 1ps

module main(mode,A, B, out,f_ovf,f_cout);
	input wire [2:0] mode; // 3 bit input mode
	input wire [5:0]A,B; // A and B 6 bit inputs
	output reg [5:0]out; // 6 bit output out
	output reg f_ovf,f_cout; // final overflow and final carry out in output
	wire [5:0]neg_A,neg_B,AgtB,bitAB,addAB,subAB; // 6 bit variables 
	wire ovf1,cout1,ovf2,cout2; // two overflows and two carrys 
     

Negative neg_a(.in(A), .out(neg_A)); // making A negative
Negative neg_b(.in(B), .out(neg_B)); // making B negative
eq2 lessthan(.a(A), .b(B), .out(AgtB)); // comparing A greater than B
bitwise bitwise1(.a(A), .b(B), .out(bitAB)); // checking bitwise of AB
sixbit_ripple_adder addab(.x(A),.y(B),.sel(0),.ovf(ovf1),.cout(cout1),.out(addAB)); // call for A and B addition
sixbit_ripple_adder subab(.x(A),.y(B),.sel(1),.ovf(ovf2),.cout(cout2),.out(subAB)); // call for A and B subtraction 
always@*
	begin	
	case(mode)
	            3'b000:
	            begin 
	            out = A; // Showing A
	            f_ovf=1'b0;
	            f_cout=1'b0;
				end
				3'b001:
				begin 
				out = B; // showing B
				f_ovf=1'b0;
	            f_cout=1'b0;
				end
				3'b010:
				begin
				 out = neg_A; // showing negative A
				 f_ovf=1'b0;
	            f_cout=1'b0; 
				end
				3'b011: 
				begin
				out = neg_B; // showing negative B
				f_ovf=1'b0;
	            f_cout=1'b0; 
				end
				3'b100:
				begin 
				out=AgtB; // showing A greater than B
				f_ovf=1'b0;
	            f_cout=1'b0;
				
				end  
				3'b101:
				begin 
				out = bitAB ; // showing bit AB
				f_ovf=1'b0;
	            f_cout=1'b0; 
				end
				3'b110: 
				begin
				out = addAB ; // showing A plus B
				f_ovf=ovf1;
	            f_cout=cout1;
				end
				3'b111:
				begin
			    out = subAB; // showing A minus B
			    f_ovf=ovf2;
	            f_cout=cout2;
				end			
	endcase	
end
	
endmodule