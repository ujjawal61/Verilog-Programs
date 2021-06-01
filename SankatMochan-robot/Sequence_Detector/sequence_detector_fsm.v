// Sankatmochan Bot : Task 1 C : FSM
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Finite State Machine to detect patter/sequence 1100

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Finite State Machine design
//Inputs : Clock, X (Input Stream)
//Output : Y (Y = 1 when 1100 pattern/sequence is detected)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE///////////////////////////////
module sequence_detector_fsm(
		input Clk,		//Clock input
		input X,			//Input Bitstream 
		output Y			//Output: Y = 1 when 1100 pattern/sequence is detected.
	
);

////////////////////////WRITE YOUR CODE FROM HERE////////////////////
  parameter 
			IDLE	= 0,
  			S1		= 1,
  			S11	= 2,
  			S110	= 3,
  			S1100	= 4;
  
  reg [2:0] cur_state, next_state;
  

  
  always @ (posedge Clk) begin
     	cur_state <= next_state;
  end
  
  always @ (cur_state or X) begin
    case (cur_state)
      IDLE : begin
        if (X) next_state = S1;
        else   next_state = IDLE;
      end
				
      S1: begin
        if (X) next_state = S11;
        else 	next_state = IDLE;
      end
      
      S11 : begin
        if (X) next_state = S1;
        else 	next_state = S110;
      end
      
      S110 : begin
        if (X) next_state = S1;
        else 	next_state = S1100;
      end
      
      S1100: begin
        if (X) next_state = S1;
        else 	next_state = IDLE;
      end
	  default: next_state = IDLE;
    endcase
  end
  
  assign Y = cur_state == S1100 ? 1 : 0;
// Tip : Write your code such that Quartus Generates a State Machine 
//			(Tools > Netlist Viewers > State Machine Viewer).
// 		For doing so, you will have to properly declare State Variables of the
//       State Machine and also perform State Assignments correctly.  

	
///////////////////////YOUR CODE ENDS HERE////////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////