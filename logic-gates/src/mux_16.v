module Mux16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire sel,
    output wire [15:0] out
);

    genvar bit_index;

    generate
        for (
            bit_index = 0;
            bit_index < 16;
            bit_index = bit_index + 1
        ) begin : each_bit

            mux choose_this_bit (
                .a(a[bit_index]),
                .b(b[bit_index]),
                .sel(sel),
                .out(out[bit_index])
            );

        end
    endgenerate

endmodule