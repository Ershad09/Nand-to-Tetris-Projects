module full_adder (
    input wire a,
    input wire b,
    input wire carry_in,

    output wire sum,
    output wire carry_out
);

    wire partial_sum;
    wire carry_1, carry_2;

    half_adder h1 (
        .a(a),
        .b(b),
        .sum(partial_sum),
        .carry(carry_1)
    );

    half_adder h2 (
        .a(partial_sum),
        .b(carry_in),
        .sum(sum),
        .carry(carry_2)
    );

    assign carry_out = carry_1 | carry_2;

endmodule