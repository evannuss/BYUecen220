`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: debounce_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/27/18
*
* Description: Top-level design for a debounce state machine
* 
*************************************************************************/


module debounce_top(
    input logic clk, btnd, btnc,
    output logic[7:0] anode, segment);
    
    logic synchBtnd1 = 0, synchBtnd2 = 0;
    logic synchBtnc1 = 0, synchBtnc2 = 0, debounced, isEdge, edgeState = 0;
    logic[15:0] counter = 0, counter2 = 0;
    
    always_ff @(posedge clk)
    begin
        synchBtnc1 <= btnc;
        synchBtnd1 <= btnd;
    end
        
    always_ff @(posedge clk)
    begin
        synchBtnc2 <= synchBtnc1;
        synchBtnd2 <= synchBtnd1;
    end
        
    debounce M0(clk, synchBtnc2, debounced); 
    
    always_ff @(posedge clk)
    begin
        if(edgeState == 0 && debounced == 1) edgeState <= 1;
        else if(edgeState == 1 && debounced == 0) edgeState <= 0; 
    end
    
    assign isEdge = (edgeState == 0 && debounced == 1) ? 1 : 0;
    
    always_ff @(posedge clk)
        if(isEdge) counter <= counter + 1;
        else if(synchBtnd2) counter <= 0;
        
    always_ff @(posedge clk)
        if(synchBtnc2) counter2 <= counter + 1;
        else if(synchBtnd2) counter2 <= 0;
        
    SevenSegmentControl M1(clk, {counter2, counter}, 8'b11111111, 8'b00000000, anode, segment);
    
endmodule
