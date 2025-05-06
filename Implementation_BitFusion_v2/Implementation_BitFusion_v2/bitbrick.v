`timescale 1ns / 1ps

// Performs a signed multiplication between two 2-bit inputs.
// - Sign-extends each input to 3 bits if sign_x or sign_y is asserted.
// - Computes signed 6-bit product directly within the module.

module bitbrick(
    input clk,              // Clock signal
    input reset,            // Reset signal
    input [1:0] x,          // 2-bit input operand x
    input [1:0] y,          // 2-bit input operand y
    input sign_x,           // Sign control for x
    input sign_y,           // Sign control for y
    output reg [5:0] p      // 6-bit signed product output
);

    wire signed [2:0] in_x; // Sign-extended version of x
    wire signed [2:0] in_y; // Sign-extended version of y

    // Extend x and y to 3-bit signed values
    assign in_x = {sign_x & x[1], x};   // Sign-extend if sign_x is high and MSB of x is 1
    assign in_y = {sign_y & y[1], y};   // Sign-extend if sign_y is high and MSB of y is 1

    // Check if either x or y is zero and assign p with 0 if true
    always @(*) begin
        if (x == 2'b00 || y == 2'b00) begin
            p = 6'b000000; // Assign 0 to p if either x or y is zero
        end else begin
            p = in_x * in_y; // Perform signed multiplication
        end
    end

endmodule
