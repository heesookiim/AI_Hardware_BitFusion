`timescale 1ns / 1ps

// PE_register Module
// Acts as a single-stage register for accumulating PE outputs
// Stores PE_sum into PE_sum_out on every positive clock edge

module PE_register(
    input clk,
    input reset,
    
    input [19:0] PE_sum,
    output reg [19:0] PE_sum_out
);

    // On reset, clear the output register
    // Otherwise, latch input to output at each rising edge
    always @(posedge clk) begin
        if (reset)
            PE_sum_out <= 20'd0;
        else
            PE_sum_out <= PE_sum;
    end

endmodule
