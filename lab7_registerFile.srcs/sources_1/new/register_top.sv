`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: register_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/30/18
*
* Description: Top-level design for register file
* 
*************************************************************************/


module register_top(
    input clk, logic[9:0] sw, logic[0:0] btnc, btnr, btnu, btnd, btnl,
    output logic[7:0] segment, anode);
    
    logic[3:0] data;
    logic[3:0] dataout1, dataout2;
    
    register_file_8x4 m(clk, btnc, sw[3:0], sw[6:4], sw[6:4], sw[9:7], dataout1, dataout2);
    
    assign data = (btnr == 1'b1) ? dataout2 :
        (btnu == 1'b1) ? (dataout1 + dataout2) :
        (btnd == 1'b1) ? (dataout1 - dataout2) :
        (btnl == 1'b1) ? (dataout1 & dataout2) :
        dataout1;
    
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
    assign segment[7] = 1;
    
    assign anode = 8'b11111110;

    
endmodule
