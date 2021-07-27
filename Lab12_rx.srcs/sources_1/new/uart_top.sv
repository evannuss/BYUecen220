`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: uart_top
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 12/4/18
*
* Description: Top-level design for UART transmitter and receiver
* 
*************************************************************************/


module uart_top(
    input logic clk, btnc, rx_in, logic[7:0] sw,
    output logic tx_out, rx_error, tx_debug, rx_debug, logic[7:0] segment, anode);
    
    logic send, unused, unused2, unused3, synchBtnc1, synchBtnc2;
    logic[7:0] rx_data;
    
    tx M0(clk, send, 1'b0, sw, unused, tx_out);
    assign tx_debug = tx_out;

    always_ff @(posedge clk)
        synchBtnc1 <= btnc;
        
    always_ff @(posedge clk)
        synchBtnc2 <= synchBtnc1;
        
    debounce M1(clk, synchBtnc2, send);
    
    rx M2(clk, rx_in, 1'b0, rx_data, unused2, rx_error, unused3);
    assign rx_debug = rx_in;
    
    SevenSegmentControl M3(clk, {8'd0, rx_data, 8'd0, sw}, 8'b00110011, 8'b00000000, anode, segment);

endmodule
