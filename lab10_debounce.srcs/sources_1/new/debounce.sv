`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: debounce
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/27/18
*
* Description: A debounce state machine
* 
*************************************************************************/



module debounce(
    input logic clk, noisy,
    output logic debounced);
    
    logic timerDone, clrTimer, synchNoisy = 0;
    logic[18:0] timer = 0;
    
    always_ff @(posedge clk)
        synchNoisy <= noisy;
    
    typedef enum logic[2:0] {S0, S1, S2, S3} StateType;
    StateType ns = S0, cs = S0;
    
    always_ff @(posedge clk)
        if(clrTimer) timer <= 0;
        else timer <= timer + 1;
        
    assign timerDone = (timer == 19'd500000) ? 1 : 0;
    
    always_comb
    begin
        clrTimer = 0;
        ns = S0;
        debounced = 0;
        case(cs)
            S0: begin
                clrTimer = 1'b1; 
                if(synchNoisy) ns <= S1;
            end
            S1: begin
                if(synchNoisy && timerDone) ns <= S2;
                else if(!synchNoisy) ns <= S0;
                else ns <= S1;
            end
            S2: begin
                debounced = 1'b1;
                clrTimer = 1'b1;
                if(!synchNoisy) ns <= S3;
                else ns <= S2;
            end
            S3: begin
                debounced = 1'b1;
                if(!synchNoisy && timerDone) ns <= S0;
                else if(synchNoisy) ns <= S2;
                else ns <= S3;
            end
        endcase
    end          
    
    always_ff @(posedge clk)
        cs <= ns;  
    
endmodule
