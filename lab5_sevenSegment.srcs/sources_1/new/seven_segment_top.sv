`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// 
// Module Name: seven_segment_top
//
// Author: Evan Nuss
// Class: ECEn 220, Section 1, Fall 2018
// Date: 10/16/18
//
// Description: top level design for seven segment decoder
//
//////////////////////////////////////////////////////////////////////////////////


module seven_segment_top(
    input logic btnc, logic[3:0] sw,
    output logic[7:0] segment, anode);
    
    seven_segment D0(sw, segment[6:0]);
    
    not(segment[7], btnc);
    
    assign anode = 8'b11111110;
endmodule
