`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// 
// Module Name: seven_segment
//
// Author: Evan Nuss
// Class: ECEn 220, Section 1, Fall 2018
// Date: 10/16/18
//
// Description: logic functions for seven segment decoder
//
//////////////////////////////////////////////////////////////////////////////////


module seven_segment(
    input logic[3:0] data,
    output logic[6:0] segment);
    
    logic[3:0] dbar, a;
    
    not(dbar[0], data[0]);
    not(dbar[1], data[1]);
    not(dbar[2], data[2]);
    not(dbar[3], data[3]);
    
    and(a[0], dbar[3], dbar[2], dbar[1], data[0]);
    and(a[1], dbar[3], dbar[1], dbar[0], data[2]);
    and(a[2], data[3], data[2], dbar[1], data[0]);
    and(a[3], data[3], dbar[2], data[1], data[0]);
    
    or(segment[0], a[0], a[1], a[2], a[3]);
    
    logic[3:0] dbar2; 
    logic[3:0] b;
    
    not(dbar2[0], data[0]);
    not(dbar2[1], data[1]);
    not(dbar2[2], data[2]);
    not(dbar2[3], data[3]);
    
    and(b[0], dbar2[3], data[2], dbar2[1], data[0]);
    and(b[1], data[3], data[2], dbar2[1], dbar2[0]);
    and(b[2], data[2], data[1], dbar2[0]);
    and(b[3], data[3], data[1], data[0]);
    
    or(segment[1], b[0], b[1], b[2], b[3]);
    
    LUT4 #(16'hd004) seg0(.O(segment[2]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h8492) seg1(.O(segment[3]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h02ba) seg2(.O(segment[4]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h208e) seg3(.O(segment[5]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
    LUT4 #(16'h1083) seg4(.O(segment[6]), .I0(data[0]), .I1(data[1]), .I2(data[2]), .I3(data[3]));
endmodule
