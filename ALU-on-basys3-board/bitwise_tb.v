`timescale 1 ns/10 ps

module bitwise_tb;
   // signal declaration
   reg  [5:0] test_in0, test_in1;
   wire [5:0] t_xor;

   // instantiate the circuit under test
   bitwise uut (.a(test_in0), .b(test_in1), .out(t_xor));

   //  test vector generator
   initial
   begin
        
      // test vector 1
      test_in0 = 6'b010101;
      test_in1 = 6'b111111;
      # 200;
      // test vector 2
      test_in0 = 6'b111000;
      test_in1 = 6'b101010;
      # 200;
      // test vector 3
      test_in0 = 6'b110011;
      test_in1 = 6'b001100;
      # 200;
      // test vector 4
      test_in0 = 6'b000000;
      test_in1 = 6'b111000;
      # 200;
      // test vector 5
      test_in0 = 6'b101011;
      test_in1 = 6'b001100;
      # 200;
      // test vector 6
      test_in0 = 6'b110000;
      test_in1 = 6'b110000;
      # 200;
      // test vector 7
      test_in0 = 6'b101110;
      test_in1 = 6'b010111;
      # 200;
      
      // stop simulation
      $stop;
   end
   
   initial
   begin
        $display("time   X     Y    Result");
        $monitor("%d %b %b %b", $time, test_in0, test_in1, t_xor);
   end
   
endmodule