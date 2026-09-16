`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 02:35:26 PM
// Design Name: 
// Module Name: CS25B011_Session6
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
*/
module P1_gate(
    input  A,
    input  B,
    input  C,
    input  D,
    input  E,
    output F
);
    wire nA;
    wire nB;
    wire nC;
    wire nE;
    wire t1;
    wire t2;
    wire t3;
    wire t4;
    not (nA,A);
    not (nB,B);
    not (nC,C);
    not (nE,E);
    and (t1,A,B,C,D);
    and (t2,nB,C,D,E);
    and (t3,nA,nB);
    and (t4,B,C,nE);
    or (F,t1,t2,t3,t4);
endmodule


