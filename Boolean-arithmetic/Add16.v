module add16 (
    input wire [15:0] a,
    input wire [15:0] b,

    output wire [15:0] sum
);

    wire [16:0] carry;

    assign carry[0] = 1'b0;

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin : bit_stages

            full_adder f (
                .a(a[i]),
                .b(b[i]),
                .carry_in(carry[i]),
                .sum(sum[i]),
                .carry_out(carry[i + 1])
            );

        end
    endgenerate

endmodule