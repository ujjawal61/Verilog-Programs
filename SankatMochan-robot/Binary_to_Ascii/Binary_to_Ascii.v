// Sankatmochan Bot : Task 1 D : Binary to Ascii
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Binary to Ascii converter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Binary_to_Ascii
//Inputs : 12-bit int_part and 8-bit dec_part.
//Output : 32-bit int_ascii and 16-bit dec_ascii.

//Note : In the below code/comment, decimal part(dec_part) is referred as fractional part.

//////////////////DO NOT MAKE ANY CHANGES IN MODULE///////////////////////////////

module Binary_to_Ascii(
input 		clk,                    // Clock input for the entire design
input 		[11:0]int_part,			// 12 Bit Interger part (min. value in decimal is 0 and max is 4095)
input 		[7:0]dec_part,				// 8 Bit Fractional part (min. value in decimal is 0 and max is 99)
output reg 	[31:0]int_ascii,	 		// 32 Bit Output Reg to hold the Ascii value of integer part (int_part).
output reg 	[15:0]dec_ascii		   // 16 Bit Output Reg to hold the Ascii value of fractional part (dec_part).
				
/* Note : 1) It is expected that teams find out the reason behind output reg being 32 bit and 16 bit for
		             integer part and decimal part resp. and then proceed with the task.
			 2) 8 bit decimal part can go upto 255 but as it is been used to represent decimal part it cannot go beyound 99.
*/
);
//set_global_assignment -Binary_to_coding VERILOG_NON_CONSTANT_LOOP_LIMIT 300;
////////////////////////////////////// Complete the "?" with appropriate bit values.///////////////////////////////////////////
reg [11:0]r_int_part    = 0;			// Registor to hold input integer part (int_part)
reg [7:0]r_dec_part     = 0;			// Registor to hold input decimal part (dec_part)

reg [27:0]r_shift_int   = 0;			// Registor to hold Output during shift add 3 algorithm integer part (int_part)
reg [15:0]r_shift_dec   = 0;			// Registor to hold Output during shift add 3 algorithm Decimal part (int_part)

reg [3:0]i_int          = 0;			// Use to monitor binary bit shifting of integer part
reg [3:0]i_dec          = 0;			// Use to monitor binary bit shifting of decimal part
reg [3:0]i_int1          = 0;			// Use to monitor binary bit during ascii conver of integer part
reg [3:0]i_dec1          = 0;			// Use to monitor binary bit during ascii conver of decimal part

reg [15:0]r_bcd_int;						// Registor to hold BCD value of integer
reg [7:0]r_bcd_dec;						// Registor to hold BCD value of decimals

reg [31:0]r_int_ascii = 0;				// Registor to hold ASCII value of integer
reg [15:0]r_dec_ascii =0;				// Registor to hold ASCII value of decimal

reg conversion_complete_int = 0;		// To monitor the completion of binary to BCD conversion (integer part)
reg conversion_complete_dec = 0;		// To monitor the completion of binary to BCD conversion (decimal part)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////DO NOT MAKE ANY CHANGES IN THIS ALWAYS BLOCK///////////////////////////////////////////
always @ (posedge clk)
	begin
		int_ascii <= r_int_ascii;
		dec_ascii <= r_dec_ascii;
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////// Convert binary to bcd by using the Shift Add-3 algorithm. The below block is for Interger part of the data ///////////
always @ (posedge clk)
	begin
	
		 if((i_int == 0)  && (r_int_part != int_part))   //If data at the input is not different from what is already stored, Dont start conversion
			begin
					//r_int_part = int_part;
					r_shift_int <= {16'b0,int_part};
					i_int = i_int + 1; 
			end
			
		 else if((i_int < 13) && (i_int > 0))              //shift until all the binary bits have been shifted, which happens when i_int reaches 13
			begin
				if(r_shift_int[15:12]>4)
					begin
						r_shift_int[27:12] =r_shift_int[27:12]+3;
					end
			   if(r_shift_int[19:16]>4)
					begin
						r_shift_int[27:16] =r_shift_int[27:16]+3;
					end
				if(r_shift_int[23:20]>4)
					begin
						r_shift_int[27:20] =r_shift_int[27:20]+3;
					end
				if(r_shift_int[27:24]>4)
					begin
						r_shift_int[27:24] =r_shift_int[27:24]+3;
					end
					r_shift_int = r_shift_int << 1;
					i_int =i_int + 1;
					
			end 
			
		else
			begin
				r_bcd_int = r_shift_int[27:12];           //Assign the bcd values to the output register
				i_int = 0;                           
				conversion_complete_int = 1;
			end	
		
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
////////// Convert binary to bcd by using the Shift Add-3 algorithm. The below block is for Interger part of the data /////////////
	always @ (posedge clk)
	begin
		if((i_dec == 0)  && (r_dec_part != dec_part))   //If data at the input is not different from what is already stored, Dont start conversion
			begin
					r_shift_dec <= {8'b0,dec_part};
					i_dec <= i_dec + 	1'b1; 
			end
			
		 else if((i_dec < 9) && (i_dec > 0))                //shift until all the binary bits have been shifted, which happens when i_int reaches 13
			begin
				if(r_shift_dec[11:8]>4)
					begin
						r_shift_dec[15:8] =r_shift_dec[15:8]+3;
					end
			   if(r_shift_dec[15:12]>4)
					begin
						r_shift_dec[15:12] =r_shift_dec[15:12]+3;
					end
					i_dec <= i_dec + 	1'b1;
					r_shift_dec= r_shift_dec << 1;
					
			end 
			
		 else
			begin
				r_bcd_dec= r_shift_dec[15:8];           //Assign the bcd values to the output register
				i_dec <= 0; 
				conversion_complete_dec = 1;
			end
			
			
	end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	
/////////////////////////////// This always block with convert the BCD to ASCII for the interger part///////////////////////////////	
always @ *
	begin
		if (conversion_complete_int==1)
		// Monitor if BCD conversion of integer part is done or not, if done then prceed with ascii conversion
		begin
			if (i_int1 < 4) 
			begin
				r_int_ascii[i_int1 * 8 +: 8] = 8'h30 + r_bcd_int[4 * i_int1 +: 4];
				i_int1 <= i_int1 + 1;
			end
		end
	end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
/////////////////// The Below always block is same as above. This block is for the decimal part //////////////////////
	always @ *
	begin
		if (conversion_complete_dec==1)				// Monitor if BCD conversion of integer part is done or not, if done then prceed with ascii conversion
		begin
			if (i_dec1 < 3) 
			begin
				r_dec_ascii[i_dec1 * 8 +: 8] = 8'h30 + r_bcd_dec[4 * i_dec1 +: 4];
				i_dec1 <= i_dec1 + 1;
			end
		end
	end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
endmodule 