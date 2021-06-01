`timescale 1ns / 1ps

module stim_gen
   #(parameter T=2, delay=4)
   (input  [31:0]    log,
    output reg       t_clk,t_reset,t_a,t_b,check,finish,   
    output reg [3:0] expected_count
    );
     
    // clock runnning forever
    always
    begin
        t_clk = 1'b0;
        #(T/2);
        t_clk = 1'b1;
        #(T/2);
    end
    
    // test procedure
 initial 
    begin
        init();       // inialise test
        full_reset(); // full reset 
        $fdisplay(log,">> STARTING TESTS \n"); 
        $display("\>> STARTING TESTS\n"); 
        
        // test- increase counter to 15
        $fdisplay(log, "\n>> Increasing Counter to 15");
        $display( ">> Increasing Counter to 15");  
        
        while (expected_count < 4'b1111) 
            begin
                run_full_one_seq(5'b01100, 5'b00110); // run sequence for entry 
            end
        check_counters();                             // expect 15
       
       
        // test- Increase when counter is already 15
        $fdisplay(log, "\n>> Attempt to Increase the counter when value is 15 - Expected no change");
        $display(">> Attempt to Increase the counter when value is 15 - Expected no change");
        run_full_one_seq(5'b01100, 5'b00110); // run sequence for entry
        check_counters();                     // expect 15 
        $fdisplay(log, ">> Already Full - No space in the Parking Lot");
        
        // test- decrease counter to 0
        $fdisplay(log,"\n>> Decreasing Counter to 0");
        $display( ">>Decreasing Counter to 0");
        
        while (expected_count > 4'b0000) 
            begin
                run_full_one_seq(5'b00110, 5'b01100); // run sequence for exit
            end
        check_counters();                             // expect 0
        
        
        // test- Decrease when counter is already 0
        $fdisplay(log, "\n>> Attempt to Decrease the counter when value is 0 - Expected no change");
        $display(">> Attempt to Decrease the counter when value is 0 - Expected no change");
        run_full_one_seq(5'b00110, 5'b01100);  // run sequence for exit
        check_counters();                      // expect 0
        $fdisplay(log, ">> Already Empty - No cars in the Parking Lot");
        
        full_reset(); // reset system        
        
        
        $fdisplay(log, "\n>> FSM TESTS ");
        $fdisplay(log, "\n>> Required Behaviour\n"); 
        $display(">> FSM TESTS");
        $display(">> Required Behaviour\n");  
        
        
        // test- to increase counter using 3 different entry sequences
        $fdisplay(log, "\n>>Attempt to increase counter using 3 different sequences");
        $display( ">> Attempt to increase counter using 3 different sequences");   
        run_full_one_seq(5'b01100, 5'b00110);               // run sequence for entry
        check_counters();                                   // expect 1
        run_condition_6(6'b011100, 6'b001110);              // run sequence for entry
        check_counters();                                   // expect 2
        run_condition_6(6'b001100, 6'b000110);              // run sequence for entry
        check_counters();                                   // expect 3
        
        
        // test- to decrease counter using 3 different exit sequences
        $fdisplay(log, "\n>> Attempt to Decrease counter using 2 different sequences");
        $display( ">> Attempt to Decrease counter using 2 different sequences");

        run_condition_6(6'b000110,6'b011100);              // run exit sensor seq 
        check_counters();                                   // expect 1
        run_full_one_seq(5'b00110, 5'b01100);               // run exit sensor seq
        check_counters();                                 // expect 2 
        
        full_reset(); // reset system        
      
        
        $fdisplay(log, "\n>> Attempt to terminate the Simulation");
        $display( ">> Attempt to terminate the Simulation");
        terminate_test();                                   // terminate the test
        $fdisplay(log,"\n>> Simulation Stop Successfully");
        $display(">> Simulation Stop Successfully");
        #(delay*2);
    
        $stop;
    end
    
    
    //======================================
    // task definitions
    //======================================
    
    // task to initilise the test procedure
    task init();
        begin   
            $fdisplay(log, "\n>> Beginning FSM Advanced Testbench ");
            $fdisplay(log, ">> --------------------------------");
            $display( ">> Beginning FSM Advanced Testbench");
            $display(">> --------------------------------- ");
            
            // initialise all the variable
            expected_count  = 0; 
            check           = 0;
            finish          = 0;
            t_a             = 0;
            t_b             = 0;
        end
    endtask

    
    // task to trigger system reset
    task full_reset();
        begin   
            $fdisplay(log,"\n>> Full System Reset");
            $display(">> Full System Reset"); 
            t_reset         = 1;         // enable reset for DUT
            t_a             = 0;         // setting both sensors to 0
            t_b             = 0;
            expected_count  = 0;         // setting expected count to 0
            #delay;
            t_reset         = 0;         //disable reset for DUT
        end
    endtask
    
    
     // task to trigger scoreboard to check counter values
    task check_counters();
        begin   
            $display(">> Triggering Counter Check");  
            check = 1;
            #(delay/2);
            check = 0;
            #(delay/2);
        end
    endtask
    
    // task to run full one sequence from idle to entry/exit to idle
    // (a0,b0)>(a1,b1)>(a2,b2)>(a3,b3)>(a4,b4)
    task run_full_one_seq(input [0:4] a, input [0:4] b);
        begin
            $fdisplay(log, ">> Case: (%d%d)>(%d%d)>(%d%d)>(%d%d)>(%d%d)",
                                 a[0],b[0],a[1],b[1],a[2],b[2],a[3],b[3],a[4],a[4]);   //logging a case
            
            // assigning outputs in time intervals
            t_a = a[0];t_b = b[0];#delay;
            t_a = a[1];t_b = b[1];#delay;
            t_a = a[2];t_b = b[2];#delay;
            t_a = a[3];t_b = b[3];#delay;
            t_a = a[4];t_b = b[4];
           
            // this keeps the stimulus in sync with the DUT
            #(delay/2);
            
            // if sequence for entry
            if ((a==5'b01100) && (b==5'b00110) && (expected_count < 4'b1111)) 
                begin                    
                       expected_count = expected_count + 1;
                 end
               
            // if sequence for exit
            else if ((a==5'b00110) && (b==5'b01100) && (expected_count > 4'b0000)) 
                begin  
                
                      expected_count = expected_count - 1;
                end      
            #(delay*2);
        end
    endtask


    // task to run a condition with 6 times changing states
    // (a0,b0)>(a1,b1)>(a2,b2)>(a3,b3)>(a4,b4)>(a5,b5)
    task run_condition_6(input [0:5] a, input [0:5] b);
        begin
            $fdisplay(log, ">> Case: (%d%d)>(%d%d)>(%d%d)>(%d%d)>(%d%d)>(%d%d)",
                                  a[0],b[0],a[1],b[1],a[2],b[2],a[3],b[3],a[4],b[4],a[5],b[5]);  
        
            t_a = a[0];t_b = b[0];#delay;
            t_a = a[1];t_b = b[1];#delay;
            t_a = a[2];t_b = b[2];#delay;
            t_a = a[3];t_b = b[3];#delay;
            t_a = a[4];t_b = b[4];#delay;
            t_a = a[5];t_b = b[5];

            // this keeps the stimulus in sync with the DUT
            #(delay/2);
            // if input gate sequence is correct for entry
            if (((a==6'b011100 && b==6'b001110) || (a==6'b001100 && b==6'b000110)) && (expected_count < 4'b1111)) 
                begin                    
                       expected_count = expected_count + 1'b1;      
                end
                
            // if input gate sequence is correct for exit
            else if ((a==6'b000110 && b==6'b011100) && (expected_count > 4'b0000)) 
                begin
                      expected_count = expected_count - 1'b1;
                end
           end
    endtask
    
    // task to trigger test termination in scoreboard
    task terminate_test();
        begin   
            $display(">> Stopping Test Termination");   
            finish = 1;
            #(delay/2);
            finish = 0;
            #(delay/2);
        end
    endtask
    
endmodule