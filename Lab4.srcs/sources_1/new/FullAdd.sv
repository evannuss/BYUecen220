`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: FullAdd
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/2/18
*
* Description: A single-bit full adder
* 
*************************************************************************/


module FullAdd(
    output logic s, co,
    input logic cin, a, b);
    
    xor(s, cin, a, b);
    
    logic AandB, BandCin, AandCin;
    
    and(AandCin, a, cin);
    and(BandCin, b, cin);
    and(AandB, a, b);
    or(co, AandB, BandCin, AandCin);
    
endmodule
