`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 02:15:16 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q1
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

module mux2to1(
    input wire A,B,S,
    output wire Y
);
    assign Y = S ? B : A; 
endmodule

module mux4to1(
    input wire D0,D1,S2,D3,S1,S0,
    output wire Y
);
    wire M0,M1;
    mux2to1 m0(.A(D0),.B(D1),.S(S0),.Y(M0));
    mux2to1 m1(.A(D2),.B(D3),.S(S0),.Y(M1));
    mux2to1 m2(.A(M0),.B(M1),.S(S1),.Y(Y));
endmodule

module CS25B011_Session8_Q1(
    input D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,
    input S0,S1,S2,S3,
    output Y
    );
    wire Y0,Y1,Y2,Y3;
    mux4to1 m0(D0,D1,D2,D3,S1,S0,Y0);
    mux4to1 m1(D4,D5,D6,D7,S1,S0,Y1);
    mux4to1 m2(D8,D9,D10,D11,S1,S0,Y2);
    mux4to1 m3(D12,D13,D14,D15,S1,S0,Y3);
    
    mux4to1 m4(Y0,Y1,Y2,Y3,S3,S2,Y);
endmodule
