`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 03:46:25 PM
// Design Name: 
// Module Name: CS25B011_Session6_tb
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
module P1_gate_tb;

    reg A, B, C, D, E;
    wire F;
    P1_gate uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .F(F)
    );
    initial begin
        $monitor("A=%b B=%b C=%b D=%b E=%b | F=%b",
                  A, B, C, D, E, F);
        A=0;B=0;C=0;D=0;E=0;
        #10;
        A=0;B=0;C=0;D=1;E=0;
        #10;
        A=0;B=0;C=1;D=1;E=1;
        #10;
        A=1;B=1;C=1;D=1;E=0;
        #10;
        A=1;B=1;C=1;D=1;E=1;
        #10;
        A=1;B=0;C=1;D=1E=1;
        #10;
        A=1;B=1;C=1;D=1;E=0;
        #10;
        A=0;B=1;C=1;D=1;E=0;
        #10;
        $finish;
    end
endmodule

