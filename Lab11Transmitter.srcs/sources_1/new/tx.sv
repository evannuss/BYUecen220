`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: tx
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/29/18
*
* Description: Asynchronous Transciever
* 
*************************************************************************/



module tx(
    input logic clk, send, odd, logic[7:0] din,
    output logic busy, tx_out);
    
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
    
    /////////////////
    //FSM
    typedef enum logic[2:0] {S0, S1, S2, S3, S4} StateType;
    StateType ns, cs = S0;

    logic Load, ResetCounter, ResetTimer, EnableTimer, Shift, NextBit;
    logic LastBit, LastCycle;
    
    always_comb
    begin
        Load = 0;
        ResetCounter = 0;
        ResetTimer = 0;
        busy = 0;
        EnableTimer = 0;
        Shift = 0;
        NextBit = 0;
        ns = cs;
        
        case(cs)
        S0: if(send) ns <= S1;
        S1: begin
            Load = 1;
            busy = 1;
            ResetCounter = 1;
            ResetTimer = 1;
            ns <= S2;
        end
        S2: begin
            busy = 1;
            EnableTimer = 1;
            if(LastCycle) ns <= S3;
        end
        S3: begin
            Shift = 1;
            ResetTimer = 1;
            NextBit = 1;
            busy = 1;
            if(!LastBit) ns <= S2;
            else if(LastBit) ns <= S4;
        end
        S4: if(!send) ns <= S0;
        endcase
    end
    
    always_ff @(posedge clk)
        cs <= ns;

    /////////////////    
    //BAUD RATE TIMER
    logic[NUM_BITS-1:0] counter = 0;
        
    always_ff @(posedge clk)
    begin
        if(ResetTimer) counter <= 0;
        else if(EnableTimer) counter <= counter + 1;
    end
    
    assign LastCycle = (counter == MAX_COUNT) ? 1 : 0;
    
    /////////////////
    //PARITY GENERATOR
    logic ParityBit;
    assign ParityBit = (^din) ^ odd;
     
    /////////////////
    //BIT COUNTER
    logic[3:0] bitCounter = 0;
    
    always_ff @(posedge clk)
    begin
        if(ResetCounter) bitCounter <= 0;
        else if(NextBit) bitCounter <= bitCounter + 1;
    end
    
    assign LastBit = (bitCounter == 4'd10) ? 1 : 0;
    
    /////////////////
    //SHIFT REGISTER
    logic[9:0] data = 10'b1111111111;
    
    always_ff @(posedge clk)
    begin
        if(Load) data <= {ParityBit, din, 1'b0};
        else if(Shift) data <= {1'b1, data[9:1]};
    end
    
    assign tx_out = data[0];
    
endmodule
