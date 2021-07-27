`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: arithmetic_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/8/18
*
* Description: Instances my 9-bit adder and connects it to the switches and LEDs
* 
*************************************************************************/


module arithmetic_top(
    output logic[8:0] led,
    input logic btnl, btnr, logic[15:0] sw);
    
    logic[8:0] A, B;
    logic carryout;
    
    xor(B[0], sw[0], btnr);
    xor(B[1], sw[1], btnr);
    xor(B[2], sw[2], btnr);
    xor(B[3], sw[3], btnr);
    xor(B[4], sw[4], btnr);
    xor(B[5], sw[5], btnr);                          
    xor(B[6], sw[6], btnr);
    xor(B[7], sw[7], btnr);
    xor(B[8], sw[7], btnr);
    
    and(A[0], sw[8], ~btnl);
    and(A[1], sw[9], ~btnl);
    and(A[2], sw[10], ~btnl);
    and(A[3], sw[11], ~btnl);
    and(A[4], sw[12], ~btnl);
    and(A[5], sw[13], ~btnl);
    and(A[6], sw[14], ~btnl);
    and(A[7], sw[15], ~btnl);
    and(A[8], sw[15], ~btnl);
  
    Add9 Add(carryout, led, btnr, A, B);
endmodule
