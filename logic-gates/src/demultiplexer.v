

module dmux (
    input wire in,
    input wire sel,
    output wire a,
    output wire b,
);

  wire not_sel;


    not_gate inv_sel (
        .in(sel),
        .out(not_sel)
    );

      and_gate route_a (
        .a(in),
        .b(not_sel),
        .out(a)
    );

    and_gate route_b (
        .a(in),
        .b(sel),
        .out(b)
    );


endmodule