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


/*module CS25B011_Session6(
    input A,
    input B,
    input C,
    input D,
    input E,
    output Z,
    output Y,output U,output T1,T2,final,output t1,t2,t3,t4,t5
);
and(Z,A,B);
and(Y,C,Z);
and(t1,Y,D);
and(W,~B,C);
and(V,W,D);
and(t2,V,E);
or(T1,t1,t2);
and(t3,~A,~B);
or(T2,T1,t3);
and(t3,B,C);
and(t4,t3,~E);
or(final,T2,t4);
endmodule
*/

module CS25B011_Session6(
input A,
input B,
input C,
input D,
output t1,t2,t3,t4,finalout,m1,m2,t5,g1,g2,m3,m4
);
and(t1,A,B);
and(t2,t1,C);
and(t3,t2,D);
and(m1,t3,~D);
and(m2,~t3,D);
or(g1,m1,m2);
and(t4,B,C);
and(t5,t4,D);
and(m3,t5,~A);
and(m4,~t5,A);
or(g2,m3,m4);
or(finalout,g1,g2);
endmodule
