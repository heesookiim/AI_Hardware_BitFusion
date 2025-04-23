`timescale 1ns / 1ps

// PE: Processing Element Module
// Composed of 16 BitBricks and corresponding shifters
// Performs multiply-shift operations followed by an adder tree to generate accumulated output

module PE(
    input  clk,
    input  reset,
    input  [31:0] x,
    input  [31:0] y,
    input  [3:0]  sign_x,
    input  [3:0]  sign_y,
    input  [47:0] signal,
    input  [19:0] previous_sum,
    output [19:0] PE_sum
);

    // Raw bitbrick products
    wire [5:0] p       [0:15];

    // Shifted products array
    wire [15:0] p_shift[0:15];

    // Instantiate 16 BitBricks + shifters
    genvar i;
    generate
      for (i = 0; i < 16; i = i + 1) begin : gen_PE_bricks
        // 2-bit lanes of x and y
        bitbrick BB (
          .clk(clk),
          .reset(reset),
          .x(x[2*i+1:2*i]),
          .y(y[2*i+1:2*i]),
          .sign_x(sign_x[i/4]),
          .sign_y(sign_y[i%4]),
          .p(p[i])
        );

        // 3-bit slice of 'signal'
        bitbrick_shift BBS (
          .p(p[i]),
          .signal(signal[3*i +: 3]),
          .product(p_shift[i])
        );
      end
    endgenerate

    // Connect the array into the adder tree
    PE_adder ADDER_TREE (
      .p_shift_0 (p_shift[0]),
      .p_shift_1 (p_shift[1]),
      .p_shift_2 (p_shift[2]),
      .p_shift_3 (p_shift[3]),
      .p_shift_4 (p_shift[4]),
      .p_shift_5 (p_shift[5]),
      .p_shift_6 (p_shift[6]),
      .p_shift_7 (p_shift[7]),
      .p_shift_8 (p_shift[8]),
      .p_shift_9 (p_shift[9]),
      .p_shift_10(p_shift[10]),
      .p_shift_11(p_shift[11]),
      .p_shift_12(p_shift[12]),
      .p_shift_13(p_shift[13]),
      .p_shift_14(p_shift[14]),
      .p_shift_15(p_shift[15]),
      .previous_sum(previous_sum),
      .PE_sum(PE_sum)
    );

endmodule
