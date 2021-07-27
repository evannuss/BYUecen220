`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: Register4
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/30/18
*
* Description: A 4-bit register
* 
*************************************************************************/



module register4(
    input clk, we, logic[3:0] datain,
    output logic[3:0] dataout);
    
    FDCE my_ff1 (.Q(dataout[0]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[0]));
    FDCE my_ff2 (.Q(dataout[1]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[1]));
    FDCE my_ff3 (.Q(dataout[2]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[2]));
    FDCE my_ff4 (.Q(dataout[3]), .C(clk), .CE(we), .CLR(1'b0), .D(datain[3]));
    
endmodule
