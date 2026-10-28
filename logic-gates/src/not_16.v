
module Not16 (
    input wire [15:0] in,
    output wire [15:0] out
);

    genvar bit_index;

    generate
        for (
            bit_index = 0; 
            bit_index < 16;
            bit_index = bit_index + 1 
            
            ) begin : each_bit 

                not_gate flip_this_bit (
                    .in(in[bit_index]),
                    .out(out[bit_index])
                );
            
        end
    endgenerate

    endmodule