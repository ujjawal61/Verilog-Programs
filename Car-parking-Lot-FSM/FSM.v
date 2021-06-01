`timescale 1ns / 1ps

module FSM( a,b,rst,clk, entry,exit);
    input a,b,rst,clk;
    output reg entry,exit;
    reg [1:0] cur_state, next_state;
    
    localparam [2:0]
               S0 = 2'b00,  //both unblocked
               S1 = 2'b10,  //a blocked
  			   S2 = 2'b11,   // and b blocked
  			   S3 = 2'b01;   //b blocked
    
 always @(posedge clk) 
    begin
        next_state=cur_state;
        case(cur_state)
            S0: if      (~a & ~b)    begin next_state = S0;   entry =1'b0; exit =1'b0; end //when both sensors are unblocked,idle conditon
                else if (a & ~b)     begin next_state = S1;   entry =1'b0; exit =1'b0; end //car is entering, as a is blocked
                else if (~a & b)     begin next_state = S3;   entry =1'b0; exit =1'b0; end  //car is exit_temping, as b is blocked
            S1: if      (~a & ~b)    begin next_state = S0;   entry =1'b0; exit =1'b0; end   //car has officially exit_temped from the lot, as both sensors are unblocked
                else if (a & ~b)     begin next_state = S1;   entry =1'b0; exit =1'b0; end // car is standing at the same point, doesnt move
                
                else if (a & b)      begin next_state = S2;   entry =1'b1; exit =1'b0; end //car is going to enetr the lot and standing at the middle of the path
            
            S2: if      (a & ~b)     begin next_state = S1;   entry =1'b0; exit =1'b0; end // car is about to exit_temp, as coming from both blocked sensors to only a blcoked
                else if (~a & b)     begin next_state = S3;   entry =1'b0; exit =1'b0; end // car is about to enter, as coming from both blocked sensors to only b blcoked
                else if (a & b)      begin next_state = S2;   entry =1'b0; exit =1'b0; end //car doesnt move 
            S3: if      (~a &~b)     begin next_state = S0;   entry =1'b0; exit =1'b0; end //car has officially entered in the lot, as from b blocked sensors to both unblocked 
               
                else if (a & b)      begin next_state = S2;   entry =1'b0; exit =1'b1; end //car is going to exit_temp the lot and standing at the middle of the path
                
                else if (~a & b)     begin next_state = S3;   entry =1'b0; exit =1'b0; end // car doesnt move
        endcase
    end
    
  always @ (posedge clk, posedge rst) 
    begin
        if(rst) begin cur_state <= S0; end    //if reset is true, then both sensors will be unblocked
        else    cur_state <= next_state; //otheriwse it will keep updating the current state
     end

endmodule


module counter( entry,exit,clk,rst, count);
    input entry,exit, clk,rst;
    output reg [3:0] count;
    
    always @ (posedge clk, posedge rst)
        begin
            if(rst) count <= 4'b0000;                                                   //if reset, then counter is set to 0
            else if (entry &&  ~exit && (count < 4'b1111)) begin count <= count + 4'b0001; end   //if inc is true and dec is not true and counter is less than 14, then it will increment the counter
            else if (~entry &&  exit && (count > 4'b0000))begin count <= count - 4'b0001; end// $display("%d",count); end   //if dec is true and inc is not true and counter is more than 0, then it will decrement the counter
      
        end 
endmodule
