module Mux8Way16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] c,
    input wire [15:0] d,
    input wire [15:0] e,
    input wire [15:0] f,
    input wire [15:0] g,
    input wire [15:0] h,
    input wire [2:0] sel,
    output wire [15:0] out
);

    wire [15:0] result_from_first_four;
    wire [15:0] result_from_last_four;

    Mux4Way16 choose_from_a_to_d (
        .a(a), .b(b), .c(c), .d(d),
        .sel(sel[1:0]),
        .out(result_from_first_four)
    );

    Mux4Way16 choose_from_e_to_h (
        .a(e), .b(f), .c(g), .d(h),
        .sel(sel[1:0]),
        .out(result_from_last_four)
    );

    Mux16 choose_between_the_two_groups (
        .a(result_from_first_four),
        .b(result_from_last_four),
        .sel(sel[2]),
        .out(out)
    );

endmodule