`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 04:29:19 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q3
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



module CS25B011_Session8_Q3 (
    input  wire E,
    input  wire W,
    input  wire P1_BUSY,
    input  wire P2_BUSY,
    input  wire P3_BUSY,
    input  wire PRI,

    output wire E_GREEN,
    output wire E_RED,
    output wire W_GREEN,
    output wire W_RED,

    output wire EP1,
    output wire EP2,
    output wire EP3,

    output wire WP1,
    output wire WP2,
    output wire WP3,

    output wire P1_FREE,
    output wire P1_BUSY_LED,
    output wire P2_FREE,
    output wire P2_BUSY_LED,
    output wire P3_FREE,
    output wire P3_BUSY_LED
);

    wire F1, F2, F3;
    wire ANY_FREE;
    wire TWO_FREE;
    wire ONE_FREE;

    assign F1 = ~P1_BUSY;
    assign F2 = ~P2_BUSY;
    assign F3 = ~P3_BUSY;

    assign ANY_FREE = F1 | F2 | F3;

    assign TWO_FREE = (F1 & F2) | (F1 & F3) | (F2 & F3);

    // Exactly one platform is free.
    assign ONE_FREE = ANY_FREE & ~TWO_FREE;

    wire PRI_WINNER;

    mux2to1 u_priority_mux (
        .A(E),
        .B(W),
        .S(PRI),
        .Y(PRI_WINNER)
    );

    wire E_GRANT;
    wire W_GRANT;

    assign E_GRANT = ANY_FREE &
                     ( (E & ~W) |
                       (E & W & (TWO_FREE | (ONE_FREE & PRI_WINNER))) );

    assign W_GRANT = ANY_FREE &
                     ( (W & ~E) |
                       (E & W & (TWO_FREE | (ONE_FREE & ~PRI_WINNER))) );

    wire E_F1, E_F2, E_F3;
    wire E_SEL1, E_SEL0;
    wire E_UNUSED;

    assign E_F1 = F1;
    assign E_F2 = ~F1 & F2;
    assign E_F3 = ~F1 & ~F2 & F3;

    assign E_SEL1 = E_F3;
    assign E_SEL0 = E_F2;

    demux1to4 u_east_demux (
        .D(E_GRANT),
        .S1(E_SEL1),
        .S0(E_SEL0),
        .Y0(EP1),
        .Y1(EP2),
        .Y2(EP3),
        .Y3(E_UNUSED)
    );

    wire W_F1, W_F2, W_F3;
    wire W_SEL1, W_SEL0;
    wire W_UNUSED;

    assign W_F1 = F1 & ~EP1;
    assign W_F2 = F2 & ~EP2;
    assign W_F3 = F3 & ~EP3;

    assign W_SEL1 = ~W_F1 & ~W_F2 & W_F3;
    assign W_SEL0 = ~W_F1 & W_F2;

    demux1to4 u_west_demux (
        .D(W_GRANT),
        .S1(W_SEL1),
        .S0(W_SEL0),
        .Y0(WP1),
        .Y1(WP2),
        .Y2(WP3),
        .Y3(W_UNUSED)
    );

    assign E_GREEN = E_GRANT;
    assign E_RED   = ~E_GRANT;

    assign W_GREEN = W_GRANT;
    assign W_RED   = ~W_GRANT;

    assign P1_FREE     = ~P1_BUSY;
    assign P1_BUSY_LED =  P1_BUSY;

    assign P2_FREE     = ~P2_BUSY;
    assign P2_BUSY_LED =  P2_BUSY;

    assign P3_FREE     = ~P3_BUSY;
    assign P3_BUSY_LED =  P3_BUSY;

endmodule
