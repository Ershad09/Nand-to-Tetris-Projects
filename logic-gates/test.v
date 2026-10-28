
`timescale 1ns/1ps

module test;

  
 // 1. single-bit gates
   

    reg a, b, sel;

    wire nand_out;
    wire not_out;
    wire and_out;
    wire or_out;
    wire xor_out;
    wire mux_out;

    nand_gate gate_nand (
        .a(a), .b(b), .out(nand_out)
    );

    not_gate gate_not (
        .in(a), .out(not_out)
    );

    and_gate gate_and (
        .a(a), .b(b), .out(and_out)
    );

    or_gate gate_or (
        .a(a), .b(b), .out(or_out)
    );

    xor_gate gate_xor (
        .a(a), .b(b), .out(xor_out)
    );

    mux gate_mux (
        .a(a), .b(b), .sel(sel), .out(mux_out)
    );


    
//   2. single-bit demultiplexer
    

    reg dmux_in, dmux_sel;
    wire dmux_a, dmux_b;

    dmux gate_dmux (
        .in(dmux_in),
        .sel(dmux_sel),
        .a(dmux_a),
        .b(dmux_b)
    );


  
// 3. sixteen-bit gates and mux
  

    reg [15:0] a16, b16;
    reg [15:0] c16, d16;
    reg [15:0] e16, f16;
    reg [15:0] g16, h16;

    reg mux16_sel;

    wire [15:0] not16_out;
    wire [15:0] and16_out;
    wire [15:0] or16_out;
    wire [15:0] mux16_out;

    Not16 gate_not16 (
        .in(a16), .out(not16_out)
    );

    And16 gate_and16 (
        .a(a16), .b(b16), .out(and16_out)
    );

    Or16 gate_or16 (
        .a(a16), .b(b16), .out(or16_out)
    );

    Mux16 gate_mux16 (
        .a(a16),
        .b(b16),
        .sel(mux16_sel),
        .out(mux16_out)
    );



// 4. eight-input OR gate
  

    reg [7:0] in8;
    wire or8_out;

    Or8Way gate_or8way (
        .in(in8),
        .out(or8_out)
    );


  
    // 5. four-way and eight-way 16-bit muxes
   
    reg [1:0] sel4;
    reg [2:0] sel8;

    wire [15:0] mux4_out;
    wire [15:0] mux8_out;

    Mux4Way16 gate_mux4way (
        .a(a16),
        .b(b16),
        .c(c16),
        .d(d16),
        .sel(sel4),
        .out(mux4_out)
    );

    Mux8Way16 gate_mux8way (
        .a(a16),
        .b(b16),
        .c(c16),
        .d(d16),
        .e(e16),
        .f(f16),
        .g(g16),
        .h(h16),
        .sel(sel8),
        .out(mux8_out)
    );



    // 6. four-way demultiplexer


    reg dmux4_in;
    reg [1:0] dmux4_sel;

    wire dmux4_a, dmux4_b;
    wire dmux4_c, dmux4_d;

    DMux4Way gate_dmux4way (
        .in(dmux4_in),
        .sel(dmux4_sel),
        .a(dmux4_a),
        .b(dmux4_b),
        .c(dmux4_c),
        .d(dmux4_d)
    );



    // 7. eight-way demultiplexer


    reg dmux8_in;
    reg [2:0] dmux8_sel;

    wire dmux8_a, dmux8_b;
    wire dmux8_c, dmux8_d;
    wire dmux8_e, dmux8_f;
    wire dmux8_g, dmux8_h;

    DMux8Way gate_dmux8way (
        .in(dmux8_in),
        .sel(dmux8_sel),
        .a(dmux8_a),
        .b(dmux8_b),
        .c(dmux8_c),
        .d(dmux8_d),
        .e(dmux8_e),
        .f(dmux8_f),
        .g(dmux8_g),
        .h(dmux8_h)
    );



    // test counters
   

    integer tests;
    integer errors;
    integer i;

    reg [15:0] expected16;


    // task: check a single-bit result


    task check_bit;
        input expected;
        input actual;
        input [8*48-1:0] test_name;

        begin
            tests = tests + 1;

            if (actual !== expected) begin
                errors = errors + 1;

                $display(
                    "FAIL: %0s | expected=%b actual=%b",
                    test_name, expected, actual
                );
            end
        end
    endtask



    // task: check a 16-bit result


    task check16;
        input [15:0] expected;
        input [15:0] actual;
        input [8*48-1:0] test_name;

        begin
            tests = tests + 1;

            if (actual !== expected) begin
                errors = errors + 1;

                $display(
                    "FAIL: %0s | expected=%h actual=%h",
                    test_name, expected, actual
                );
            end
        end
    endtask



    // start all tests
  

    initial begin

        tests = 0;
        errors = 0;



        // Test 1: single-bit gates and mux
        // All 8 combinations of a, b and sel
    

        for (i = 0; i < 8; i = i + 1) begin

            sel = (i >> 2) & 1;
            a   = (i >> 1) & 1;
            b   = i & 1;

            #1;

            check_bit(
                ~(a & b), nand_out, "nand_gate"
            );

            check_bit(
                ~a, not_out, "not_gate"
            );

            check_bit(
                a & b, and_out, "and_gate"
            );

            check_bit(
                a | b, or_out, "or_gate"
            );

            check_bit(
                a ^ b, xor_out, "xor_gate"
            );

            check_bit(
                sel ? b : a, mux_out, "mux"
            );

        end


        // Test 2: single-bit demultiplexer
   

        for (i = 0; i < 4; i = i + 1) begin

            dmux_in  = (i >> 1) & 1;
            dmux_sel = i & 1;

            #1;

            check_bit(
                dmux_in & ~dmux_sel,
                dmux_a,
                "dmux output a"
            );

            check_bit(
                dmux_in & dmux_sel,
                dmux_b,
                "dmux output b"
            );

        end


 
        // Test 3: 16-bit gates and Mux16
       
        for (i = 0; i < 6; i = i + 1) begin

            case (i)
                0: begin
                    a16 = 16'h0000;
                    b16 = 16'hFFFF;
                end

                1: begin
                    a16 = 16'hFFFF;
                    b16 = 16'h0000;
                end

                2: begin
                    a16 = 16'hAAAA;
                    b16 = 16'h5555;
                end

                3: begin
                    a16 = 16'hFFFF;
                    b16 = 16'hFFFF;
                end

                4: begin
                    a16 = 16'h1234;
                    b16 = 16'h00FF;
                end

                5: begin
                    a16 = 16'h8001;
                    b16 = 16'h4002;
                end
            endcase

            #1;

            check16(
                ~a16, not16_out, "Not16"
            );

            check16(
                a16 & b16, and16_out, "And16"
            );

            check16(
                a16 | b16, or16_out, "Or16"
            );

            mux16_sel = 0;
            #1;

            check16(
                a16, mux16_out, "Mux16 sel=0"
            );

            mux16_sel = 1;
            #1;

            check16(
                b16, mux16_out, "Mux16 sel=1"
            );

        end


       
        // Test 4: Or8Way
        // Test all 256 possible 8-bit inputs
       

        for (i = 0; i < 256; i = i + 1) begin

            in8 = i;

            #1;

            check_bit(
                (i != 0), or8_out, "Or8Way"
            );

        end


        // Test 5: Mux4Way16 and Mux8Way16
        // give every input a different value
      

        a16 = 16'h0001;
        b16 = 16'h0002;
        c16 = 16'h0004;
        d16 = 16'h0008;
        e16 = 16'h0010;
        f16 = 16'h0020;
        g16 = 16'h0040;
        h16 = 16'h0080;


        // Test all 4 selections

        for (i = 0; i < 4; i = i + 1) begin

            sel4 = i;

            case (i)
                0: expected16 = a16;
                1: expected16 = b16;
                2: expected16 = c16;
                3: expected16 = d16;
            endcase

            #1;

            check16(
                expected16, mux4_out, "Mux4Way16"
            );

        end


        // Test all 8 selections

        for (i = 0; i < 8; i = i + 1) begin

            sel8 = i;

            case (i)
                0: expected16 = a16;
                1: expected16 = b16;
                2: expected16 = c16;
                3: expected16 = d16;
                4: expected16 = e16;
                5: expected16 = f16;
                6: expected16 = g16;
                7: expected16 = h16;
            endcase

            #1;

            check16(
                expected16, mux8_out, "Mux8Way16"
            );

        end


        // Test 6: DMux4Way
        // each selection should activate one output
    

        for (i = 0; i < 4; i = i + 1) begin

            dmux4_in  = 1;
            dmux4_sel = i;

            #1;

            check_bit((i == 0), dmux4_a, "DMux4Way a");
            check_bit((i == 1), dmux4_b, "DMux4Way b");
            check_bit((i == 2), dmux4_c, "DMux4Way c");
            check_bit((i == 3), dmux4_d, "DMux4Way d");

            // when input is zero, all outputs must be zero

            dmux4_in = 0;
            #1;

            check_bit(0, dmux4_a, "DMux4Way zero input a");
            check_bit(0, dmux4_b, "DMux4Way zero input b");
            check_bit(0, dmux4_c, "DMux4Way zero input c");
            check_bit(0, dmux4_d, "DMux4Way zero input d");

        end


       
        // Test 7: DMux8Way
      

        for (i = 0; i < 8; i = i + 1) begin

            dmux8_in  = 1;
            dmux8_sel = i;

            #1;

            check_bit((i == 0), dmux8_a, "DMux8Way a");
            check_bit((i == 1), dmux8_b, "DMux8Way b");
            check_bit((i == 2), dmux8_c, "DMux8Way c");
            check_bit((i == 3), dmux8_d, "DMux8Way d");
            check_bit((i == 4), dmux8_e, "DMux8Way e");
            check_bit((i == 5), dmux8_f, "DMux8Way f");
            check_bit((i == 6), dmux8_g, "DMux8Way g");
            check_bit((i == 7), dmux8_h, "DMux8Way h");

            // zero input will produce all-zero outputs

            dmux8_in = 0;
            #1;

            check_bit(0, dmux8_a, "DMux8Way zero input a");
            check_bit(0, dmux8_b, "DMux8Way zero input b");
            check_bit(0, dmux8_c, "DMux8Way zero input c");
            check_bit(0, dmux8_d, "DMux8Way zero input d");
            check_bit(0, dmux8_e, "DMux8Way zero input e");
            check_bit(0, dmux8_f, "DMux8Way zero input f");
            check_bit(0, dmux8_g, "DMux8Way zero input g");
            check_bit(0, dmux8_h, "DMux8Way zero input h");

        end


//  ----------------------------

        $display("Tests run: %0d", tests);
        $display("Failures : %0d", errors);
       

        if (errors == 0) begin
            $display("ALL TESTS PASSED!");
        end
        else begin
            $fatal(1, "Some tests failed");
        end

        $finish;

    end

endmodule
