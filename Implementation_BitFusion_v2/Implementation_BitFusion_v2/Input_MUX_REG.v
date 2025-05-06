`timescale 1ns / 1ps

// This module processes 32-bit input buffer data based on the weight bitwidth.
// It unpacks and aligns the bits into a consistent 32-bit output format depending
// on the bitwidth scenario (2, 4, or 8-bit).

module Input_MUX_REG(
    input clk,
    input reset,
    input [1:0] weight_bitwidth,
    input [31:0] buffer,
    output reg [31:0] sorted_data
);

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            sorted_data <= 32'b0;
            state <= 2'b00;
        end
        else begin
            case (weight_bitwidth)
                2'b00: begin
                    // 8-bit mode: direct pass-through
                    sorted_data <= buffer;
                end
                2'b01: begin
                    // 4-bit mode: split input across cycles
                    case (state)
                        2'b00: sorted_data <= { {2{buffer[15:14]}}, {2{buffer[11:10]}}, {2{buffer[13:12]}}, {2{buffer[9:8]}}, {2{buffer[7:6]}}, {2{buffer[3:2]}}, {2{buffer[5:4]}}, {2{buffer[1:0]}} };
                        2'b01: sorted_data <= { {2{buffer[31:30]}}, {2{buffer[27:26]}}, {2{buffer[29:28]}}, {2{buffer[25:24]}}, {2{buffer[23:22]}}, {2{buffer[19:18]}}, {2{buffer[21:20]}}, {2{buffer[17:16]}} };
                        default: sorted_data <= 32'b0;
                    endcase
                    state <= (state == 2'b01) ? 2'b00 : state + 1;
                end
                2'b10: begin
                    // 2-bit mode: split across 4 cycles
                    case (state)
                        2'b00: sorted_data <= { {4{buffer[7:6]}}, {4{buffer[5:4]}}, {4{buffer[3:2]}}, {4{buffer[1:0]}} };
                        2'b01: sorted_data <= { {4{buffer[15:14]}}, {4{buffer[13:12]}}, {4{buffer[11:10]}}, {4{buffer[9:8]}} };
                        2'b10: sorted_data <= { {4{buffer[23:22]}}, {4{buffer[21:20]}}, {4{buffer[19:18]}}, {4{buffer[17:16]}} };
                        2'b11: sorted_data <= { {4{buffer[31:30]}}, {4{buffer[29:28]}}, {4{buffer[27:26]}}, {4{buffer[25:24]}} };
                    endcase
                    state <= state + 1;
                end
                default: begin
                    sorted_data <= 32'b0;
                end
            endcase
        end
    end

endmodule