`timescale 1ns / 1ps

// [Bitbrick Shift Module]
// This module applies a variable left shift to a signed 6-bit input 'p'.
// The shift amount is controlled by a 3-bit 'signal' input (multiplied by 2).
// The result is a 16-bit value that includes sign extension to preserve signed arithmetic.

module bitbrick_shift(
    input [5:0] p,          // Signed 6-bit input value
    input [2:0] signal,     // 3-bit shift control input
    output [15:0] product   // 16-bit shifted output
);

    // Explanation:
    // - The input 'p' is first sign-extended to 16 bits by replicating the sign bit (p[5]) 10 times.
    // - The extended value is then left-shifted by (signal * 2) bits.
    // - The shift effectively multiplies the input by powers of 4, preserving sign.

    assign product = { {10{p[5]}}, p } << (signal * 2);

endmodule
