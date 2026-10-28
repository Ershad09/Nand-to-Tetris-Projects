
/*
    
            Multiplexer

    a       b       sel     |   out

    0       0       0       |    0
    0       1       0       |    0 
    1       0       0       |    0
    1       1       0       |    1
    0       0       1       |    0
    0       1       1       |    1
    1       0       1       |    0
    1       1       1       |    1      

*/



module mux (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);

    wire sel_inverse;
    wire nand_a_result;
    wire nand_b_result;

    nand_gate make_sel_opposite (
        .a(sel),
        .b(sel),
        .out(sel_inverse)
    );


    nand_gate input_a (
        .a(a),
        .b(sel_inverse),
        .out(nand_a_result)

    );

    nand_gate input_b (
        .a(b),
        .b(sel),
        .out(nand_b_result)
    );

    nand_gate result (
        .a(nand_a_result),
        .b(nand_b_result),
        .out(out)
    );

endmodule