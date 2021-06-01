`timescale 1 ns/10 ps

module sixbit_ripple_adder_tb;
   // signal declaration
   reg  [5:0] test_in0, test_in1; // 6 bits testing input 0 and 1 variables 
   reg test_sel; // testing selection variable 
   wire  t_ovf, t_out;  // testing overflow and testing output
   wire[5:0] t_sum; // testing sum output 

   // instantiate the circuit under test
   sixbit_ripple_adder uut (.x(test_in0), .y(test_in1), .sel(test_sel), .ovf(t_ovf), .cout(t_out), .out(t_sum));

   //  test vector generator
   initial
   begin
       // test vector 1
      test_in0 = 6'b110011;
      test_in1 = 6'b110011;
      test_sel = 1'b0;
      # 200;
      // test vector 2
      test_in0 = 6'b010101;
      test_in1 = 6'b010101;
      test_sel = 1'b1;
      # 200;
      // test vector 3
      test_in0 = 6'b110011;
      test_in1 = 6'b001111;
      test_sel = 1'b0;
      # 200;
      // test vector 4
      test_in0 = 6'b111001;
      test_in1 = 6'b110111;
      test_sel = 1'b1;
      # 200;
      // test vector 5
      test_in0 = 6'b101111;
      test_in1 = 6'b001101;
      test_sel = 1'b0;
      # 200;
      // test vector 6
      test_in0 = 6'b011111;
      test_in1 = 6'b110011;
      test_sel = 1'b1;
      # 200;
      // test vector 7
      test_in0 = 6'b101110;
      test_in1 = 6'b010111;
      test_sel = 1'b0;
      # 200;
      
      // stop simulation
      $stop;
   end
   
   initial
   begin
        $display("time   X     Y     Sel c_out overf  sum/sub");
        $monitor("%d %b %b %b %b %b %b", $time, test_in0, test_in1, test_sel, t_out,t_ovf, t_sum);
   end
   
endmodule