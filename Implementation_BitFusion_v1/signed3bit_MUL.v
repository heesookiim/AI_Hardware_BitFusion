`timescale 1ns / 1ps

// Multiplier for two signed 3-bit inputs
// Outputs a signed 6-bit product

module signed_3bit_MUL(
    input  signed [2:0] in_x,
    input  signed [2:0] in_y,
    output signed [5:0] p
);

    // Perform signed multiplication
    assign p = in_x * in_y;

endmodule
