`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: SevenSegmentControl
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/31/18
*
* Description: A seven segment controller for each of the 8 digit displays
* 
*************************************************************************/



module SevenSegmentControl(
    input clk, logic[31:0] dataIn, logic[7:0] digitDisplay, digitPoint,
    output logic[7:0] anode, segment);
    
    logic[16:0] count = 0;
    logic[2:0] digitSelect;
    logic[3:0] data;
    logic segment7bar;
    
    always_ff @(posedge clk)
        count <= count + 1;
    
    assign digitSelect = count[16:14];
    
   assign anode = ~((8'h01 << digitSelect) & digitDisplay);
   
   assign data = (digitSelect == 3'b000) ? dataIn[3:0]:
       (digitSelect == 3'b001) ? dataIn[7:4]:
       (digitSelect == 3'b010) ? dataIn[11:8]:
       (digitSelect == 3'b011) ? dataIn[15:12]:
       (digitSelect == 3'b100) ? dataIn[19:16]:
       (digitSelect == 3'b101) ? dataIn[23:20]:
       (digitSelect == 3'b110) ? dataIn[27:24]:
       dataIn[31:28];
   
    assign segment[6:0] =(data == 4'h0) ? 7'b1000000 :
        (data == 4'h1) ? 7'b1111001 :
        (data == 4'h2) ? 7'b0100100 :
        (data == 4'h3) ? 7'b0110000 :
        (data == 4'h4) ? 7'b0011001 :
        (data == 4'h5) ? 7'b0010010 :
        (data == 4'h6) ? 7'b0000010 :
        (data == 4'h7) ? 7'b1111000 :
        (data == 4'h8) ? 7'b0000000 :
        (data == 4'h9) ? 7'b0010000 :
        (data == 4'ha) ? 7'b0001000 :
        (data == 4'hb) ? 7'b0000011 :
        (data == 4'hc) ? 7'b1000110 :
        (data == 4'hd) ? 7'b0100001 :
        (data == 4'he) ? 7'b0000110 :
        7'b0001110;
    
    assign segment7bar = (digitSelect == 3'b000) ? digitPoint[0]:
        (digitSelect == 3'b001) ? digitPoint[1]:
        (digitSelect == 3'b010) ? digitPoint[2]:
        (digitSelect == 3'b011) ? digitPoint[3]:
        (digitSelect == 3'b100) ? digitPoint[4]:
        (digitSelect == 3'b101) ? digitPoint[5]:
        (digitSelect == 3'b110) ? digitPoint[6]:
        digitPoint[7];
    assign segment[7] = ~segment7bar;
    
endmodule
