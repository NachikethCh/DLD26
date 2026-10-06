`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 02:50:58 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q2
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


module CS25B011_Session8_Q2(
    input wire D,S1,S0,
    output wire Y0,Y1,Y2,Y3
    );
    assign Y0 = D & ~S1 & ~S0;
    assign Y1 = D & ~S1 & S0;
    assign Y2 = D & S1 & ~S0;
    assign Y3 = D & S1 & S0;
endmodule
