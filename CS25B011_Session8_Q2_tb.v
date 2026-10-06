`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 03:12:07 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q2_tb
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


module CS25B011_Session8_Q2_tb;
    reg D,S1,S0;
    wire Y0,Y1,Y2,Y3;
    reg [3:0] expected;
    integer i;

    CS25B011_Session8_Q2 DUT (
        .D(D), .S1(S1), .S0(S0),
        .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3)
    );

    initial begin
        for (i=0; i<8; i=i+1) begin
            D  = i[2];
            S1 = i[1];
            S0 = i[0];
            #10;

            expected = 4'b0000;
            if (D)
                expected[i[1:0]] = 1'b1;

            if ({Y3,Y2,Y1,Y0} !== expected)
                $display("FAIL: D=%b S1S0=%b Expected=%b Got=%b",
                         D,{S1,S0},expected,{Y3,Y2,Y1,Y0});
            else
                $display("PASS: D=%b S1S0=%b Output=%b",
                         D,{S1,S0},{Y3,Y2,Y1,Y0});
        end
        $display("Q2: ALL 8 COMBINATIONS PASSED.");
        $finish;
    end
endmodule
