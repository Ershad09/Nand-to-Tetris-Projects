module tb_arithmetic;

    // half Adder inputs and outputs
    reg a, b;

    wire half_sum;
    wire half_carry;

    // full Adder
    reg carry_in;

    wire full_sum;
    wire full_carry;

    // 16-bit circuits
    reg [15:0] x, y;

    wire [15:0] sum16;
    wire [15:0] incremented;

    // ALU controls
    reg zx, nx, zy, ny, f, no;

    wire [15:0] alu_out;
    wire zr, ng;


    //  circuit instances

    half_adder ha (
        .a(a),
        .b(b),
        .sum(half_sum),
        .carry(half_carry)
    );

    full_adder fa (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(full_sum),
        .carry_out(full_carry)
    );

    add16 adder (
        .a(x),
        .b(y),
        .sum(sum16)
    );

    inc16 incrementer (
        .in(x),
        .out(incremented)
    );

    hack_alu alu (
        .x(x),
        .y(y),

        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),

        .out(alu_out),
        .zr(zr),
        .ng(ng)
    );


    //  testing
    initial begin

        $display("Starting arithmetic tests...");

        // set up the 16-bit inputs
        x = 16'd5;
        y = 16'd3;

        //  Half Adder
        a = 1'b1;
        b = 1'b1;
        carry_in = 1'b0;

        #1;

        if (half_sum !== 1'b0 ||
            half_carry !== 1'b1)
            $fatal(1, "Half Adder FAILED");


        //  Full Adder
        a = 1'b1;
        b = 1'b1;
        carry_in = 1'b1;

        #1;

        if (full_sum !== 1'b1 ||
            full_carry !== 1'b1)
            $fatal(1, "Full Adder FAILED");


        //  Add16 (5 + 3 = 8)

        #1;

        if (sum16 !== 16'd8)
            $fatal(1, "Add16 FAILED");


        //  Inc16 (5 + 1 = 6)

        if (incremented !== 16'd6)
            $fatal(1, "Inc16 FAILED");


        //  ALU addition (5 + 3 = 8)

        zx = 0;
        nx = 0;
        zy = 0;
        ny = 0;
        f  = 1;
        no = 0;

        #1;

        if (alu_out !== 16'd8 ||
            zr !== 1'b0 ||
            ng !== 1'b0)
            $fatal(1, "ALU ADD FAILED");


        //  ALU subtraction (5 - 3 = 2)

        zx = 0;
        nx = 1;
        zy = 0;
        ny = 0;
        f  = 1;
        no = 1;

        #1;

        if (alu_out !== 16'd2)
            $fatal(1, "ALU SUBTRACTION FAILED");


        //  ALU AND (5 AND 3 = 1)

        zx = 0;
        nx = 0;
        zy = 0;
        ny = 0;
        f  = 0;
        no = 0;

        #1;

        if (alu_out !== 16'd1)
            $fatal(1, "ALU AND FAILED");


        //  ALU OR (5 OR 3 = 7)

        zx = 0;
        nx = 1;
        zy = 0;
        ny = 1;
        f  = 0;
        no = 1;

        #1;

        if (alu_out !== 16'd7)
            $fatal(1, "ALU OR FAILED");


        //  ALU zero output

        zx = 1;
        nx = 0;
        zy = 1;
        ny = 0;
        f  = 1;
        no = 0;

        #1;

        if (alu_out !== 16'd0 ||
            zr !== 1'b1 ||
            ng !== 1'b0)
            $fatal(1, "ALU ZERO FLAG FAILED");


        //  ALU negative output (-1)

        zx = 1;
        nx = 1;
        zy = 1;
        ny = 0;
        f  = 1;
        no = 0;

        #1;

        if (alu_out !== 16'hFFFF ||
            ng !== 1'b1)
            $fatal(1, "ALU NEGATIVE FLAG FAILED");


        $display("ALL ARITHMETIC TESTS PASSED!");

        $finish;

    end

endmodule