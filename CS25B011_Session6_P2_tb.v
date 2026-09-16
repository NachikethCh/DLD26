module P2_gate_tb;

    reg A, B, C, D;
    wire Z;
    P2_gate uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .Z(Z)
    );
    initial begin
        $monitor("A=%b B=%b C=%b D=%b | Z=%b",
                  A, B, C, D, Z);
        A=0;B=0;C=0;D=0;
        #10;
        A=0;B=0;C=0;D=1;
        #10;
        A=0;B=0;C=1;D=0;
        #10;
        A=0;B=1;C=1;D=1;
        #10;
        A=1;B=1;C=1;D=0;
        #10;
        A=1;B=1;C=1;D=1;
        #10;
        A=0;B=1;C=0; D=0;
        #10;
        A=1;B=0;C=1;D=0;
        #10;
        A=0;B=1;C=0;D=1;
        #10;
        A=1;B=0;C=0;D=0;
        #10;
        $finish;
    end
endmodule
