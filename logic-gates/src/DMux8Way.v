module DMux8Way(
    input wire in,
    input wire [2:0] sel,
    output wire a,
    output wire b,
    output wire c,
    output wire d,
    output wire e,
    output wire f,
    output wire g,
    output wire h
);

    wire input_for_a_to_d;
    wire input_for_e_to_h;

    wire input_for_a_b;
    wire input_for_c_d;
    wire input_for_e_f;
    wire input_for_g_h;

    dmux split_into_two_halves (
        .in(in),
        .sel(sel[2]),
        .a(input_for_a_to_d),
        .b(input_for_e_to_h)
    );

    dmux split_first_half (
        .in(input_for_a_to_d),
        .sel(sel[1]),
        .a(input_for_a_b),
        .b(input_for_c_d)
    );

    dmux split_second_half (
        .in(input_for_e_to_h),
        .sel(sel[1]),
        .a(input_for_e_f),
        .b(input_for_g_h)
    );

    dmux choose_a_or_b (
        .in(input_for_a_b),
        .sel(sel[0]),
        .a(a),
        .b(b)
    );

    dmux choose_c_or_d (
        .in(input_for_c_d),
        .sel(sel[0]),
        .a(c),
        .b(d)
    );

    dmux choose_e_or_f (
        .in(input_for_e_f),
        .sel(sel[0]),
        .a(e),
        .b(f)
    );

    dmux choose_g_or_h (
        .in(input_for_g_h),
        .sel(sel[0]),
        .a(g),
        .b(h)
    );

endmodule