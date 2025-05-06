`timescale 1ns / 1ps

// [BitFusion Column Module]
// Implements a vertical column of 16 Processing Elements (PEs), each computing
// a partial sum using input activations and weights, accumulated sequentially.
// Weights are fetched through buffer and bitwidth-aligned MUX logic.
// The final result is passed to an accumulator.

module BitFusion_column(
    input clk,
    input reset,

    // Inputs from external activation buffer
    input [31:0] sorted_input_1, sorted_input_2, sorted_input_3, sorted_input_4,
                 sorted_input_5, sorted_input_6, sorted_input_7, sorted_input_8,
                 sorted_input_9, sorted_input_10, sorted_input_11, sorted_input_12,
                 sorted_input_13, sorted_input_14, sorted_input_15, sorted_input_16,

    // Weight data input lines
    input [31:0] WBUF_data_in_1, WBUF_data_in_2, WBUF_data_in_3, WBUF_data_in_4,
                 WBUF_data_in_5, WBUF_data_in_6, WBUF_data_in_7, WBUF_data_in_8,
                 WBUF_data_in_9, WBUF_data_in_10, WBUF_data_in_11, WBUF_data_in_12,
                 WBUF_data_in_13, WBUF_data_in_14, WBUF_data_in_15, WBUF_data_in_16,

    // Global control signals
    input [3:0] sign_x,
    input [3:0] sign_y,
    input [1:0] input_bitwidth,
    input [47:0] signal,

    // Accumulated output
    output [27:0] total_output
);

    // Internal wires for PE computation and register stages
    wire [19:0] PE_sum_1, PE_sum_2, PE_sum_3, PE_sum_4, PE_sum_5, PE_sum_6, PE_sum_7, PE_sum_8;
    wire [19:0] PE_sum_9, PE_sum_10, PE_sum_11, PE_sum_12, PE_sum_13, PE_sum_14, PE_sum_15, PE_sum_16;

    wire [19:0] PE_sum_out_1, PE_sum_out_2, PE_sum_out_3, PE_sum_out_4, PE_sum_out_5, PE_sum_out_6, PE_sum_out_7, PE_sum_out_8;
    wire [19:0] PE_sum_out_9, PE_sum_out_10, PE_sum_out_11, PE_sum_out_12, PE_sum_out_13, PE_sum_out_14, PE_sum_out_15, PE_sum_out_16;

    wire [31:0] WBUF_data_out_1, WBUF_data_out_2, WBUF_data_out_3, WBUF_data_out_4, WBUF_data_out_5, WBUF_data_out_6, WBUF_data_out_7, WBUF_data_out_8;
    wire [31:0] WBUF_data_out_9, WBUF_data_out_10, WBUF_data_out_11, WBUF_data_out_12, WBUF_data_out_13, WBUF_data_out_14, WBUF_data_out_15, WBUF_data_out_16;

    wire [31:0] sorted_weight_1, sorted_weight_2, sorted_weight_3, sorted_weight_4, sorted_weight_5, sorted_weight_6, sorted_weight_7, sorted_weight_8;
    wire [31:0] sorted_weight_9, sorted_weight_10, sorted_weight_11, sorted_weight_12, sorted_weight_13, sorted_weight_14, sorted_weight_15, sorted_weight_16;

    // Macro to reduce repetition in PE instantiation
    `define PE_COLUMN_BLOCK(ID) \
        BUF_32bit WBUF_``ID (.clk(clk), .reset(reset), .data_in(WBUF_data_in_``ID), .data_out(WBUF_data_out_``ID)); \
        Weight_MUX_REG MUX_REG_``ID (.clk(clk), .reset(reset), .buffer(WBUF_data_out_``ID), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_``ID)); \
        PE PE_``ID (.clk(clk), .reset(reset), .x(sorted_input_``ID), .y(sorted_weight_``ID), .sign_x(sign_x), .sign_y(sign_y), \
                   .signal(signal), .previous_sum(PE_sum_out_``ID_MINUS_1), .PE_sum(PE_sum_``ID)); \
        PE_register PE_reg_``ID (.clk(clk), .reset(reset), .PE_sum(PE_sum_``ID), .PE_sum_out(PE_sum_out_``ID));

    // Expansion workaround for macro recursion (explicitly connect .previous_sum)
    BUF_32bit WBUF_1 (.clk(clk), .reset(reset), .data_in(WBUF_data_in_1), .data_out(WBUF_data_out_1));
    Weight_MUX_REG MUX_REG_1 (.clk(clk), .reset(reset), .buffer(WBUF_data_out_1), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_1));
    PE PE_1 (.clk(clk), .reset(reset), .x(sorted_input_1), .y(sorted_weight_1), .sign_x(sign_x), .sign_y(sign_y), .signal(signal),
             .previous_sum(20'b0), .PE_sum(PE_sum_1));
    PE_register PE_reg_1 (.clk(clk), .reset(reset), .PE_sum(PE_sum_1), .PE_sum_out(PE_sum_out_1));

    // Remaining PEs
    `define ID_MINUS_1 1
    `PE_COLUMN_BLOCK(2)
    `undef ID_MINUS_1
    `define ID_MINUS_1 2
    `PE_COLUMN_BLOCK(3)
    `undef ID_MINUS_1
    `define ID_MINUS_1 3
    `PE_COLUMN_BLOCK(4)
    `undef ID_MINUS_1
    `define ID_MINUS_1 4
    `PE_COLUMN_BLOCK(5)
    `undef ID_MINUS_1
    `define ID_MINUS_1 5
    `PE_COLUMN_BLOCK(6)
    `undef ID_MINUS_1
    `define ID_MINUS_1 6
    `PE_COLUMN_BLOCK(7)
    `undef ID_MINUS_1
    `define ID_MINUS_1 7
    `PE_COLUMN_BLOCK(8)
    `undef ID_MINUS_1
    `define ID_MINUS_1 8
    `PE_COLUMN_BLOCK(9)
    `undef ID_MINUS_1
    `define ID_MINUS_1 9
    `PE_COLUMN_BLOCK(10)
    `undef ID_MINUS_1
    `define ID_MINUS_1 10
    `PE_COLUMN_BLOCK(11)
    `undef ID_MINUS_1
    `define ID_MINUS_1 11
    `PE_COLUMN_BLOCK(12)
    `undef ID_MINUS_1
    `define ID_MINUS_1 12
    `PE_COLUMN_BLOCK(13)
    `undef ID_MINUS_1
    `define ID_MINUS_1 13
    `PE_COLUMN_BLOCK(14)
    `undef ID_MINUS_1
    `define ID_MINUS_1 14
    `PE_COLUMN_BLOCK(15)
    `undef ID_MINUS_1
    `define ID_MINUS_1 15
    `PE_COLUMN_BLOCK(16)
    `undef ID_MINUS_1

    // Final accumulation stage
    ACC accumulator(
        .clk(clk),
        .reset(reset),
        .PE_sum(PE_sum_out_16),
        .total_output(total_output)
    );

endmodule
