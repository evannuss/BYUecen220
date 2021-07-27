`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: PWM
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/6/18
*
* Description: A reusable pulse width modulator
* 
*************************************************************************/



module PWM(
    input clk, logic[13:0] width,
    output logic pulse);
    
    logic[13:0] counter = 0;
    logic outputFF;
    
    always_ff @(posedge clk)
        counter <= counter + 1;
        
    assign outputFF = (counter < width) ? 1'b1:
        1'b0;
        
     always_ff @(posedge clk)
        pulse <= outputFF;
    
endmodule
