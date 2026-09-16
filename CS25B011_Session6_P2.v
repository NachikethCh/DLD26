module P2_gate(
    input A,
    input B,
    input C,
    input D,
    output Z
);
    wire nA;
    wire nB;
    wire nC;
    wire nD;
    wire t1;
    wire t2;
    wire t3;
    wire t4;
    not (nA,A);
    not (nB,B);
    not (nC,C);
    not (nD,D);
    and (t1,nA,nB,nC);
    and (t2,nB,nC,nD);
    and (t3,A,B,C);
    and (t4,B,C,D);
    or (Z,t1,t2,t3,t4);
endmodule
