`timescale 1ns / 1ps
/*************************************************************************
* 
* Module: register_file_8x4
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/30/18
*
* Description: An 8x4 register file
* 
*************************************************************************/


module register_file_8x4(
    input clk, we, logic[3:0] datain, logic[2:0] waddr, raddr1, raddr2,
    output logic[3:0] dataout1, dataout2);
    
    logic[7:0] decoded;
    logic[3:0] regout1, regout2, regout3,
    regout4, regout5, regout6, regout7, regout8;
    
    assign decoded = we << waddr;
    
    register4 M0(clk, decoded[0], datain, regout1);
    register4 M1(clk, decoded[1], datain, regout2);
    register4 M2(clk, decoded[2], datain, regout3);
    register4 M3(clk, decoded[3], datain, regout4);
    register4 M4(clk, decoded[4], datain, regout5);                                        
    register4 M5(clk, decoded[5], datain, regout6);
    register4 M6(clk, decoded[6], datain, regout7);
    register4 M7(clk, decoded[7], datain, regout8);
    
    assign dataout1 = (raddr1 == 3'b000) ? regout1:
        (raddr1 == 3'b001) ? regout2:
        (raddr1 == 3'b010) ? regout3:
        (raddr1 == 3'b011) ? regout4:
        (raddr1 == 3'b100) ? regout5:
        (raddr1 == 3'b101) ? regout6:
        (raddr1 == 3'b110) ? regout7:
        regout8;
    
    assign dataout2 = (raddr2 == 3'b000) ? regout1:
        (raddr2 == 3'b001) ? regout2:
        (raddr2 == 3'b010) ? regout3:
        (raddr2 == 3'b011) ? regout4:
        (raddr2 == 3'b100) ? regout5:
        (raddr2 == 3'b101) ? regout6:
        (raddr2 == 3'b110) ? regout7:
        regout8;

endmodule
