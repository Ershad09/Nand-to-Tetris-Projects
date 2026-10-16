

/*   

                OR GATE

            a   |   b   |   OR(a,b)
            
            0       0           0
            0       1           1
            1       0           1
            1       1           1
    
*/


module or_gate (
    input wire a, 
    input wire b, 
    output wire out
);


wire first; 
wire second; 

nand_gate g1(
    .a(a), 
    .b(a),
    .out(first) 
);

nand_gate g2(
    .a(b),
    .b(b),
    .out(second) 
);

// -----------------------


nand_gate g3(
    .a(first),
    .b(second),
    .out(out)   
);

endmodule

