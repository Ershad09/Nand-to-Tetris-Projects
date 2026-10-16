

/*   

                XOR GATE

            a   |   b   |   XOR(a,b)
            
            0       0           0
            0       1           1
            1       0           1
            1       1           0
    
*/


module xor_gate (
    input wire a,
    input wire b,
    output wire out
);

    wire x;
    wire y;
    wire z;

    nand_gate g1 (
        .a(a),
        .b(b),
        .out(x)

    );

//  --------

    nand_gate g2 (
        .a(a),
        .b(x),
        .out(y)
    );

    nand_gate g3 (
        .a(b),
        .b(x),
        .out(z)
    );

//  ----

    nand_gate g4 (
        .a(y)
        .b(z)
        .out(out)
    );

endmodule