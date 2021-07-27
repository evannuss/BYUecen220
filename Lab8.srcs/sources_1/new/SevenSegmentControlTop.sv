`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: SevenSegmentControlTop
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/2/18
*
* Description: top level design for seven segment controller
* 
*************************************************************************/


module SevenSegmentControlTop(
    input clk, btnc, btnr, logic[15:0] sw,
    output logic[7:0] segment, anode);
    
    logic[31:0] dataIn;
    logic[7:0] digitDisplay, digitPoint;
        
    SevenSegmentControl M(clk, dataIn, digitDisplay, digitPoint, anode, segment);
    
    assign dataIn = (btnc == 1'b1) ? 32'h88888888 :
        {sw, sw};
    
    assign digitPoint = (btnc == 1'b1) ? 8'b11111111:
         8'b00000000;
        
    assign digitDisplay = (btnc == 1'b1) ? 8'b11111111:
        (btnr == 1'b1) ? 8'b00000000:
        8'b00001111;
  
endmodule
