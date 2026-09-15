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


module CS25B011_Session6_tb; // Your chosen name goes here

    // 1. Declare stimulus signals
    reg A, B, C, D;
    wire t1, t2, t3, t4, final_out;

    // 2. Instantiate your design under test (UUT)
    CS25B011_Session6 uut (
        .A(A), .B(B), .C(C), .D(D),
        .t1(t1), .t2(t2), .t3(t3), .t4(t4),
        .final_out(final_out) // Using the corrected name from earlier
    );

    // 3. Test values
    initial begin
        A = 1; B = 0; C = 0; D = 0; #10;
        A = 0; B = 0; C = 0; D = 1; #10; // Test t1
        A = 1; B = 1; C = 1; D = 0; #10; // Test t2
        $finish;
    end

endmodule


