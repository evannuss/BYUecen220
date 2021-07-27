`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: Dataflow
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/22/18
*
* Description:
* 
*************************************************************************/



module Dataflow(
    input logic[15:0] sw, logic btnc, btnu, btnl, btnr, btnd, 
    output logic[15:0] led, logic[7:0] segment, anode);
    
    logic[3:0] data;
    
    seven_segment D(data, segment[6:0]);
    assign segment[7] = 1'b1;
    
    assign data = (btnd == 1'b1)? sw[3:0] + sw[7:4]:
        (btnu == 1'b1)? sw[3:0] - sw[7:4]:
        (btnr == 1'b1)? 4'b1000:
        (btnl == 1'b0 && btnc == 1'b0)? sw[3:0]:
        (btnl == 1'b0 && btnc == 1'b1)? sw[7:4]:
        (btnl == 1'b1 && btnc == 1'b0)? sw[11:8]:
        sw[15:12];
        
    assign led = (data == 4'h0)? 16'b0000000000000001:
        (data == 4'h1)? 16'b0000000000000010:
        (data == 4'h2)? 16'b0000000000000100:
        (data == 4'h3)? 16'b0000000000001000:
        (data == 4'h4)? 16'b0000000000010000:
        (data == 4'h5)? 16'b0000000000100000:
        (data == 4'h6)? 16'b0000000001000000:
        (data == 4'h7)? 16'b0000000010000000:
        (data == 4'h8)? 16'b0000000100000000:
        (data == 4'h9)? 16'b0000001000000000:
        (data == 4'ha)? 16'b0000010000000000:
        (data == 4'hb)? 16'b0000100000000000:
        (data == 4'hc)? 16'b0001000000000000:
        (data == 4'hd)? 16'b0010000000000000:
        (data == 4'he)? 16'b0100000000000000:
        16'b1000000000000000;

    assign anode = 8'b11111110;
            
endmodule
