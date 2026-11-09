
module hack_alu (

        input wire [15:0] x,
        input wire [15:0] y,

        input wire zx,
        input wire nx,
        input wire zy,
        input wire ny,
        input wire f,
        input wire no,

        output wire [15:0] out,

        output wire zr,
        output wire ng
);



    wire [15:0] x_zeroed;
    wire [15:0] x_ready;

    wire [15:0] y_zeroed;
    wire [15:0] y_ready;


    wire [15:0] and_result;
    wire [15:0] add_result;
    wire [15:0] selected_result;


    //  zero x if zx = 1
    assign x_zeroed = zx ? 16'b0 : x;

    //  invert x if nx = 1
    assign x_ready = nx ? ~x_zeroed : x_zeroed;


    //  zero Y if zy = 1
    assign y_zeroed = zy ? 16'b0 : y;

    //  invert Y if ny = 1
    assign y_ready = ny ? ~y_zeroed : y_zeroed;



     //   AND operation
    assign and_result = x_ready & y_ready;

    //  ADD operation
    add16 adder (
        .a(x_ready),
        .b(y_ready),
        .sum(add_result)
    );



    //  select AND or ADD
    assign selected_result = f ? add_result : and_result;

    //  invert final output if no = 1
    assign out = no ? ~selected_result : selected_result;




    //  calculate status flags

    assign zr = (out == 16'b0);

    assign ng = out[15];


endmodule