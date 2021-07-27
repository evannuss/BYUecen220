/*********************************************************************************
*
* Module: FourFunctions
*
* Author: Evan Nuss
* Class: ECEn 220. Section 1, Fall 2018
* Date: 9/25/18
*
* Description
*
*
*********************************************************************************/

module FourFunctions(A, B, C, O1, O2, O3, O4);
	output logic O1, O2, O3, O4;
	input logic A, B, C;
	
	//Function 1
	logic Abar, a1, a2;	

	not(Abar, A);
	and(a1, Abar, B);
	and(a2, A, C);
	or(O1, a1, a2);

	//Function 2	
	logic Cbar, b1, b2;
	
	not(Cbar, C);
	or(b1, A, Cbar);
	and(b2, B, C);
	and(O2, b1, b2);

	//Function 3
	logic Bbar, c1;

	not(Bbar, B);
	and(c1, A, Bbar);
	or(O3, c1, C);

	//Function 4
	logic AB, BbarCbar, d1, ABbar, Cbar2, Bbar2, d4;

	and(AB, A, B);
	not(ABbar, AB);
	not(Cbar2, C);
	not(Bbar2, B);
	and(BbarCbar, Bbar2, Cbar2);
	not(d1, BbarCbar);
	and(d4, ABbar, d1);
	not(O4, d4);
	
	//Function 5 
	//(C + A') + B(C + A)
	or(AorC, A, C);
	and(rightSide, AorC, B);
	not(Abar2, A);
	or(leftSide, Abar2, C);
	or(O5, leftSide, rightSide);
endmodule