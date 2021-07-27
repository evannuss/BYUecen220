`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: PWM_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 11/6/18
*
* Description: Top-level design for pulse width modulation
* 
*************************************************************************/


module PWM_top(
    input logic clk, logic[11:0] sw,
    output logic pulse_red, pulse_green, pulse_blue,
    logic[7:0] segment, anode, logic[2:0] debug);
    
    logic[13:0] red_width, green_width, blue_width;
    
    PWM M0(clk, red_width, pulse_red);
    PWM M1(clk, green_width, pulse_green);
    PWM M2(clk, blue_width, pulse_blue);
    
    assign red_width[12:9] = sw[11:8];
    assign red_width[13] = 1'b0;
    assign red_width[8:0] = 9'b0;
    
    assign green_width[12:9] = sw[7:4];
    assign green_width[13] = 1'b0;
    assign green_width[8:0] = 9'b0;
    
    assign blue_width[12:9] = sw[3:0];
    assign blue_width[13] = 1'b0;
    assign blue_width[8:0] = 9'b0;
    
    SevenSegmentControl M3(clk, {20'h00000, sw}, 8'b00000111, 8'b0, anode, segment);
    
    assign debug[0] = pulse_red;
    assign debug[1] = pulse_green;
    assign debug[2] = pulse_blue;
    
endmodule
