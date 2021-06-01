
module eq2
   (
    input  wire[5:0] a, b,			// a and b 6 bit inputs
    output wire [5:0]out				// 6 bit outputs 
   );

  wire e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15,agtb1,agtb2, res;

   // body
   // instantiate two 1-bit comparators that we already know are tested and work
   // named instantiation allows us to change order of ports.
   eq1 eq_bit0_unit (.i0(a[0]), .i1(b[0]), .eq(e0));
   eq1 eq_bit1_unit (.eq(e1), .i0(a[1]), .i1(b[1]));
   eq1 eq_bit2_unit (.eq(e2), .i0(a[2]), .i1(b[2]));
   eq1 eq_bit3_unit (.eq(e3), .i0(a[3]), .i1(b[3]));
   eq1 eq_bit4_unit (.eq(e4), .i0(a[4]), .i1(b[4]));
   eq1 eq_bit5_unit (.eq(e5), .i0(a[5]), .i1(b[5]));
   
   
   // result in agtb1
   assign agtb1 = e0 & e1 & e2 & e3 & e4 & e5 ;


  assign e8 =  a[5] & (~b[5]);
  assign e9 =  e5 & a[4] & (~b[4]);
  assign e10 = e5 & e4 & a[3] & (~b[3]);
  assign e11 = e5 & e4 & e3 & a[2] & (~b[2]);
  assign e12 = e5 & e4 & e3 & e2 & a[1] & (~b[1]);
  assign e13 = e5 & e4 & e3 & e2 & e1 & a[0] & (~b[0]);
  
  // result in agtb2
  assign agtb2 = e8 | e9 | e10 | e11 | e12 | e13 ;
  assign out[0] = agtb2 | agtb1;
  assign out[1]=1'b0;
  assign out[2]=1'b0;
  assign out[3]=1'b0;
  assign out[4]=1'b0;
  assign out[5]=1'b0;
  
endmodule