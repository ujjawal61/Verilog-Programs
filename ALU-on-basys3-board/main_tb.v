`timescale 1 ns/10 ps

module main_tb;
   // signal declaration
   reg  [5:0] test_in0, test_in1; // two testing inputs 
   wire  t_ovf, t_cout;  // one overflow and other carry variable
   wire[5:0] t_out; // testing output variable 
   reg[2:0] mode; // selecting mode

   // instantiate the circuit under test
   main uut (.A(test_in0), .B(test_in1), .mode(mode), .f_ovf(t_ovf), .f_cout(t_out), .out(t_out));
   //  test vector generator
   initial
   begin
       // test vector 1
      test_in0 = 6'b000000;
      test_in1 = 6'b111111;
      mode = 3'b000;
      # 200;
      // test vector 2
      test_in0 = 6'b000001;
      test_in1 = 6'b100000;
      mode = 3'b000;
      # 200;
      // test vector 3
      test_in0 = 6'b000011;
      test_in1 = 6'b110000;
      mode = 3'b001;
      # 200;
      // test vector 4
      test_in0 = 6'b000111;
      test_in1 = 6'b111000;
      mode = 3'b001;
      # 200;
      // test vector 5
      test_in0 = 6'b001111;
      test_in1 = 6'b111100;
      mode = 3'b010;
      # 200;
      // test vector 6
      test_in0 = 6'b011111;
      test_in1 = 6'b111110;
      mode = 3'b010;
      # 200;
      // test vector 7
      test_in0 = 6'b011010;
      test_in1 = 6'b000110;
      mode = 3'b011;
      # 200;
      // test vector 8
      test_in0 = 6'b011000;
      test_in1 = 6'b110110;
      mode = 3'b011;
      # 200;
      // test vector 9
      test_in0 = 6'b110011;
      test_in1 = 6'b110011;
      mode = 3'b100;
      # 200;
      // test vector 10
      test_in0 = 6'b001100;
      test_in1 = 6'b001100;
      mode = 3'b100;
      # 200;
      // test vector 11
      test_in0 = 6'b000010;
      test_in1 = 6'b000011;
      mode = 3'b101;
      # 200;
      // test vector 12
      test_in0 = 6'b000100;
      test_in1 = 6'b000101;
      mode = 3'b101;
      # 200;
      // test vector 13
      test_in0 = 6'b000100;
      test_in1 = 6'b110001;
      mode = 3'b110;
      # 200;
      // test vector 14
      test_in0 = 6'b001110;
      test_in1 = 6'b110011;
      mode = 3'b110;
      # 200;
      // test vector 15
      test_in0 = 6'b011101;
      test_in1 = 6'b101010;
      mode = 3'b111;
      # 200;
      // test vector 16
      test_in0 = 6'b110011;
      test_in1 = 6'b001100;
      mode = 3'b111;
      # 200;
      
      
      // stop simulation
      $stop;
   end
   
   initial
   begin
        $display("            time   X     Y     MODE    COUT     OVF        Result");
        $monitor("%d %b %b %b %b %b %b", $time, test_in0, test_in1, mode, t_cout,t_ovf, t_out);
   end
   
endmodule