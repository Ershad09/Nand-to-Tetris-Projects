

/*
            a	  b	   | out
            
            0	  0	   | 1
            0	  1	   | 1
            1	  0	   | 1
            1	  1	   | 0
*/



module nand_gate (
    input  wire a,
    input  wire b,
    output wire out
);

    nand (out, a, b);

endmodule
