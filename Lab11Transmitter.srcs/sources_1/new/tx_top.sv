`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: tx_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 12/3/18
*
* Description: Top level design for an asynchronous transciever
* 
*************************************************************************/


module tx_top(
    input logic clk, btnc, logic[7:0] sw,
    output logic tx_out, logic[7:0] segment, anode, logic tx_debug);
    
    logic send, unused, synchBtnc1, synchBtnc2;
    
    tx M0(clk, send, 1'b0, sw, unused, tx_out);
    tx M1(clk, send, 1'b0, sw, unused, tx_debug);
    
    SevenSegmentControl M3(clk, {24'd0, sw}, 8'b00000011, 8'b00000000, anode, segment);
    
    always_ff @(posedge clk)
        synchBtnc1 <= btnc;
        
    always_ff @(posedge clk)
        synchBtnc2 <= synchBtnc1;
        
    debounce M4(clk, synchBtnc2, send);

endmodule
