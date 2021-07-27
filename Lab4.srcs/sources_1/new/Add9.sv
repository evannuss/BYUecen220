/*************************************************************************
* 
* Module: Add9
* 
* Author: Evan Nuss
* Class: ECEn 220, Section 1, Fall 2018
* Date: 10/8/18
*
* Description: A 9-bit ripple-carry adder
* 
*************************************************************************/

module Add9(
    output logic co, logic[8:0] s, 
    input logic cin, logic[8:0] a, b);
    logic[7:0] cout;
    
    FullAdd M0(s[0], cout[0], cin, a[0], b[0]);
    FullAdd M1(s[1], cout[1], cout[0], a[1], b[1]);
    FullAdd M2(s[2], cout[2], cout[1], a[2], b[2]);
    FullAdd M3(s[3], cout[3], cout[2], a[3], b[3]);
    FullAdd M4(s[4], cout[4], cout[3], a[4], b[4]);
    FullAdd M5(s[5], cout[5], cout[4], a[5], b[5]);
    FullAdd M6(s[6], cout[6], cout[5], a[6], b[6]);
    FullAdd M7(s[7], cout[7], cout[6], a[7], b[7]);
    FullAdd M8(s[8], co, cout[7], a[8], b[8]);
endmodule