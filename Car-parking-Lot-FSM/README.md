## Car Parking Lot FSM 
We designed an FSM to maintain a carpark occupancy count. It monitoring activity of cars using two sensors, as pictured in Figure 1 below. The desired behaviour for this
module was that the count would increase upon observation of a sensor sequence matching a car entering the carpark (sensor input ab = “00” → “10” → “11” → “01”→ ”00”), and decrease upon observation of a sensor sequence matching a car exiting the carpark (sensor input ab = “00” → “01” → “11” → “10” → ”00”). The carpark maximum occupancy was 15 vehicles
![alt text](https://github.com/ujjawal61/Car-parking-Lot-FSM/blob/main/4.PNG)
### Testbench.sv:
- Declared all the needful variables like clock, reset, check, finish, 4 bits count, and expected_count and log that will write all the log details in the I/O file.
- Instantiate all the modules stim_gem.sv as stim_gen, scoreboard.sv as score and top.v as DUT.
- Properly connect all the output and input pins from one module to another module.
### Stim_gen.sv:
- Clock time is set to 2ns and delay to set to 4ns.
- Test Strategy:
![alt text](https://github.com/ujjawal61/Car-parking-Lot-FSM/blob/main/1.PNG)
- Initialize: Initialised all the variables with the value 0.
- Full Reset: Set only a, b, expected_count to 0 and reset to 1 and after delay set reset to again 0.
- Increase the counter to 15: We keep increasing the counter from value 0 to 15 using basic entry state sequence, i.e. (00) -> (10) -> (11) –> (01) -> (00).
- Attempt to increase the counter one more time when it is already 15. We expect no change in the counter value.
- Decrease the counter to 15: We keep decreasing the counter from value 15 to 0 using basic exit state sequence, i.e. (00) -> (01) -> (11) -> (10) -> (00).
- Attempt to decrease the counter one more time when it is already 0. We expect no change in the counter value.
- Then trigger full system reset to test some particular state sequence cases.
- Increase the counter to 3 using 3 special state sequences like when the car remains stopped at some state in between before entering the parking lot. We expect our FSM to work accordingly.
- Decrease the counter to 1 using 2 special state sequences like when a car remains stopped at some state in between before exiting the parking lot. We expect our FSM to work accordingly.
- We reset our FSM and then terminate the simulation. It will set finish variable to 1 and terminate everything and then set it again to 0.
- To check that our expected count is equal to the FSM count we trigger the check_counter task after every test. That will set check value to 1, wait for T time, and then set again to 0.
- We also keep logging everything on the Tcl console and log file. This helps us a lot during debugging.
### Scoreboard.sv:
- In this file, we will open the log file.
- We are getting counter values from both FSM and stim_gen files. It will check the expected count value from stim_gen and count value from FSM whenever the check is equal to 1.
- If both of the counter value is equal then we increase the tests and pass variable value by 1. If they are not equal then only tests variable value will be increased.
-  Whenever we trigger the finish value to 1, then the stop_handler task will terminate the simulation. It will check the number of test cases passed and log that in the log file.
- In the end, will close the log file.
### Top.v:
- In this module, we are instantiating both FSM and counter as Device Under Test (DUT).
### BUGS:
I found a lot of bugs in my testbench and other modules. Some of the bugs I found with their solution are as follows:
- Some of the test cases were not running for some reason during the simulation. Butduring debugging I set a breakpoint on those test cases, and they were working fine. I found my mistake with the delay as my DUT was not in sync with the clock cycle causing the simulation to stop working.
- There was a minor error in FSM, as the exit was not triggering during state change as expected. Found this bug when the expected count and the observed count have a different value.
### Simulation Graph:
![alt text](https://github.com/ujjawal61/Car-parking-Lot-FSM/blob/main/2.PNG)
For log details: Refer to log file submitted. It was a long file, so I didn’t put it here.
### How to alter the test cases:
If you want to add some of your test cases like testing with large complex state sequences, then you need to make some modification as follows:
- Just copy the run_condition_6 task definition and add it to stim_gen.sv file under tasks definition section.
![alt text](https://github.com/ujjawal61/Car-parking-Lot-FSM/blob/main/3.PNG)
- Here, select the number of states you want in the sequence. Declare all a,b variables
accordingly.
- Then similarly declare t_a, t_b allocation task with delay in between them.
- Add those increase or decrease sequences in the if-else conditions as your
requirement, i.e. if you want to increase the counter using a particular 10-bit state
sequence then add that 10-bits sequence in the condition as well. This will increase or
decrease the expected count.
- You can call your newly made task in the test procedure section. Just make sure you
call full_reset before for the smooth running of your test cases. Remember to increase
your counter before decreasing them to observe some changes.
