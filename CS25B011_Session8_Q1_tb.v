`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 03:18:56 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q1_tb
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



module CS25B011_Session8_Q1_tb;
    reg [15:0] D;
    reg S3,S2,S1,S0;
    wire Y;
    integer i;
    reg expected;

    CS25B011_Session8_Q1 DUT (
        .D0(D[0]), .D1(D[1]), .D2(D[2]), .D3(D[3]),
        .D4(D[4]), .D5(D[5]), .D6(D[6]), .D7(D[7]),
        .D8(D[8]), .D9(D[9]), .D10(D[10]), .D11(D[11]),
        .D12(D[12]), .D13(D[13]), .D14(D[14]), .D15(D[15]),
        .S3(S3), .S2(S2), .S1(S1), .S0(S0), .Y(Y)
    );

//    task test_pattern;
//        input [15:0] pattern;
//        begin
//            D = pattern;
//            for (i=0; i<16; i=i+1) begin
//                {S3,S2,S1,S0} = i[3:0];
//                #10;
//                expected = pattern[i];
//                if (Y !== expected)
//                    $display("FAIL: D=%b S=%b Expected=%b Got=%b",
//                             pattern,{S3,S2,S1,S0},expected,Y);
//                else
//                    $display("PASS: D=%b S=%b Y=%b",
//                             pattern,{S3,S2,S1,S0},Y);
//            end
//        end
//    endtask

    initial begin
        D=16'b0000000000101011;
        S1=0;S3=0;S2=0;S0=0;
    end
endmodule
