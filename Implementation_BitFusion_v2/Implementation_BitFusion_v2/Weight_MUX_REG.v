`timescale 1ns / 1ps

// Module: Weight_MUX_REG
// Description:
//   Adjusts a 32-bit input buffer based on the input bitwidth configuration.
//   Expands lower-precision weight data to a fixed 32-bit format for processing.
//   Operates as a simple FSM controlled by 'state' to support sequential access
//   when multiple low-bitwidth values are packed in the input.

module Weight_MUX_REG(
    input clk,
    input reset,
    input [1:0] input_bitwidth,    // 2'b00 = 8-bit, 2'b01 = 4-bit, 2'b10 = 2-bit
    input [31:0] buffer,           // Original packed weight buffer
    output reg [31:0] sorted_data  // Unpacked and replicated weight data
);

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            sorted_data <= 32'b0;
            state <= 2'b00;
        end else begin
            case (input_bitwidth)
                2'b00: begin
                    // 8-bit direct pass-through
                    sorted_data <= buffer;
                end

                2'b01: begin
                    // 4-bit: Expand 8-bit pairs and replicate
                    case (state)
                        2'b00: begin
                            sorted_data <= {buffer[15:8], buffer[15:8], buffer[7:0], buffer[7:0]};
                            state <= 2'b01;
                        end
                        2'b01: begin
                            sorted_data <= {buffer[31:24], buffer[31:24], buffer[23:16], buffer[23:16]};
                            state <= 2'b00;
                        end
                        default: state <= 2'b00;
                    endcase
                end

                default: begin
                    // 2-bit: Expand and replicate four 8-bit segments in four cycles
                    case (state)
                        2'b00: begin
                            sorted_data <= {buffer[7:0], buffer[7:0], buffer[7:0], buffer[7:0]};
                            state <= 2'b01;
                        end
                        2'b01: begin
                            sorted_data <= {buffer[15:8], buffer[15:8], buffer[15:8], buffer[15:8]};
                            state <= 2'b10;
                        end
                        2'b10: begin
                            sorted_data <= {buffer[23:16], buffer[23:16], buffer[23:16], buffer[23:16]};
                            state <= 2'b11;
                        end
                        default: begin
                            sorted_data <= {buffer[31:24], buffer[31:24], buffer[31:24], buffer[31:24]};
                            state <= 2'b00;
                        end
                    endcase
                end
            endcase
        end
    end

endmodule
