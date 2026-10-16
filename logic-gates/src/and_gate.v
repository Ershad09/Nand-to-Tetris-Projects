
/*   

                AND GATE

            a   |   b   |   AND(a,b)
            
            0       0           0
            0       1           0
            1       0           0
            1       1           1
    
*/



module and_gate (
    input wire a,
    input wire b, 
    output wire out

);

    wire ab;

nand_gate g1 (
    .a(a),         
    .b(b),
    .out(ab)
);

nand_gate g2 (
    .a(ab),
    .b(ab),
    .out(out)
);

endmodule