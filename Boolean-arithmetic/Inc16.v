module inc16 (
    input wire [15:0] in,

    output wire [15:0] out
);

    add16 incrementer (
        .a(in),
        .b(16'b0000000000000001),
        .sum(out)
    );

endmodule