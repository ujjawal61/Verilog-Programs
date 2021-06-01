// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module d_ff_reset_tb;

   // signal declaration
   reg test_clk, test_reset, test_d;
   wire async_pos;
   wire async_neg;
   wire sync_pos;
   wire sync_neg;
   localparam T = 20;

   // instantiate the d_type_ff module
   d_ff_reset uut 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .d(test_d), 
        .q(async_pos)
        );
   d_ff_2 neg1 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .d(test_d), 
        .q(async_neg)
        );
   d_ff_3 pos1 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .d(test_d), 
        .q(sync_pos)
        );
   d_ff_4 neg2 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .d(test_d), 
        .q(sync_neg)
        );
            
   always
   begin
      test_clk = 1'b1;
      #(T/2);
      test_clk = 1'b0;
      #(T/2);
   end
   
   
   initial
   begin
      test_reset = 1'b1;
      #(2*T-5);
      test_reset = 1'b0;
      #(4*T);
      test_reset = 1'b1;
      #(2*T-5);
      test_reset = 1'b0;
      #(4*T);
   end
    
   //  test vector generator
   initial
   begin
      test_d = 1'b0;
      #T;
      test_d = 1'b1;
      #(T+5);
      test_d = 1'b0;
      #(2*T-10);
      test_d = 1'b1;
      #(5 * T);
      test_d = 1'b0;
       #(2*T+5);
      // stop simulation 
      $stop;
      
   end
   
endmodule