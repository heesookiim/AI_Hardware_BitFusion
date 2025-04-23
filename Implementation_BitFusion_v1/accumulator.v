`timescale 1ns / 1ps

// [Fusion Unit - Accumulator Module]
// Combines partial sums from a 4x4 processing element array.
// Performs sign extension and cumulative addition.
// Output: 6-bit aligned total output (28-bit for overflow protection).

module ACC(
    input clk,                   // Clock signal
    input reset,                 // Active-high reset
    input [19:0] PE_sum,         // 20-bit input sum from PEs
    
    output reg [27:0] total_output  // 28-bit accumulated result
    );

    // On every rising edge of the clock:
    // If reset is high, clear the output.
    // Otherwise, sign-extend PE_sum to 28 bits and add to the running total.
    always @ (posedge clk) begin
        if (reset)
            total_output <= 28'd0;
        else
            total_output <= { {8{PE_sum[19]}}, PE_sum } + total_output;
    end

endmodule
