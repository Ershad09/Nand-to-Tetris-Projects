module Or8Way(
    input wire [7:0] in,
    output wire out
);

    wire or_of_bits_0_and_1;
    wire or_of_bits_2_and_3;
    wire or_of_bits_4_and_5;
    wire or_of_bits_6_and_7;

    wire or_of_first_four_bits;
    wire or_of_last_four_bits;

    or_gate combine_bits_0_and_1 (
        .a(in[0]), .b(in[1]),
        .out(or_of_bits_0_and_1)
    );

    or_gate combine_bits_2_and_3 (
        .a(in[2]), .b(in[3]),
        .out(or_of_bits_2_and_3)
    );

    or_gate combine_bits_4_and_5 (
        .a(in[4]), .b(in[5]),
        .out(or_of_bits_4_and_5)
    );

    or_gate combine_bits_6_and_7 (
        .a(in[6]), .b(in[7]),
        .out(or_of_bits_6_and_7)
    );

    or_gate combine_first_four_bits (
        .a(or_of_bits_0_and_1),
        .b(or_of_bits_2_and_3),
        .out(or_of_first_four_bits)
    );

    or_gate combine_last_four_bits (
        .a(or_of_bits_4_and_5),
        .b(or_of_bits_6_and_7),
        .out(or_of_last_four_bits)
    );

    or_gate combine_both_groups (
        .a(or_of_first_four_bits),
        .b(or_of_last_four_bits),
        .out(out)
    );

endmodule