`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
//
//  Filename: tb_pwm.v
//
//  Author: Mike Wirthlin
//  
//  Description: 
//
//  Version 1.2
//
//  Change Log:
//    1.1: - Removed the enable for the PWM module and associated tests
//         - Updated output messages (messages given for correct output)
//    1.2: - Removed parameterized COUNT_WIDTH
//         - Change the testbench names (tb_)
//
//////////////////////////////////////////////////////////////////////////////////

module tb_pwm();

    localparam COUNT_WIDTH = 14;
	reg tb_clk;
	wire tb_pulse;
	reg [COUNT_WIDTH-1:0] tb_width;
	integer j, errors;
	time d_time,e_time,t_time;

	// Instance the DUT
	PWM dut(.clk(tb_clk), .width(tb_width), .pulse(tb_pulse));

	// Need to create a clock
	initial begin
		#100 // wait 100 ns before starting clock (after inputs have settled)
		tb_clk = 0;
		forever begin
			#5  tb_clk = ~tb_clk;
		end
	end	
	
	initial begin

        // print %t with scaled in ns (-9), with 2 precision digits, and would print the " ns" string
		$timeformat(-9, 0, " ns", 20);
		$display("*** Start of Simulation ***");

        // Start off with PWM turned off (make sure there are no pulses)
    /*
        en1 = 0;
		width1 = 0;
		repeat (2**12+100) @ (negedge clk); 		
    */
		errors = 0;
		
        // Turn on PWM with varying width (using powers of 2)
        //en1 = 1;
        for (j=0; j<12; j=j+1) begin
           tb_width = 1<<j;
           e_time = (tb_width)*10;  // expected widtg
		  // Wait until the pulse changes
	   	   @(posedge tb_pulse);
		   t_time = $time;
		   @(negedge tb_pulse);
           d_time = $time - t_time;
           if (d_time != e_time) begin
    		  $display("Incorrect pulse width of %0t (expecting %0t) at time %0t",d_time,e_time,$time);
	  		 errors = errors + 1;
           end else
    		  $display("Correct pulse width of %0t at time %0t",d_time,$time);
           
           // Wait until we start the next pulse before doing anything.
	   	   @(posedge tb_pulse);
        end
        
        // Turn on PWM with full width
   	   @(posedge tb_pulse);
        tb_width = 12'hFFF;
        e_time = (tb_width)*10;  // expected widtg
   	   @(posedge tb_pulse);
  	   t_time = $time;
        @(negedge tb_pulse);
        d_time = $time - t_time;
        if (d_time != e_time) begin
           $display("Incorrect pulse width of %0t (expecting %0t) at time $0t",d_time,e_time,$time);
        end else
           $display("Correct pulse width of %0t at time %0t",d_time,$time);

		repeat (2**8) @ (negedge tb_clk); 		   
        
		$display("*** Simulation done at time %0t (%0d errors) ***", $time, errors);
		$finish;

	end  // end initial begin

	// This block will check to see if the PWM pulse ever changes. It will end the simulation
	// if it does not see a pulse. The main initial block will block until a pulse changes
	// and thus hang if the student's module does not change the PWM signal.
	//always@(negedge clk) begin
	//end
	
    // Make sure pulse is never asserted when EN is not enabled
	//always@(posedge clk)
	//   en_d = en1;

    //always@(en_d or pulse1) begin
    //    if (en_d == 1'b0 && pulse1 == 1'b1) begin
    //        $display("Pulse is asserted but en is low at time %t",$time);
    //    end
    //end
        	   
endmodule