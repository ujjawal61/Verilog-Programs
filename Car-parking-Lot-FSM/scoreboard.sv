`timescale 1ns / 1ps

module scoreboard(
    input clk,reset,a,b,check,finish,
    input [3:0] expected_count,count,
    output integer log );
  
    integer tests, pass;  //to keep track of total tests and pass test
    
    always @(posedge check) 
        begin
            $fdisplay(log, ">> Test No. %d", (tests+1));
            $fdisplay(log, ">> Expected Count: %d; Count: %d", expected_count, count);
            
            tests <= tests + 1;     // increment tests run
            
            if (count == expected_count) //if expected count and count from DUT is same then inc the pass test case
                begin
                    pass <= pass + 1;
                    $fdisplay(log, ">> PASS: OK\n");
                    $display(">> PASS: OK\n");
                end
            else 
                begin
                    $fdisplay(log, ">> PASS: FAIL\n");
                    $display(">> PASS: FAIL\n");
                end
        end
      
    // Monitor the gate sensors
    always @(a, b) 
        begin
            $fdisplay(log, ">> a: %b b: %b",a,b);
        end
    
    // scoreboard 
    initial 
        begin
            log = $fopen("fsm_log.txt", "w");                //create testing logfile
            tests  = 0;                                          
            pass = 0;                                            
            stop_handler();                               // run test termination handler
        end
    
    
    //======================================
    // task definitions
    //======================================
    
    // task to handle a when test is stop
    task stop_handler();
        begin
            // waiting for finish signal
            @(posedge finish);
            // log summary of full tests results
            $fdisplay(log, ">> Test finishd:%d of %d tests passed\n", pass, tests);
            
            // log final test result
            if (pass == tests) 
                begin
                    $fdisplay(log, ">> RESULT: ALL TESTS PASSED\n");
                end
            else 
                begin
                    $fdisplay(log, ">> RESULT: SOME OF THE TESTS HAVE FAILED\n");
                end
         
            $fclose(log);   // close logfile
        end
   endtask
endmodule   