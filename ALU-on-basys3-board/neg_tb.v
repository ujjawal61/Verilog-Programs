`timescale 1 ns/10 ps

module neg_tb; // negative test bench 
   // signal declaration
   reg  [5:0] test_in0; // variable to take 6 bit input 
   wire [5:0] t_out; // variable for 6 bit output 

   // instantiate the circuit under test
   Negative uut (.in(test_in0), .out(t_out));

   //  test vector generator
   initial
   begin
        
      // test vector 1
      test_in0 = 6'b010101;
      # 200;
      // test vector 2
      test_in0 = 6'b011011;
      # 200;
      // test vector 3
      test_in0 = 6'b011101;
      # 200;
      // test vector 4
      test_in0 = 6'b011110;
      # 200;
      // test vector 5
      test_in0 = 6'b011111;
      # 200;
      // test vector 6
      test_in0 = 6'b010001;
      # 200;
      // test vector 7
      test_in0 = 6'b111000;
      # 200;
      
      // stop simulation
      $stop;
   end
   
   initial
   begin
        $display("time   X    Result");
        $monitor("%d %b %b ", $time, test_in0, t_out);
   end
   
endmodule