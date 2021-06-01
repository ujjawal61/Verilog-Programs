//MODULE TO IMPLEMENT A LINEAR FEEDBACK SHIFT REGISTER
//USING 13 BITS AND XOR FEEDBACK
module LFSR_13
    (
    //I/O:
    input  wire clk, reset, //CLOCK AND RESET SIGNALS FROM TESTBENCH
    output wire [12:0] lfsr_out,
    output wire bit,//XORED BIT
    output reg max_tick_reg,//1-BIT OUTPUT SIGNAL AND MAX TICK
    output reg [15:0]final_ones,final_zeros //COUNTING ONES AND ZEROS
    );
    
    //SIGNAL DECLARATIONS
    reg [12:0] lfsr_reg; //SHIFT REGISTER STORAGE
    reg [12:0] lfsr_next; //NEXT VALUE TO BE STORED
    reg lfsr_tap; //TO HOLD RESULT OF FEEDBACK
    localparam seed = 13'b1100111000011; //SEED VALUE
    integer counter=0,count_ones=0,count_zeros=0; //INITIALISING THE COUNTER FOR ONE AND ZEROS
    //----------LFSR MODULE BODY----------
    //REGISTER LOGIC
    //ASYNCHRONOUS, POSITIVE EDGE TRIGGERED
    always @(posedge clk, posedge reset)
        if (reset)
             begin
                $display("done");
                lfsr_reg <= seed; //SET TO SEED VALUE WHEN RESET IS HIGH
                counter <= 1'b0;  //reset the counter 
                count_ones<=1'b0; //RESETTING THE COUNTER FOR ONES
                count_zeros<=1'b0;//RESETTING THE COUNTER FOR ZEROS
                
             end
       else
            begin
                 lfsr_reg <= lfsr_next; //OTHERWISE SET TO NEXT VALUE AS CALCULATED BELOW
                 //DETECT MAX TICK
            if(counter==8191)
                 begin
                   max_tick_reg <= 1'b1;//MAX TICK IS HIGH IF SEED VALUE IS STORE
                    counter <= 1'b0; //reset the counter 
                    count_ones <=1'b0;
                    count_zeros <=1'b0;
                 end   
            else
                    max_tick_reg = 1'b0;//OTHERWISE MAX TICK IS LOW 
            end 
           
        
         
    //FEEDBACK AND SHIFT LOGIC
    always @*
        begin
            //GENERATE THE FEEDBACK ON TAPS 0, 1,3, 4, 13
             lfsr_tap = lfsr_reg[0] ^ lfsr_reg[1] ^ lfsr_reg[3] ^ lfsr_reg[4]^ lfsr_reg[12];
             counter=counter+1;
             //INCREASING THE COUNTER FOR ONES AND ZEROS
             if(lfsr_tap == 1)
                 begin
                       count_ones =count_ones+1'b1;
                 end
             else if(lfsr_tap == 0)
                 begin
                        count_zeros =count_zeros+1;
                 end 
               final_ones=count_ones;
               final_zeros=count_zeros;
             //FEEDBACK RESULT GOES INTO POSITION 0, OTHER BITS SHIFT UP BY 1
             lfsr_next = {lfsr_reg[11:0],lfsr_tap};
        end
   
    //LFSR OUTPUT = MSB OF SHIFT REGISTER VALUE AND ASSIGNING DIFFERENT VALUES
    assign lfsr_out = lfsr_reg; 
    assign bit = lfsr_tap;
    initial
       begin
            $display("counter tick ones zeros lfsr_reg ");
            $monitor("%d %b %d %d %b", counter,max_tick_reg,final_ones ,final_zeros,lfsr_reg);
       end
endmodule