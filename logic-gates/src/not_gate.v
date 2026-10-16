
/*   

                NOT GATE

            a   |   NOT(a)
            
            0        1
            1        0
    
*/




module not_gate (
    input wire in,     
    output wire out
    
);

    nand_gate g1 (
        .a(in),         
        .b(in),         
        .out(out)      
    );

endmodule