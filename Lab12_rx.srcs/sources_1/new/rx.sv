`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: rx
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 12/4/18
*
* Description: Asynchronous Receiver
* 
*************************************************************************/


module rx(
    input logic clk, rx_in, odd,
    output logic[7:0] dout, logic busy, Error, data_strobe);
    
    //PARAMETERS
    parameter CLK_FREQUENCY = 100000000;
    parameter BAUD_RATE = 19200;
    
    localparam MAX_COUNT = CLK_FREQUENCY / BAUD_RATE;
    
    function integer clogb2;
      input [31:0] value;
      begin
        value = value - 1;
        for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
          value = value >> 1;
        end
      end
    endfunction
    
    localparam NUM_BITS = clogb2(MAX_COUNT);
    
    logic ResetTimer, LastCycle, HalfCycle, ResetCounter, NextBit;
    logic ParityBit, stop, Shift, NewParityBit;
    
    /////////////////    
    //BAUD RATE TIMER
    logic[NUM_BITS-1:0] counter = 0;
        
    always_ff @(posedge clk)
    begin
        if(ResetTimer) counter <= 0;
        else counter <= counter + 1;
    end
    
    assign LastCycle = (counter == MAX_COUNT) ? 1 : 0;
    assign HalfCycle = (counter == (MAX_COUNT/2)) ? 1 : 0;
    
    /////////////////
    //BIT COUNTER
    logic[3:0] bitCounter = 0;
    
    always_ff @(posedge clk)
    begin
        if(ResetCounter) bitCounter <= 0;
        else if(NextBit) bitCounter <= bitCounter + 1;
    end
    
    assign LastBit = (bitCounter == 4'd11) ? 1 : 0;

    /////////////////
    //SHIFT REGISTER
    logic[9:0] data = 10'b1111111111;
    
    always_ff @(posedge clk)
    begin
        if(Shift) data <= {rx_in, data[9:1]};
    end 
    
    assign stop = data[9];
    assign ParityBit = data[8];
    assign dout = data[7:0];

    /////////////////
    //ERROR CHECKER
    assign NewParityBit = (^dout) ^ odd;
    assign Error = (stop == 0 || !(NewParityBit == ParityBit)) ? 1 : 0;
    
    /////////////////
    //FSM
    typedef enum logic[2:0] {S0, S1, S2, S3, S4} StateType;
    StateType ns, cs = S0;
    
    always_comb
    begin
        ResetCounter = 0;
        ResetTimer = 0;
        Shift = 0;
        NextBit = 0;
        ns = cs;
        case(cs)
        S0: begin
            ResetTimer = 1;
            ResetCounter = 1;
            if(!rx_in) ns <= S1;
        end
        S1: begin
            if(HalfCycle) ns <= S2;
            else if(!HalfCycle && rx_in) ns <= S0;
        end
        S2: begin
            Shift = 1;
            ResetTimer = 1;
            NextBit = 1;
            ns <= S3;
        end
        S3: begin
            if(LastBit) ns <= S0;
            else if(LastCycle) ns <= S2;
        end
        endcase
    end
    
    always_ff @(posedge clk)
        cs <= ns;
    
    assign data_strobe = LastBit ? 1 : 0;
    assign busy = !(cs == S0);
    
    
endmodule
