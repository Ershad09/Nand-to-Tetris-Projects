module Mux4Way16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] c,
    input wire [15:0] d,
    input wire [1:0] sel,
    output wire [15:0] out
);

    wire [15:0] result_from_a_or_b;
    wire [15:0] result_from_c_or_d;

    Mux16 choose_a_or_b (
        .a(a),
        .b(b),
        .sel(sel[0]),
        .out(result_from_a_or_b)
    );

    Mux16 choose_c_or_d (
        .a(c),
        .b(d),
        .sel(sel[0]),
        .out(result_from_c_or_d)
    );

    Mux16 choose_between_the_two_pairs (
        .a(result_from_a_or_b),
        .b(result_from_c_or_d),
        .sel(sel[1]),
        .out(out)
    );

endmodule