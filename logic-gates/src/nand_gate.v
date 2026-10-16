
/*   

                NAND GATE

            a   |   b   |   NAND(a,b)
            
            0       0           1
            0       1           1
            1       0           1
            1       1           0
    
*/





module nand_gate (          

    input wire a,    
    input wire b,  
    output wire out 
             
);       
    nand (a, b, out);  

    
endmodule

