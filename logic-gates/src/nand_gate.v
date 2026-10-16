
module nand_gate (
    
    input wire a,
    input wire b,
    output wire out
);

    nand (out, a, b);

endmodule

