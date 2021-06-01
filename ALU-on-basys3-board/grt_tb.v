`timescale 1 ns/10 ps

module lessthan_tb; // Testbench to show less than functionality 
   // signal declaration
   reg  [5:0] test_in0, test_in1;
   wire [5:0] t_lst;

   // instantiate the circuit under test
   eq2 uut (.a(test_in0), .b(test_in1), .out(t_lst));

   //  test vector generator
   initial
   begin
        
       // test vector 1
      test_in0 = 6'b101010;
      test_in1 = 6'b010101;
      # 200;
      // test vector 2
      test_in0 = 6'b110011;
      test_in1 = 6'b001100;
      # 200;
      // test vector 3
      test_in0 = 6'b001100;
      test_in1 = 6'b110011;
      # 200;
      // test vector 4
      test_in0 = 6'b001100;
      test_in1 = 6'b001100;
      # 200;
      // test vector 5
      test_in0 = 6'b110000;
      test_in1 = 6'b110000;
      # 200;
      // test vector 6
      test_in0 = 6'b000011;
      test_in1 = 6'b000011;
      # 200;
      // test vector 7
      test_in0 = 6'b001111;
      test_in1 = 6'b011110;
      # 200;
      // stop simulation
      $stop;
   end
   
   initial
   begin
        $display("               time   X     Y   Result");
        $monitor("%d %b %b %b ", $time, test_in0, test_in1, t_lst);
   end
   
endmodule