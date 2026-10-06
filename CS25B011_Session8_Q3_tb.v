`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 04:31:41 PM
// Design Name: 
// Module Name: CS25B011_Session8_Q3_tb
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



module CS25B011_Session8_Q3_tb;
    reg E,W,P1_BUSY,P2_BUSY,P3_BUSY,PRI;
    wire E_GREEN,E_RED,W_GREEN,W_RED;
    wire EP1,EP2,EP3,WP1,WP2,WP3;
    wire P1_FREE,P1_BUSY_LED,P2_FREE,P2_BUSY_LED,P3_FREE,P3_BUSY_LED;

    CS25B011_Session8_Q3 DUT (
        .E(E), .W(W), .P1_BUSY(P1_BUSY), .P2_BUSY(P2_BUSY), .P3_BUSY(P3_BUSY), .PRI(PRI),
        .E_GREEN(E_GREEN), .E_RED(E_RED), .W_GREEN(W_GREEN), .W_RED(W_RED),
        .EP1(EP1), .EP2(EP2), .EP3(EP3), .WP1(WP1), .WP2(WP2), .WP3(WP3),
        .P1_FREE(P1_FREE), .P1_BUSY_LED(P1_BUSY_LED),
        .P2_FREE(P2_FREE), .P2_BUSY_LED(P2_BUSY_LED),
        .P3_FREE(P3_FREE), .P3_BUSY_LED(P3_BUSY_LED)
    );

    integer i, errors, free_count;
    reg exp_E, exp_W;
    reg [2:0] exp_EP, exp_WP;

    task check_case;
        input tE,tW,tP1,tP2,tP3,tPRI;
        begin
            E=tE; W=tW; P1_BUSY=tP1; P2_BUSY=tP2; P3_BUSY=tP3; PRI=tPRI;
            #10;
            free_count=(!tP1)+(!tP2)+(!tP3);
            exp_E=0; exp_W=0;

            if (free_count>0) begin
                if (tE && !tW) exp_E=1;
                else if (!tE && tW) exp_W=1;
                else if (tE && tW) begin
                    if (free_count>=2) begin exp_E=1; exp_W=1; end
                    else if (tPRI==0) exp_E=1;
                    else exp_W=1;
                end
            end

            exp_EP=3'b000;
            if (exp_E) begin
                if (!tP1) exp_EP=3'b001;
                else if (!tP2) exp_EP=3'b010;
                else if (!tP3) exp_EP=3'b100;
            end

            exp_WP=3'b000;
            if (exp_W) begin
                if (!tP1 && !exp_EP[0]) exp_WP=3'b001;
                else if (!tP2 && !exp_EP[1]) exp_WP=3'b010;
                else if (!tP3 && !exp_EP[2]) exp_WP=3'b100;
            end

            if ((E_GREEN !== exp_E) || (W_GREEN !== exp_W) ||
                ({EP3,EP2,EP1} !== exp_EP) || ({WP3,WP2,WP1} !== exp_WP) ||
                (E_RED !== ~exp_E) || (W_RED !== ~exp_W) ||
                (P1_FREE !== ~tP1) || (P2_FREE !== ~tP2) || (P3_FREE !== ~tP3) ||
                (P1_BUSY_LED !== tP1) || (P2_BUSY_LED !== tP2) || (P3_BUSY_LED !== tP3)) begin
                $display("FAIL E=%b W=%b BUSY=%b%b%b PRI=%b | EXP EG/WG=%b/%b EP=%b WP=%b | GOT EG/WG=%b/%b EP=%b WP=%b",
                    tE,tW,tP1,tP2,tP3,tPRI,exp_E,exp_W,exp_EP,exp_WP,E_GREEN,W_GREEN,{EP3,EP2,EP1},{WP3,WP2,WP1});
                errors=errors+1;
            end else begin
                $display("PASS E=%b W=%b BUSY=%b%b%b PRI=%b | EG/WG=%b/%b EP=%b WP=%b",
                    tE,tW,tP1,tP2,tP3,tPRI,E_GREEN,W_GREEN,{EP3,EP2,EP1},{WP3,WP2,WP1});
            end
        end
    endtask

    initial begin
        errors=0;
        for (i=0;i<64;i=i+1)
            check_case(i[5],i[4],i[3],i[2],i[1],i[0]);
        $display("==============================================");
        if (errors==0) $display("ALL 64 TEST CASES PASSED.");
        else $display("%0d TEST CASE(S) FAILED.",errors);
        $display("==============================================");
        $finish;
    end
endmodule

