module DMux4Way(
    input wire in,
    input wire [1:0] sel,
    output wire a,
    output wire b,
    output wire c,
    output wire d
);

    wire input_for_first_pair;
    wire input_for_second_pair;

    dmux split_into_two_groups (
        .in(in),
        .sel(sel[1]),
        .a(input_for_first_pair),
        .b(input_for_second_pair)
    );

    dmux choose_a_or_b (
        .in(input_for_first_pair),
        .sel(sel[0]),
        .a(a),
        .b(b)
    );

    dmux choose_c_or_d (
        .in(input_for_second_pair),
        .sel(sel[0]),
        .a(c),
        .b(d)
    );

endmodule