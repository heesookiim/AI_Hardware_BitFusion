`timescale 1ns/1ps

module tb_BitFusion;

  // Clock & reset
  reg clk;
  reg reset;

  reg [31:0] IBUF_data_in_1, IBUF_data_in_2, IBUF_data_in_3, IBUF_data_in_4, IBUF_data_in_5, IBUF_data_in_6, IBUF_data_in_7, IBUF_data_in_8, IBUF_data_in_9, IBUF_data_in_10, IBUF_data_in_11, IBUF_data_in_12,IBUF_data_in_13, IBUF_data_in_14, IBUF_data_in_15, IBUF_data_in_16;


  // WBUF inputs (showing 1_1…1_4, 2_1…2_4; expand to all)
  reg [31:0] WBUF_data_in_1_1, WBUF_data_in_1_2, WBUF_data_in_1_3, WBUF_data_in_1_4, WBUF_data_in_1_5, WBUF_data_in_1_6, WBUF_data_in_1_7, WBUF_data_in_1_8, WBUF_data_in_1_9, WBUF_data_in_1_10, WBUF_data_in_1_11, WBUF_data_in_1_12,WBUF_data_in_1_13, WBUF_data_in_1_14, WBUF_data_in_1_15, WBUF_data_in_1_16;
  reg [31:0] WBUF_data_in_2_1, WBUF_data_in_2_2, WBUF_data_in_2_3, WBUF_data_in_2_4, WBUF_data_in_2_5, WBUF_data_in_2_6, WBUF_data_in_2_7, WBUF_data_in_2_8, WBUF_data_in_2_9, WBUF_data_in_2_10, WBUF_data_in_2_11, WBUF_data_in_2_12,WBUF_data_in_2_13, WBUF_data_in_2_14, WBUF_data_in_2_15, WBUF_data_in_2_16;;
  reg [31:0] WBUF_data_in_3_1, WBUF_data_in_3_2, WBUF_data_in_3_3, WBUF_data_in_3_4, WBUF_data_in_3_5, WBUF_data_in_3_6, WBUF_data_in_3_7, WBUF_data_in_3_8, WBUF_data_in_3_9, WBUF_data_in_3_10, WBUF_data_in_3_11, WBUF_data_in_3_12,WBUF_data_in_3_13, WBUF_data_in_3_14, WBUF_data_in_3_15, WBUF_data_in_3_16;;
  reg [31:0] WBUF_data_in_4_1, WBUF_data_in_4_2, WBUF_data_in_4_3, WBUF_data_in_4_4, WBUF_data_in_4_5, WBUF_data_in_4_6, WBUF_data_in_4_7, WBUF_data_in_4_8, WBUF_data_in_4_9, WBUF_data_in_4_10, WBUF_data_in_4_11, WBUF_data_in_4_12,WBUF_data_in_4_13, WBUF_data_in_4_14, WBUF_data_in_4_15, WBUF_data_in_4_16;;
  reg [31:0] WBUF_data_in_5_1, WBUF_data_in_5_2, WBUF_data_in_5_3, WBUF_data_in_5_4, WBUF_data_in_5_5, WBUF_data_in_5_6, WBUF_data_in_5_7, WBUF_data_in_5_8, WBUF_data_in_5_9, WBUF_data_in_5_10, WBUF_data_in_5_11, WBUF_data_in_5_12,WBUF_data_in_5_13, WBUF_data_in_2_14, WBUF_data_in_5_15, WBUF_data_in_5_16;;
  reg [31:0] WBUF_data_in_6_1, WBUF_data_in_6_2, WBUF_data_in_6_3, WBUF_data_in_6_4, WBUF_data_in_6_5, WBUF_data_in_6_6, WBUF_data_in_6_7, WBUF_data_in_6_8, WBUF_data_in_6_9, WBUF_data_in_6_10, WBUF_data_in_6_11, WBUF_data_in_6_12,WBUF_data_in_6_13, WBUF_data_in_2_14, WBUF_data_in_6_15, WBUF_data_in_6_16;;
  reg [31:0] WBUF_data_in_7_1, WBUF_data_in_7_2, WBUF_data_in_7_3, WBUF_data_in_7_4, WBUF_data_in_7_5, WBUF_data_in_7_6, WBUF_data_in_7_7, WBUF_data_in_7_8, WBUF_data_in_7_9, WBUF_data_in_7_10, WBUF_data_in_7_11, WBUF_data_in_7_12,WBUF_data_in_7_13, WBUF_data_in_2_14, WBUF_data_in_7_15, WBUF_data_in_7_16;;
  reg [31:0] WBUF_data_in_8_1, WBUF_data_in_8_2, WBUF_data_in_8_3, WBUF_data_in_8_4, WBUF_data_in_8_5, WBUF_data_in_8_6, WBUF_data_in_8_7, WBUF_data_in_8_8, WBUF_data_in_8_9, WBUF_data_in_8_10, WBUF_data_in_8_11, WBUF_data_in_8_12,WBUF_data_in_8_13, WBUF_data_in_2_14, WBUF_data_in_8_15, WBUF_data_in_8_16;;
  reg [31:0] WBUF_data_in_9_1, WBUF_data_in_9_2, WBUF_data_in_9_3, WBUF_data_in_9_4, WBUF_data_in_9_5, WBUF_data_in_9_6, WBUF_data_in_9_7, WBUF_data_in_9_8, WBUF_data_in_9_9, WBUF_data_in_9_10, WBUF_data_in_9_11, WBUF_data_in_9_12,WBUF_data_in_9_13, WBUF_data_in_2_14, WBUF_data_in_9_15, WBUF_data_in_9_16;;
  reg [31:0] WBUF_data_in_10_1, WBUF_data_in_10_2, WBUF_data_in_10_3, WBUF_data_in_10_4, WBUF_data_in_10_5, WBUF_data_in_10_6, WBUF_data_in_10_7, WBUF_data_in_10_8, WBUF_data_in_10_9, WBUF_data_in_10_10, WBUF_data_in_10_11, WBUF_data_in_10_12,WBUF_data_in_10_13, WBUF_data_in_2_14, WBUF_data_in_10_15, WBUF_data_in_10_16;;
  reg [31:0] WBUF_data_in_11_1, WBUF_data_in_11_2, WBUF_data_in_11_3, WBUF_data_in_11_4, WBUF_data_in_11_5, WBUF_data_in_11_6, WBUF_data_in_11_7, WBUF_data_in_11_8, WBUF_data_in_11_9, WBUF_data_in_11_10, WBUF_data_in_11_11, WBUF_data_in_11_12,WBUF_data_in_11_13, WBUF_data_in_2_14, WBUF_data_in_11_15, WBUF_data_in_11_16;;
  reg [31:0] WBUF_data_in_12_1, WBUF_data_in_12_2, WBUF_data_in_12_3, WBUF_data_in_12_4, WBUF_data_in_12_5, WBUF_data_in_12_6, WBUF_data_in_12_7, WBUF_data_in_12_8, WBUF_data_in_12_9, WBUF_data_in_12_10, WBUF_data_in_12_11, WBUF_data_in_12_12,WBUF_data_in_12_13, WBUF_data_in_2_14, WBUF_data_in_12_15, WBUF_data_in_12_16;;
  reg [31:0] WBUF_data_in_13_1, WBUF_data_in_13_2, WBUF_data_in_13_3, WBUF_data_in_13_4, WBUF_data_in_13_5, WBUF_data_in_13_6, WBUF_data_in_13_7, WBUF_data_in_13_8, WBUF_data_in_13_9, WBUF_data_in_13_10, WBUF_data_in_13_11, WBUF_data_in_13_12,WBUF_data_in_13_13, WBUF_data_in_2_14, WBUF_data_in_13_15, WBUF_data_in_13_16;;
  reg [31:0] WBUF_data_in_14_1, WBUF_data_in_14_2, WBUF_data_in_14_3, WBUF_data_in_14_4, WBUF_data_in_14_5, WBUF_data_in_14_6, WBUF_data_in_14_7, WBUF_data_in_14_8, WBUF_data_in_14_9, WBUF_data_in_14_10, WBUF_data_in_14_11, WBUF_data_in_14_12,WBUF_data_in_14_13, WBUF_data_in_2_14, WBUF_data_in_14_15, WBUF_data_in_14_16;;
  reg [31:0] WBUF_data_in_15_1, WBUF_data_in_15_2, WBUF_data_in_15_3, WBUF_data_in_15_4, WBUF_data_in_15_5, WBUF_data_in_15_6, WBUF_data_in_15_7, WBUF_data_in_15_8, WBUF_data_in_15_9, WBUF_data_in_15_10, WBUF_data_in_15_11, WBUF_data_in_15_12,WBUF_data_in_15_13, WBUF_data_in_2_14, WBUF_data_in_15_15, WBUF_data_in_15_16;;
  reg [31:0] WBUF_data_in_16_1, WBUF_data_in_16_2, WBUF_data_in_16_3, WBUF_data_in_16_4, WBUF_data_in_16_5, WBUF_data_in_16_6, WBUF_data_in_16_7, WBUF_data_in_16_8, WBUF_data_in_16_9, WBUF_data_in_16_10, WBUF_data_in_16_11, WBUF_data_in_16_12,WBUF_data_in_16_13, WBUF_data_in_2_14, WBUF_data_in_16_15, WBUF_data_in_16_16;;

  // … declare WBUF_data_in_X_Y up to 16_16 …

  // Other control inputs
  reg [3:0] sign_x, sign_y;
  reg [1:0] weight_bitwidth, input_bitwidth;
  reg [47:0] signal;

  // DUT outputs (only 1–4 shown; expand to all 16)
  wire [27:0] total_output_1, total_output_2, total_output_3, total_output_4, total_output_5, total_output_6, total_output_7, total_output_8,total_output_9, total_output_10, total_output_11, total_output_12, total_output_13, total_output_14, total_output_15, total_output_16;
  // … total_output_5 … total_output_16 …

  // Instantiate DUT
  BitFusion dut (
    .clk(clk),
    .reset(reset),
    .IBUF_data_in_1(IBUF_data_in_1),
    .IBUF_data_in_2(IBUF_data_in_2),
    .IBUF_data_in_3(IBUF_data_in_3),
    .IBUF_data_in_4(IBUF_data_in_4),
    .IBUF_data_in_5(IBUF_data_in_5),
    .IBUF_data_in_6(IBUF_data_in_6),
    .IBUF_data_in_7(IBUF_data_in_7),
    .IBUF_data_in_8(IBUF_data_in_8),
    .IBUF_data_in_9(IBUF_data_in_9),
    .IBUF_data_in_10(IBUF_data_in_10),
    .IBUF_data_in_11(IBUF_data_in_11),
    .IBUF_data_in_12(IBUF_data_in_12),
    .IBUF_data_in_13(IBUF_data_in_13),
    .IBUF_data_in_14(IBUF_data_in_14),
    .IBUF_data_in_15(IBUF_data_in_15),
    .IBUF_data_in_16(IBUF_data_in_16),
    // … connect remaining IBUF_data_in_* …
    .WBUF_data_in_1_1(WBUF_data_in_1_1),
    .WBUF_data_in_1_2(WBUF_data_in_1_2),
    .WBUF_data_in_1_3(WBUF_data_in_1_3),
    .WBUF_data_in_1_4(WBUF_data_in_1_4),
    .WBUF_data_in_1_5(WBUF_data_in_1_5),
    .WBUF_data_in_1_6(WBUF_data_in_1_6),
    .WBUF_data_in_1_7(WBUF_data_in_1_7),
    .WBUF_data_in_1_8(WBUF_data_in_1_8),
    .WBUF_data_in_1_9(WBUF_data_in_1_9),
    .WBUF_data_in_1_10(WBUF_data_in_1_10),
    .WBUF_data_in_1_11(WBUF_data_in_1_11),
    .WBUF_data_in_1_12(WBUF_data_in_1_12),
    .WBUF_data_in_1_13(WBUF_data_in_1_13),
    .WBUF_data_in_1_14(WBUF_data_in_1_14),
    .WBUF_data_in_1_15(WBUF_data_in_1_15),
    .WBUF_data_in_1_16(WBUF_data_in_1_16),
    
    .WBUF_data_in_2_1(WBUF_data_in_2_1),
    .WBUF_data_in_2_2(WBUF_data_in_2_2),
    .WBUF_data_in_2_3(WBUF_data_in_2_3),
    .WBUF_data_in_2_4(WBUF_data_in_2_4),
    .WBUF_data_in_2_5(WBUF_data_in_2_5),
    .WBUF_data_in_2_6(WBUF_data_in_2_6),
    .WBUF_data_in_2_7(WBUF_data_in_2_7),
    .WBUF_data_in_2_8(WBUF_data_in_2_8),
    .WBUF_data_in_2_9(WBUF_data_in_2_9),
    .WBUF_data_in_2_10(WBUF_data_in_2_10),
    .WBUF_data_in_2_11(WBUF_data_in_2_11),
    .WBUF_data_in_2_12(WBUF_data_in_2_12),
    .WBUF_data_in_2_13(WBUF_data_in_2_13),
    .WBUF_data_in_2_14(WBUF_data_in_2_14),
    .WBUF_data_in_2_15(WBUF_data_in_2_15),
    .WBUF_data_in_2_16(WBUF_data_in_2_16),

    .WBUF_data_in_3_1(WBUF_data_in_3_1),
    .WBUF_data_in_3_2(WBUF_data_in_3_2),
    .WBUF_data_in_3_3(WBUF_data_in_3_3),
    .WBUF_data_in_3_4(WBUF_data_in_3_4),
    .WBUF_data_in_3_5(WBUF_data_in_3_5),
    .WBUF_data_in_3_6(WBUF_data_in_3_6),
    .WBUF_data_in_3_7(WBUF_data_in_3_7),
    .WBUF_data_in_3_8(WBUF_data_in_3_8),
    .WBUF_data_in_3_9(WBUF_data_in_3_9),
    .WBUF_data_in_3_10(WBUF_data_in_3_10),
    .WBUF_data_in_3_11(WBUF_data_in_3_11),
    .WBUF_data_in_3_12(WBUF_data_in_3_12),
    .WBUF_data_in_3_13(WBUF_data_in_3_13),
    .WBUF_data_in_3_14(WBUF_data_in_3_14),
    .WBUF_data_in_3_15(WBUF_data_in_3_15),
    .WBUF_data_in_3_16(WBUF_data_in_3_16),

        // Row 4
    .WBUF_data_in_4_1 (WBUF_data_in_4_1),
    .WBUF_data_in_4_2 (WBUF_data_in_4_2),
    .WBUF_data_in_4_3 (WBUF_data_in_4_3),
    .WBUF_data_in_4_4 (WBUF_data_in_4_4),
    .WBUF_data_in_4_5 (WBUF_data_in_4_5),
    .WBUF_data_in_4_6 (WBUF_data_in_4_6),
    .WBUF_data_in_4_7 (WBUF_data_in_4_7),
    .WBUF_data_in_4_8 (WBUF_data_in_4_8),
    .WBUF_data_in_4_9 (WBUF_data_in_4_9),
    .WBUF_data_in_4_10(WBUF_data_in_4_10),
    .WBUF_data_in_4_11(WBUF_data_in_4_11),
    .WBUF_data_in_4_12(WBUF_data_in_4_12),
    .WBUF_data_in_4_13(WBUF_data_in_4_13),
    .WBUF_data_in_4_14(WBUF_data_in_4_14),
    .WBUF_data_in_4_15(WBUF_data_in_4_15),
    .WBUF_data_in_4_16(WBUF_data_in_4_16),

    // Row 5
    .WBUF_data_in_5_1 (WBUF_data_in_5_1),
    .WBUF_data_in_5_2 (WBUF_data_in_5_2),
    .WBUF_data_in_5_3 (WBUF_data_in_5_3),
    .WBUF_data_in_5_4 (WBUF_data_in_5_4),
    .WBUF_data_in_5_5 (WBUF_data_in_5_5),
    .WBUF_data_in_5_6 (WBUF_data_in_5_6),
    .WBUF_data_in_5_7 (WBUF_data_in_5_7),
    .WBUF_data_in_5_8 (WBUF_data_in_5_8),
    .WBUF_data_in_5_9 (WBUF_data_in_5_9),
    .WBUF_data_in_5_10(WBUF_data_in_5_10),
    .WBUF_data_in_5_11(WBUF_data_in_5_11),
    .WBUF_data_in_5_12(WBUF_data_in_5_12),
    .WBUF_data_in_5_13(WBUF_data_in_5_13),
    .WBUF_data_in_5_14(WBUF_data_in_5_14),
    .WBUF_data_in_5_15(WBUF_data_in_5_15),
    .WBUF_data_in_5_16(WBUF_data_in_5_16),

    // Row 6
    .WBUF_data_in_6_1 (WBUF_data_in_6_1),
    .WBUF_data_in_6_2 (WBUF_data_in_6_2),
    .WBUF_data_in_6_3 (WBUF_data_in_6_3),
    .WBUF_data_in_6_4 (WBUF_data_in_6_4),
    .WBUF_data_in_6_5 (WBUF_data_in_6_5),
    .WBUF_data_in_6_6 (WBUF_data_in_6_6),
    .WBUF_data_in_6_7 (WBUF_data_in_6_7),
    .WBUF_data_in_6_8 (WBUF_data_in_6_8),
    .WBUF_data_in_6_9 (WBUF_data_in_6_9),
    .WBUF_data_in_6_10(WBUF_data_in_6_10),
    .WBUF_data_in_6_11(WBUF_data_in_6_11),
    .WBUF_data_in_6_12(WBUF_data_in_6_12),
    .WBUF_data_in_6_13(WBUF_data_in_6_13),
    .WBUF_data_in_6_14(WBUF_data_in_6_14),
    .WBUF_data_in_6_15(WBUF_data_in_6_15),
    .WBUF_data_in_6_16(WBUF_data_in_6_16),

    // Row 7
    .WBUF_data_in_7_1 (WBUF_data_in_7_1),
    .WBUF_data_in_7_2 (WBUF_data_in_7_2),
    .WBUF_data_in_7_3 (WBUF_data_in_7_3),
    .WBUF_data_in_7_4 (WBUF_data_in_7_4),
    .WBUF_data_in_7_5 (WBUF_data_in_7_5),
    .WBUF_data_in_7_6 (WBUF_data_in_7_6),
    .WBUF_data_in_7_7 (WBUF_data_in_7_7),
    .WBUF_data_in_7_8 (WBUF_data_in_7_8),
    .WBUF_data_in_7_9 (WBUF_data_in_7_9),
    .WBUF_data_in_7_10(WBUF_data_in_7_10),
    .WBUF_data_in_7_11(WBUF_data_in_7_11),
    .WBUF_data_in_7_12(WBUF_data_in_7_12),
    .WBUF_data_in_7_13(WBUF_data_in_7_13),
    .WBUF_data_in_7_14(WBUF_data_in_7_14),
    .WBUF_data_in_7_15(WBUF_data_in_7_15),
    .WBUF_data_in_7_16(WBUF_data_in_7_16),

    // Row 8
    .WBUF_data_in_8_1 (WBUF_data_in_8_1),
    .WBUF_data_in_8_2 (WBUF_data_in_8_2),
    .WBUF_data_in_8_3 (WBUF_data_in_8_3),
    .WBUF_data_in_8_4 (WBUF_data_in_8_4),
    .WBUF_data_in_8_5 (WBUF_data_in_8_5),
    .WBUF_data_in_8_6 (WBUF_data_in_8_6),
    .WBUF_data_in_8_7 (WBUF_data_in_8_7),
    .WBUF_data_in_8_8 (WBUF_data_in_8_8),
    .WBUF_data_in_8_9 (WBUF_data_in_8_9),
    .WBUF_data_in_8_10(WBUF_data_in_8_10),
    .WBUF_data_in_8_11(WBUF_data_in_8_11),
    .WBUF_data_in_8_12(WBUF_data_in_8_12),
    .WBUF_data_in_8_13(WBUF_data_in_8_13),
    .WBUF_data_in_8_14(WBUF_data_in_8_14),
    .WBUF_data_in_8_15(WBUF_data_in_8_15),
    .WBUF_data_in_8_16(WBUF_data_in_8_16),

    // Row 9
    .WBUF_data_in_9_1 (WBUF_data_in_9_1),
    .WBUF_data_in_9_2 (WBUF_data_in_9_2),
    .WBUF_data_in_9_3 (WBUF_data_in_9_3),
    .WBUF_data_in_9_4 (WBUF_data_in_9_4),
    .WBUF_data_in_9_5 (WBUF_data_in_9_5),
    .WBUF_data_in_9_6 (WBUF_data_in_9_6),
    .WBUF_data_in_9_7 (WBUF_data_in_9_7),
    .WBUF_data_in_9_8 (WBUF_data_in_9_8),
    .WBUF_data_in_9_9 (WBUF_data_in_9_9),
    .WBUF_data_in_9_10(WBUF_data_in_9_10),
    .WBUF_data_in_9_11(WBUF_data_in_9_11),
    .WBUF_data_in_9_12(WBUF_data_in_9_12),
    .WBUF_data_in_9_13(WBUF_data_in_9_13),
    .WBUF_data_in_9_14(WBUF_data_in_9_14),
    .WBUF_data_in_9_15(WBUF_data_in_9_15),
    .WBUF_data_in_9_16(WBUF_data_in_9_16),

    // Row 10
    .WBUF_data_in_10_1 (WBUF_data_in_10_1),
    .WBUF_data_in_10_2 (WBUF_data_in_10_2),
    .WBUF_data_in_10_3 (WBUF_data_in_10_3),
    .WBUF_data_in_10_4 (WBUF_data_in_10_4),
    .WBUF_data_in_10_5 (WBUF_data_in_10_5),
    .WBUF_data_in_10_6 (WBUF_data_in_10_6),
    .WBUF_data_in_10_7 (WBUF_data_in_10_7),
    .WBUF_data_in_10_8 (WBUF_data_in_10_8),
    .WBUF_data_in_10_9 (WBUF_data_in_10_9),
    .WBUF_data_in_10_10(WBUF_data_in_10_10),
    .WBUF_data_in_10_11(WBUF_data_in_10_11),
    .WBUF_data_in_10_12(WBUF_data_in_10_12),
    .WBUF_data_in_10_13(WBUF_data_in_10_13),
    .WBUF_data_in_10_14(WBUF_data_in_10_14),
    .WBUF_data_in_10_15(WBUF_data_in_10_15),
    .WBUF_data_in_10_16(WBUF_data_in_10_16),

    // Row 11
    .WBUF_data_in_11_1 (WBUF_data_in_11_1),
    .WBUF_data_in_11_2 (WBUF_data_in_11_2),
    .WBUF_data_in_11_3 (WBUF_data_in_11_3),
    .WBUF_data_in_11_4 (WBUF_data_in_11_4),
    .WBUF_data_in_11_5 (WBUF_data_in_11_5),
    .WBUF_data_in_11_6 (WBUF_data_in_11_6),
    .WBUF_data_in_11_7 (WBUF_data_in_11_7),
    .WBUF_data_in_11_8 (WBUF_data_in_11_8),
    .WBUF_data_in_11_9 (WBUF_data_in_11_9),
    .WBUF_data_in_11_10(WBUF_data_in_11_10),
    .WBUF_data_in_11_11(WBUF_data_in_11_11),
    .WBUF_data_in_11_12(WBUF_data_in_11_12),
    .WBUF_data_in_11_13(WBUF_data_in_11_13),
    .WBUF_data_in_11_14(WBUF_data_in_11_14),
    .WBUF_data_in_11_15(WBUF_data_in_11_15),
    .WBUF_data_in_11_16(WBUF_data_in_11_16),

    // Row 12
    .WBUF_data_in_12_1 (WBUF_data_in_12_1),
    .WBUF_data_in_12_2 (WBUF_data_in_12_2),
    .WBUF_data_in_12_3 (WBUF_data_in_12_3),
    .WBUF_data_in_12_4 (WBUF_data_in_12_4),
    .WBUF_data_in_12_5 (WBUF_data_in_12_5),
    .WBUF_data_in_12_6 (WBUF_data_in_12_6),
    .WBUF_data_in_12_7 (WBUF_data_in_12_7),
    .WBUF_data_in_12_8 (WBUF_data_in_12_8),
    .WBUF_data_in_12_9 (WBUF_data_in_12_9),
    .WBUF_data_in_12_10(WBUF_data_in_12_10),
    .WBUF_data_in_12_11(WBUF_data_in_12_11),
    .WBUF_data_in_12_12(WBUF_data_in_12_12),
    .WBUF_data_in_12_13(WBUF_data_in_12_13),
    .WBUF_data_in_12_14(WBUF_data_in_12_14),
    .WBUF_data_in_12_15(WBUF_data_in_12_15),
    .WBUF_data_in_12_16(WBUF_data_in_12_16),

    // Row 13
    .WBUF_data_in_13_1 (WBUF_data_in_13_1),
    .WBUF_data_in_13_2 (WBUF_data_in_13_2),
    .WBUF_data_in_13_3 (WBUF_data_in_13_3),
    .WBUF_data_in_13_4 (WBUF_data_in_13_4),
    .WBUF_data_in_13_5 (WBUF_data_in_13_5),
    .WBUF_data_in_13_6 (WBUF_data_in_13_6),
    .WBUF_data_in_13_7 (WBUF_data_in_13_7),
    .WBUF_data_in_13_8 (WBUF_data_in_13_8),
    .WBUF_data_in_13_9 (WBUF_data_in_13_9),
    .WBUF_data_in_13_10(WBUF_data_in_13_10),
    .WBUF_data_in_13_11(WBUF_data_in_13_11),
    .WBUF_data_in_13_12(WBUF_data_in_13_12),
    .WBUF_data_in_13_13(WBUF_data_in_13_13),
    .WBUF_data_in_13_14(WBUF_data_in_13_14),
    .WBUF_data_in_13_15(WBUF_data_in_13_15),
    .WBUF_data_in_13_16(WBUF_data_in_13_16),

    // Row 14
    .WBUF_data_in_14_1 (WBUF_data_in_14_1),
    .WBUF_data_in_14_2 (WBUF_data_in_14_2),
    .WBUF_data_in_14_3 (WBUF_data_in_14_3),
    .WBUF_data_in_14_4 (WBUF_data_in_14_4),
    .WBUF_data_in_14_5 (WBUF_data_in_14_5),
    .WBUF_data_in_14_6 (WBUF_data_in_14_6),
    .WBUF_data_in_14_7 (WBUF_data_in_14_7),
    .WBUF_data_in_14_8 (WBUF_data_in_14_8),
    .WBUF_data_in_14_9 (WBUF_data_in_14_9),
    .WBUF_data_in_14_10(WBUF_data_in_14_10),
    .WBUF_data_in_14_11(WBUF_data_in_14_11),
    .WBUF_data_in_14_12(WBUF_data_in_14_12),
    .WBUF_data_in_14_13(WBUF_data_in_14_13),
    .WBUF_data_in_14_14(WBUF_data_in_14_14),
    .WBUF_data_in_14_15(WBUF_data_in_14_15),
    .WBUF_data_in_14_16(WBUF_data_in_14_16),

    // Row 15
    .WBUF_data_in_15_1 (WBUF_data_in_15_1),
    .WBUF_data_in_15_2 (WBUF_data_in_15_2),
    .WBUF_data_in_15_3 (WBUF_data_in_15_3),
    .WBUF_data_in_15_4 (WBUF_data_in_15_4),
    .WBUF_data_in_15_5 (WBUF_data_in_15_5),
    .WBUF_data_in_15_6 (WBUF_data_in_15_6),
    .WBUF_data_in_15_7 (WBUF_data_in_15_7),
    .WBUF_data_in_15_8 (WBUF_data_in_15_8),
    .WBUF_data_in_15_9 (WBUF_data_in_15_9),
    .WBUF_data_in_15_10(WBUF_data_in_15_10),
    .WBUF_data_in_15_11(WBUF_data_in_15_11),
    .WBUF_data_in_15_12(WBUF_data_in_15_12),
    .WBUF_data_in_15_13(WBUF_data_in_15_13),
    .WBUF_data_in_15_14(WBUF_data_in_15_14),
    .WBUF_data_in_15_15(WBUF_data_in_15_15),
    .WBUF_data_in_15_16(WBUF_data_in_15_16),

    // Row 16
    .WBUF_data_in_16_1 (WBUF_data_in_16_1),
    .WBUF_data_in_16_2 (WBUF_data_in_16_2),
    .WBUF_data_in_16_3 (WBUF_data_in_16_3),
    .WBUF_data_in_16_4 (WBUF_data_in_16_4),
    .WBUF_data_in_16_5 (WBUF_data_in_16_5),
    .WBUF_data_in_16_6 (WBUF_data_in_16_6),
    .WBUF_data_in_16_7 (WBUF_data_in_16_7),
    .WBUF_data_in_16_8 (WBUF_data_in_16_8),
    .WBUF_data_in_16_9 (WBUF_data_in_16_9),
    .WBUF_data_in_16_10(WBUF_data_in_16_10),
    .WBUF_data_in_16_11(WBUF_data_in_16_11),
    .WBUF_data_in_16_12(WBUF_data_in_16_12),
    .WBUF_data_in_16_13(WBUF_data_in_16_13),
    .WBUF_data_in_16_14(WBUF_data_in_16_14),
    .WBUF_data_in_16_15(WBUF_data_in_16_15),
    .WBUF_data_in_16_16(WBUF_data_in_16_16),

    
    // … connect remaining WBUF_data_in_* …
    .sign_x(sign_x),
    .sign_y(sign_y),
    .weight_bitwidth(weight_bitwidth),
    .input_bitwidth(input_bitwidth),
    .signal(signal),
    .total_output_1(total_output_1),
    .total_output_2(total_output_2),
    .total_output_3(total_output_3),
    .total_output_4(total_output_4),
    .total_output_5(total_output_5),
    .total_output_6(total_output_6),
    .total_output_7(total_output_7),
    .total_output_8(total_output_8),
    .total_output_9(total_output_9),
    .total_output_10(total_output_10),
    .total_output_11(total_output_11),
    .total_output_12(total_output_12),
    .total_output_13(total_output_13),
    .total_output_14(total_output_14),
    .total_output_15(total_output_15),
    .total_output_16(total_output_16),

    // … connect remaining total_output_* …
  );

  // Clock generation: 10 ns period → 100 MHz
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // 1) Open VCD dump
    $dumpfile("BitFusion_tb.vcd");
    $dumpvars(0, tb_BitFusion);

    // 2) Reset pulse
    reset = 1;
    #20;
    reset = 0;

    // 3) Initialize control inputs
    sign_x         = 4'b0001;
    sign_y         = 4'b0010;
    weight_bitwidth= 2'b01;
    input_bitwidth = 2'b10;
    signal         = 48'h0000_0000_0001;

    // 4) Apply test vectors on IBUF & WBUF
    // Frame 1
    IBUF_data_in_1  = 32'h0000_0001;
    IBUF_data_in_2  = 32'h0000_0002;
    IBUF_data_in_3  = 32'h0000_0003;
    IBUF_data_in_4  = 32'h0000_0004;
    IBUF_data_in_5  = 32'h0000_0005;
    IBUF_data_in_6  = 32'h0000_0006;
    IBUF_data_in_7  = 32'h0000_0007;
    IBUF_data_in_8  = 32'h0000_0008;
    IBUF_data_in_9  = 32'h0000_0009;
    IBUF_data_in_10 = 32'h0000_000A;
    IBUF_data_in_11 = 32'h0000_000B;
    IBUF_data_in_12 = 32'h0000_000C;
    IBUF_data_in_13 = 32'h0000_000D;
    IBUF_data_in_14 = 32'h0000_000E;
    IBUF_data_in_15 = 32'h0000_000F;
    IBUF_data_in_16 = 32'h0000_0010;

        // Row 1
    WBUF_data_in_1_1  = 32'h0000_0011;
    WBUF_data_in_1_2  = 32'h0000_0012;
    WBUF_data_in_1_3  = 32'h0000_0013;
    WBUF_data_in_1_4  = 32'h0000_0014;
    WBUF_data_in_1_5  = 32'h0000_0015;
    WBUF_data_in_1_6  = 32'h0000_0016;
    WBUF_data_in_1_7  = 32'h0000_0017;
    WBUF_data_in_1_8  = 32'h0000_0018;
    WBUF_data_in_1_9  = 32'h0000_0019;
    WBUF_data_in_1_10 = 32'h0000_001A;
    WBUF_data_in_1_11 = 32'h0000_001B;
    WBUF_data_in_1_12 = 32'h0000_001C;
    WBUF_data_in_1_13 = 32'h0000_001D;
    WBUF_data_in_1_14 = 32'h0000_001E;
    WBUF_data_in_1_15 = 32'h0000_001F;
    WBUF_data_in_1_16 = 32'h0000_0020;

    // Row 2
    WBUF_data_in_2_1  = 32'h0000_0021;
    WBUF_data_in_2_2  = 32'h0000_0022;
    WBUF_data_in_2_3  = 32'h0000_0023;
    WBUF_data_in_2_4  = 32'h0000_0024;
    WBUF_data_in_2_5  = 32'h0000_0025;
    WBUF_data_in_2_6  = 32'h0000_0026;
    WBUF_data_in_2_7  = 32'h0000_0027;
    WBUF_data_in_2_8  = 32'h0000_0028;
    WBUF_data_in_2_9  = 32'h0000_0029;
    WBUF_data_in_2_10 = 32'h0000_002A;
    WBUF_data_in_2_11 = 32'h0000_002B;
    WBUF_data_in_2_12 = 32'h0000_002C;
    WBUF_data_in_2_13 = 32'h0000_002D;
    WBUF_data_in_2_14 = 32'h0000_002E;
    WBUF_data_in_2_15 = 32'h0000_002F;
    WBUF_data_in_2_16 = 32'h0000_0030;

    // Row 3
    WBUF_data_in_3_1  = 32'h0000_0031;
    WBUF_data_in_3_2  = 32'h0000_0032;
    WBUF_data_in_3_3  = 32'h0000_0033;
    WBUF_data_in_3_4  = 32'h0000_0034;
    WBUF_data_in_3_5  = 32'h0000_0035;
    WBUF_data_in_3_6  = 32'h0000_0036;
    WBUF_data_in_3_7  = 32'h0000_0037;
    WBUF_data_in_3_8  = 32'h0000_0038;
    WBUF_data_in_3_9  = 32'h0000_0039;
    WBUF_data_in_3_10 = 32'h0000_003A;
    WBUF_data_in_3_11 = 32'h0000_003B;
    WBUF_data_in_3_12 = 32'h0000_003C;
    WBUF_data_in_3_13 = 32'h0000_003D;
    WBUF_data_in_3_14 = 32'h0000_003E;
    WBUF_data_in_3_15 = 32'h0000_003F;
    WBUF_data_in_3_16 = 32'h0000_0040;

    // Row 4
    WBUF_data_in_4_1  = 32'h0000_0041;
    WBUF_data_in_4_2  = 32'h0000_0042;
    WBUF_data_in_4_3  = 32'h0000_0043;
    WBUF_data_in_4_4  = 32'h0000_0044;
    WBUF_data_in_4_5  = 32'h0000_0045;
    WBUF_data_in_4_6  = 32'h0000_0046;
    WBUF_data_in_4_7  = 32'h0000_0047;
    WBUF_data_in_4_8  = 32'h0000_0048;
    WBUF_data_in_4_9  = 32'h0000_0049;
    WBUF_data_in_4_10 = 32'h0000_004A;
    WBUF_data_in_4_11 = 32'h0000_004B;
    WBUF_data_in_4_12 = 32'h0000_004C;
    WBUF_data_in_4_13 = 32'h0000_004D;
    WBUF_data_in_4_14 = 32'h0000_004E;
    WBUF_data_in_4_15 = 32'h0000_004F;
    WBUF_data_in_4_16 = 32'h0000_0050;

    // Row 5
    WBUF_data_in_5_1  = 32'h0000_0051;
    WBUF_data_in_5_2  = 32'h0000_0052;
    WBUF_data_in_5_3  = 32'h0000_0053;
    WBUF_data_in_5_4  = 32'h0000_0054;
    WBUF_data_in_5_5  = 32'h0000_0055;
    WBUF_data_in_5_6  = 32'h0000_0056;
    WBUF_data_in_5_7  = 32'h0000_0057;
    WBUF_data_in_5_8  = 32'h0000_0058;
    WBUF_data_in_5_9  = 32'h0000_0059;
    WBUF_data_in_5_10 = 32'h0000_005A;
    WBUF_data_in_5_11 = 32'h0000_005B;
    WBUF_data_in_5_12 = 32'h0000_005C;
    WBUF_data_in_5_13 = 32'h0000_005D;
    WBUF_data_in_5_14 = 32'h0000_005E;
    WBUF_data_in_5_15 = 32'h0000_005F;
    WBUF_data_in_5_16 = 32'h0000_0060;

    // Row 6
    WBUF_data_in_6_1  = 32'h0000_0061;
    WBUF_data_in_6_2  = 32'h0000_0062;
    WBUF_data_in_6_3  = 32'h0000_0063;
    WBUF_data_in_6_4  = 32'h0000_0064;
    WBUF_data_in_6_5  = 32'h0000_0065;
    WBUF_data_in_6_6  = 32'h0000_0066;
    WBUF_data_in_6_7  = 32'h0000_0067;
    WBUF_data_in_6_8  = 32'h0000_0068;
    WBUF_data_in_6_9  = 32'h0000_0069;
    WBUF_data_in_6_10 = 32'h0000_006A;
    WBUF_data_in_6_11 = 32'h0000_006B;
    WBUF_data_in_6_12 = 32'h0000_006C;
    WBUF_data_in_6_13 = 32'h0000_006D;
    WBUF_data_in_6_14 = 32'h0000_006E;
    WBUF_data_in_6_15 = 32'h0000_006F;
    WBUF_data_in_6_16 = 32'h0000_0070;

    // Row 7
    WBUF_data_in_7_1  = 32'h0000_0071;
    WBUF_data_in_7_2  = 32'h0000_0072;
    WBUF_data_in_7_3  = 32'h0000_0073;
    WBUF_data_in_7_4  = 32'h0000_0074;
    WBUF_data_in_7_5  = 32'h0000_0075;
    WBUF_data_in_7_6  = 32'h0000_0076;
    WBUF_data_in_7_7  = 32'h0000_0077;
    WBUF_data_in_7_8  = 32'h0000_0078;
    WBUF_data_in_7_9  = 32'h0000_0079;
    WBUF_data_in_7_10 = 32'h0000_007A;
    WBUF_data_in_7_11 = 32'h0000_007B;
    WBUF_data_in_7_12 = 32'h0000_007C;
    WBUF_data_in_7_13 = 32'h0000_007D;
    WBUF_data_in_7_14 = 32'h0000_007E;
    WBUF_data_in_7_15 = 32'h0000_007F;
    WBUF_data_in_7_16 = 32'h0000_0080;

    // Row 8
    WBUF_data_in_8_1  = 32'h0000_0081;
    WBUF_data_in_8_2  = 32'h0000_0082;
    WBUF_data_in_8_3  = 32'h0000_0083;
    WBUF_data_in_8_4  = 32'h0000_0084;
    WBUF_data_in_8_5  = 32'h0000_0085;
    WBUF_data_in_8_6  = 32'h0000_0086;
    WBUF_data_in_8_7  = 32'h0000_0087;
    WBUF_data_in_8_8  = 32'h0000_0088;
    WBUF_data_in_8_9  = 32'h0000_0089;
    WBUF_data_in_8_10 = 32'h0000_008A;
    WBUF_data_in_8_11 = 32'h0000_008B;
    WBUF_data_in_8_12 = 32'h0000_008C;
    WBUF_data_in_8_13 = 32'h0000_008D;
    WBUF_data_in_8_14 = 32'h0000_008E;
    WBUF_data_in_8_15 = 32'h0000_008F;
    WBUF_data_in_8_16 = 32'h0000_0090;

    // Row 9
    WBUF_data_in_9_1  = 32'h0000_0091;
    WBUF_data_in_9_2  = 32'h0000_0092;
    WBUF_data_in_9_3  = 32'h0000_0093;
    WBUF_data_in_9_4  = 32'h0000_0094;
    WBUF_data_in_9_5  = 32'h0000_0095;
    WBUF_data_in_9_6  = 32'h0000_0096;
    WBUF_data_in_9_7  = 32'h0000_0097;
    WBUF_data_in_9_8  = 32'h0000_0098;
    WBUF_data_in_9_9  = 32'h0000_0099;
    WBUF_data_in_9_10 = 32'h0000_009A;
    WBUF_data_in_9_11 = 32'h0000_009B;
    WBUF_data_in_9_12 = 32'h0000_009C;
    WBUF_data_in_9_13 = 32'h0000_009D;
    WBUF_data_in_9_14 = 32'h0000_009E;
    WBUF_data_in_9_15 = 32'h0000_009F;
    WBUF_data_in_9_16 = 32'h0000_00A0;

    // Row 10
    WBUF_data_in_10_1  = 32'h0000_00A1;
    WBUF_data_in_10_2  = 32'h0000_00A2;
    WBUF_data_in_10_3  = 32'h0000_00A3;
    WBUF_data_in_10_4  = 32'h0000_00A4;
    WBUF_data_in_10_5  = 32'h0000_00A5;
    WBUF_data_in_10_6  = 32'h0000_00A6;
    WBUF_data_in_10_7  = 32'h0000_00A7;
    WBUF_data_in_10_8  = 32'h0000_00A8;
    WBUF_data_in_10_9  = 32'h0000_00A9;
    WBUF_data_in_10_10 = 32'h0000_00AA;
    WBUF_data_in_10_11 = 32'h0000_00AB;
    WBUF_data_in_10_12 = 32'h0000_00AC;
    WBUF_data_in_10_13 = 32'h0000_00AD;
    WBUF_data_in_10_14 = 32'h0000_00AE;
    WBUF_data_in_10_15 = 32'h0000_00AF;
    WBUF_data_in_10_16 = 32'h0000_00B0;

    // Row 11
    WBUF_data_in_11_1  = 32'h0000_00B1;
    WBUF_data_in_11_2  = 32'h0000_00B2;
    WBUF_data_in_11_3  = 32'h0000_00B3;
    WBUF_data_in_11_4  = 32'h0000_00B4;
    WBUF_data_in_11_5  = 32'h0000_00B5;
    WBUF_data_in_11_6  = 32'h0000_00B6;
    WBUF_data_in_11_7  = 32'h0000_00B7;
    WBUF_data_in_11_8  = 32'h0000_00B8;
    WBUF_data_in_11_9  = 32'h0000_00B9;
    WBUF_data_in_11_10 = 32'h0000_00BA;
    WBUF_data_in_11_11 = 32'h0000_00BB;
    WBUF_data_in_11_12 = 32'h0000_00BC;
    WBUF_data_in_11_13 = 32'h0000_00BD;
    WBUF_data_in_11_14 = 32'h0000_00BE;
    WBUF_data_in_11_15 = 32'h0000_00BF;
    WBUF_data_in_11_16 = 32'h0000_00C0;

    // Row 12
    WBUF_data_in_12_1  = 32'h0000_00C1;
    WBUF_data_in_12_2  = 32'h0000_00C2;
    WBUF_data_in_12_3  = 32'h0000_00C3;
    WBUF_data_in_12_4  = 32'h0000_00C4;
    WBUF_data_in_12_5  = 32'h0000_00C5;
    WBUF_data_in_12_6  = 32'h0000_00C6;
    WBUF_data_in_12_7  = 32'h0000_00C7;
    WBUF_data_in_12_8  = 32'h0000_00C8;
    WBUF_data_in_12_9  = 32'h0000_00C9;
    WBUF_data_in_12_10 = 32'h0000_00CA;
    WBUF_data_in_12_11 = 32'h0000_00CB;
    WBUF_data_in_12_12 = 32'h0000_00CC;
    WBUF_data_in_12_13 = 32'h0000_00CD;
    WBUF_data_in_12_14 = 32'h0000_00CE;
    WBUF_data_in_12_15 = 32'h0000_00CF;
    WBUF_data_in_12_16 = 32'h0000_00D0;

    // Row 13
    WBUF_data_in_13_1  = 32'h0000_00D1;
    WBUF_data_in_13_2  = 32'h0000_00D2;
    WBUF_data_in_13_3  = 32'h0000_00D3;
    WBUF_data_in_13_4  = 32'h0000_00D4;
    WBUF_data_in_13_5  = 32'h0000_00D5;
    WBUF_data_in_13_6  = 32'h0000_00D6;
    WBUF_data_in_13_7  = 32'h0000_00D7;
    WBUF_data_in_13_8  = 32'h0000_00D8;
    WBUF_data_in_13_9  = 32'h0000_00D9;
    WBUF_data_in_13_10 = 32'h0000_00DA;
    WBUF_data_in_13_11 = 32'h0000_00DB;
    WBUF_data_in_13_12 = 32'h0000_00DC;
    WBUF_data_in_13_13 = 32'h0000_00DD;
    WBUF_data_in_13_14 = 32'h0000_00DE;
    WBUF_data_in_13_15 = 32'h0000_00DF;
    WBUF_data_in_13_16 = 32'h0000_00E0;

    // Row 14
    WBUF_data_in_14_1  = 32'h0000_00E1;
    WBUF_data_in_14_2  = 32'h0000_00E2;
    WBUF_data_in_14_3  = 32'h0000_00E3;
    WBUF_data_in_14_4  = 32'h0000_00E4;
    WBUF_data_in_14_5  = 32'h0000_00E5;
    WBUF_data_in_14_6  = 32'h0000_00E6;
    WBUF_data_in_14_7  = 32'h0000_00E7;
    WBUF_data_in_14_8  = 32'h0000_00E8;
    WBUF_data_in_14_9  = 32'h0000_00E9;
    WBUF_data_in_14_10 = 32'h0000_00EA;
    WBUF_data_in_14_11 = 32'h0000_00EB;
    WBUF_data_in_14_12 = 32'h0000_00EC;
    WBUF_data_in_14_13 = 32'h0000_00ED;
    WBUF_data_in_14_14 = 32'h0000_00EE;
    WBUF_data_in_14_15 = 32'h0000_00EF;
    WBUF_data_in_14_16 = 32'h0000_00F0;

    // Row 15
    WBUF_data_in_15_1  = 32'h0000_00F1;
    WBUF_data_in_15_2  = 32'h0000_00F2;
    WBUF_data_in_15_3  = 32'h0000_00F3;
    WBUF_data_in_15_4  = 32'h0000_00F4;
    WBUF_data_in_15_5  = 32'h0000_00F5;
    WBUF_data_in_15_6  = 32'h0000_00F6;
    WBUF_data_in_15_7  = 32'h0000_00F7;
    WBUF_data_in_15_8  = 32'h0000_00F8;
    WBUF_data_in_15_9  = 32'h0000_00F9;
    WBUF_data_in_15_10 = 32'h0000_00FA;
    WBUF_data_in_15_11 = 32'h0000_00FB;
    WBUF_data_in_15_12 = 32'h0000_00FC;
    WBUF_data_in_15_13 = 32'h0000_00FD;
    WBUF_data_in_15_14 = 32'h0000_00FE;
    WBUF_data_in_15_15 = 32'h0000_00FF;
    WBUF_data_in_15_16 = 32'h0000_0100;

    // Row 16
    WBUF_data_in_16_1  = 32'h0000_0101;
    WBUF_data_in_16_2  = 32'h0000_0102;
    WBUF_data_in_16_3  = 32'h0000_0103;
    WBUF_data_in_16_4  = 32'h0000_0104;
    WBUF_data_in_16_5  = 32'h0000_0105;
    WBUF_data_in_16_6  = 32'h0000_0106;
    WBUF_data_in_16_7  = 32'h0000_0107;
    WBUF_data_in_16_8  = 32'h0000_0108;
    WBUF_data_in_16_9  = 32'h0000_0109;
    WBUF_data_in_16_10 = 32'h0000_010A;
    WBUF_data_in_16_11 = 32'h0000_010B;
    WBUF_data_in_16_12 = 32'h0000_010C;
    WBUF_data_in_16_13 = 32'h0000_010D;
    WBUF_data_in_16_14 = 32'h0000_010E;
    WBUF_data_in_16_15 = 32'h0000_010F;
    WBUF_data_in_16_16 = 32'h0000_0110;


    // … continue in the same pattern through Row 16 …

    // … set WBUF_data_in_X_Y for all rows/columns …

    #10;  // let DUT process

    // Frame 2: change inputs
        // Change frame: new IBUF values
    IBUF_data_in_1  = 32'hFFFF_FFFF;
    IBUF_data_in_2  = 32'h0000_00AA;
    IBUF_data_in_3  = 32'h0000_00BB;
    IBUF_data_in_4  = 32'h0000_00CC;
    IBUF_data_in_5  = 32'h0000_00DD;
    IBUF_data_in_6  = 32'h0000_00EE;
    IBUF_data_in_7  = 32'h0000_00FF;
    IBUF_data_in_8  = 32'h1234_5678;
    IBUF_data_in_9  = 32'h8765_4321;
    IBUF_data_in_10 = 32'hDEAD_BEEF;
    IBUF_data_in_11 = 32'hCAFE_FACE;
    IBUF_data_in_12 = 32'h0BAD_F00D;
    IBUF_data_in_13 = 32'h55AA_AA55;
    IBUF_data_in_14 = 32'hA5A5_5A5A;
    IBUF_data_in_15 = 32'hFFFF_0000;
    IBUF_data_in_16 = 32'h0000_FFFF;

    // … etc …

        // Second frame: WBUF values
    // Row 1
    WBUF_data_in_1_1  = 32'h1234_5678;
    WBUF_data_in_1_2  = 32'h9ABC_DEF0;
    WBUF_data_in_1_3  = 32'h1111_2222;
    WBUF_data_in_1_4  = 32'h3333_4444;
    WBUF_data_in_1_5  = 32'h5555_6666;
    WBUF_data_in_1_6  = 32'h7777_8888;
    WBUF_data_in_1_7  = 32'h9999_AAAA;
    WBUF_data_in_1_8  = 32'hBBBB_CCCC;
    WBUF_data_in_1_9  = 32'hDDDD_EEEE;
    WBUF_data_in_1_10 = 32'hFFFF_0001;
    WBUF_data_in_1_11 = 32'h0001_2223;
    WBUF_data_in_1_12 = 32'h4445_6667;
    WBUF_data_in_1_13 = 32'h8889_AAAB;
    WBUF_data_in_1_14 = 32'hCCCD_EEEF;
    WBUF_data_in_1_15 = 32'h1234_1234;
    WBUF_data_in_1_16 = 32'h5678_5678;

    // Row 2
    WBUF_data_in_2_1  = 32'h9ABC_DEF1;
    WBUF_data_in_2_2  = 32'h2345_6789;
    WBUF_data_in_2_3  = 32'hBCDE_F012;
    WBUF_data_in_2_4  = 32'h3456_789A;
    WBUF_data_in_2_5  = 32'hCDEF_0123;
    WBUF_data_in_2_6  = 32'h4567_89AB;
    WBUF_data_in_2_7  = 32'hDEF0_1234;
    WBUF_data_in_2_8  = 32'h5678_9ABC;
    WBUF_data_in_2_9  = 32'hEF01_2345;
    WBUF_data_in_2_10 = 32'h6789_ABCD;
    WBUF_data_in_2_11 = 32'hF012_3456;
    WBUF_data_in_2_12 = 32'h789A_BCDE;
    WBUF_data_in_2_13 = 32'h0123_4567;
    WBUF_data_in_2_14 = 32'h89AB_CDEF;
    WBUF_data_in_2_15 = 32'h1234_5679;
    WBUF_data_in_2_16 = 32'h9ABC_DEF2;

    // Row 3
    WBUF_data_in_3_1  = 32'h1111_1111;
    WBUF_data_in_3_2  = 32'h2222_2222;
    WBUF_data_in_3_3  = 32'h3333_3333;
    WBUF_data_in_3_4  = 32'h4444_4444;
    WBUF_data_in_3_5  = 32'h5555_5555;
    WBUF_data_in_3_6  = 32'h6666_6666;
    WBUF_data_in_3_7  = 32'h7777_7777;
    WBUF_data_in_3_8  = 32'h8888_8888;
    WBUF_data_in_3_9  = 32'h9999_9999;
    WBUF_data_in_3_10 = 32'hAAAA_AAAA;
    WBUF_data_in_3_11 = 32'hBBBB_BBBB;
    WBUF_data_in_3_12 = 32'hCCCC_CCCC;
    WBUF_data_in_3_13 = 32'hDDDD_DDDD;
    WBUF_data_in_3_14 = 32'hEEEE_EEEE;
    WBUF_data_in_3_15 = 32'hFFFF_FFFF;
    WBUF_data_in_3_16 = 32'h0000_0000;

    // Row 4
    WBUF_data_in_4_1  = 32'h0F0F_0F0F;
    WBUF_data_in_4_2  = 32'hF0F0_F0F0;
    WBUF_data_in_4_3  = 32'h1E1E_1E1E;
    WBUF_data_in_4_4  = 32'hE1E1_E1E1;
    WBUF_data_in_4_5  = 32'h2D2D_2D2D;
    WBUF_data_in_4_6  = 32'hD2D2_D2D2;
    WBUF_data_in_4_7  = 32'h3C3C_3C3C;
    WBUF_data_in_4_8  = 32'hC3C3_C3C3;
    WBUF_data_in_4_9  = 32'h4B4B_4B4B;
    WBUF_data_in_4_10 = 32'hB4B4_B4B4;
    WBUF_data_in_4_11 = 32'h5A5A_5A5A;
    WBUF_data_in_4_12 = 32'hA5A5_A5A5;
    WBUF_data_in_4_13 = 32'h6969_6969;
    WBUF_data_in_4_14 = 32'h9696_9696;
    WBUF_data_in_4_15 = 32'h7878_7878;
    WBUF_data_in_4_16 = 32'h8787_8787;

    // Row 5
    WBUF_data_in_5_1  = 32'h0123_89AB;
    WBUF_data_in_5_2  = 32'h4567_CDEF;
    WBUF_data_in_5_3  = 32'h89AB_0123;
    WBUF_data_in_5_4  = 32'hCDEF_4567;
    WBUF_data_in_5_5  = 32'hFEDC_BA98;
    WBUF_data_in_5_6  = 32'h7654_3210;
    WBUF_data_in_5_7  = 32'h89AB_CDEF;
    WBUF_data_in_5_8  = 32'h0123_4567;
    WBUF_data_in_5_9  = 32'hCDEF_89AB;
    WBUF_data_in_5_10 = 32'h4567_0123;
    WBUF_data_in_5_11 = 32'hBA98_FEDC;
    WBUF_data_in_5_12 = 32'h3210_7654;
    WBUF_data_in_5_13 = 32'hFEDC_BA98;
    WBUF_data_in_5_14 = 32'h3210_4567;
    WBUF_data_in_5_15 = 32'h89AB_CDEF;
    WBUF_data_in_5_16 = 32'h0123_FEDC;

    // Row 6
    WBUF_data_in_6_1  = 32'h000F_0F00;
    WBUF_data_in_6_2  = 32'h0F00_000F;
    WBUF_data_in_6_3  = 32'h00F0_F000;
    WBUF_data_in_6_4  = 32'hF000_00F0;
    WBUF_data_in_6_5  = 32'h0FF0_F000;
    WBUF_data_in_6_6  = 32'hF000_0FF0;
    WBUF_data_in_6_7  = 32'h00FF_F000;
    WBUF_data_in_6_8  = 32'hF000_00FF;
    WBUF_data_in_6_9  = 32'h000F_FF00;
    WBUF_data_in_6_10 = 32'hFF00_000F;
    WBUF_data_in_6_11 = 32'h0F0F_00F0;
    WBUF_data_in_6_12 = 32'h00F0_0F0F;
    WBUF_data_in_6_13 = 32'hF0F0_000F;
    WBUF_data_in_6_14 = 32'h000F_F0F0;
    WBUF_data_in_6_15 = 32'h0F00_F00F;
    WBUF_data_in_6_16 = 32'hF00F_0F00;

    // Row 7
    WBUF_data_in_7_1  = 32'hA1B2_C3D4;
    WBUF_data_in_7_2  = 32'hE5F6_0718;
    WBUF_data_in_7_3  = 32'h192A_3B4C;
    WBUF_data_in_7_4  = 32'h5D6E_7F80;
    WBUF_data_in_7_5  = 32'h9081_6273;
    WBUF_data_in_7_6  = 32'h4554_6372;
    WBUF_data_in_7_7  = 32'h9182_7364;
    WBUF_data_in_7_8  = 32'hA3B4_C5D6;
    WBUF_data_in_7_9  = 32'hE6F7_1829;
    WBUF_data_in_7_10 = 32'h2A3B_4C5D;
    WBUF_data_in_7_11 = 32'h6E7F_8091;
    WBUF_data_in_7_12 = 32'h8273_6455;
    WBUF_data_in_7_13 = 32'h5463_7219;
    WBUF_data_in_7_14 = 32'h1829_3A4B;
    WBUF_data_in_7_15 = 32'h4C5D_6E7F;
    WBUF_data_in_7_16 = 32'h8091_A2B3;

    // Row 8
    WBUF_data_in_8_1  = 32'h1020_3040;
    WBUF_data_in_8_2  = 32'h5060_7080;
    WBUF_data_in_8_3  = 32'h90A0_C0E0;
    WBUF_data_in_8_4  = 32'hF010_2131;
    WBUF_data_in_8_5  = 32'h4254_6372;
    WBUF_data_in_8_6  = 32'h8491_A273;
    WBUF_data_in_8_7  = 32'hB394_C5A6;
    WBUF_data_in_8_8  = 32'hD7E8_F9A0;
    WBUF_data_in_8_9  = 32'h1B2C_3D4E;
    WBUF_data_in_8_10 = 32'h5F6A_7B8C;
    WBUF_data_in_8_11 = 32'h9D0E_AF1B;
    WBUF_data_in_8_12 = 32'h2C3D_4E5F;
    WBUF_data_in_8_13 = 32'h6A7B_8C9D;
    WBUF_data_in_8_14 = 32'h0EAF_1B2C;
    WBUF_data_in_8_15 = 32'h3D4E_5F6A;
    WBUF_data_in_8_16 = 32'h7B8C_9D0E;

    // Row 9
    WBUF_data_in_9_1  = 32'h1110_2220;
    WBUF_data_in_9_2  = 32'h3330_4440;
    WBUF_data_in_9_3  = 32'h5550_6660;
    WBUF_data_in_9_4  = 32'h7770_8880;
    WBUF_data_in_9_5  = 32'h9990_AAA0;
    WBUF_data_in_9_6  = 32'hBBB0_CCC0;
    WBUF_data_in_9_7  = 32'hDDD0_EEE0;
    WBUF_data_in_9_8  = 32'hFFF0_0001;
    WBUF_data_in_9_9  = 32'h1112_3334;
    WBUF_data_in_9_10 = 32'h5556_7778;
    WBUF_data_in_9_11 = 32'h999A_BBCC;
    WBUF_data_in_9_12 = 32'hDDEE_FF00;
    WBUF_data_in_9_13 = 32'h1122_3344;
    WBUF_data_in_9_14 = 32'h5566_7788;
    WBUF_data_in_9_15 = 32'h99AA_BBCC;
    WBUF_data_in_9_16 = 32'hDDEE_FF11;

    // Row 10
    WBUF_data_in_10_1  = 32'h0A0B_0C0D;
    WBUF_data_in_10_2  = 32'h0E0F_1011;
    WBUF_data_in_10_3  = 32'h1213_1415;
    WBUF_data_in_10_4  = 32'h1617_1819;
    WBUF_data_in_10_5  = 32'h1A1B_1C1D;
    WBUF_data_in_10_6  = 32'h1E1F_2021;
    WBUF_data_in_10_7  = 32'h2223_2425;
    WBUF_data_in_10_8  = 32'h2627_2829;
    WBUF_data_in_10_9  = 32'h2A2B_2C2D;
    WBUF_data_in_10_10 = 32'h2E2F_3031;
    WBUF_data_in_10_11 = 32'h3233_3435;
    WBUF_data_in_10_12 = 32'h3637_3839;
    WBUF_data_in_10_13 = 32'h3A3B_3C3D;
    WBUF_data_in_10_14 = 32'h3E3F_4041;
    WBUF_data_in_10_15 = 32'h4243_4445;
    WBUF_data_in_10_16 = 32'h4647_4849;

    // Row 11
    WBUF_data_in_11_1  = 32'hABC0_DEF1;
    WBUF_data_in_11_2  = 32'hABC2_DEF3;
    WBUF_data_in_11_3  = 32'hABC4_DEF5;
    WBUF_data_in_11_4  = 32'hABC6_DEF7;
    WBUF_data_in_11_5  = 32'hABC8_DEF9;
    WBUF_data_in_11_6  = 32'hABCA_DEFB;
    WBUF_data_in_11_7  = 32'hABCC_DEFD;
    WBUF_data_in_11_8  = 32'hABCE_DEFF;
    WBUF_data_in_11_9  = 32'hABD0_DE01;
    WBUF_data_in_11_10 = 32'hABD2_DE03;
    WBUF_data_in_11_11 = 32'hABD4_DE05;
    WBUF_data_in_11_12 = 32'hABD6_DE07;
    WBUF_data_in_11_13 = 32'hABD8_DE09;
    WBUF_data_in_11_14 = 32'hABDA_DE0B;
    WBUF_data_in_11_15 = 32'hABDC_DE0D;
    WBUF_data_in_11_16 = 32'hABDE_DE0F;

    // Row 12
    WBUF_data_in_12_1  = 32'h456F_1230;
    WBUF_data_in_12_2  = 32'h456F_1231;
    WBUF_data_in_12_3  = 32'h456F_1232;
    WBUF_data_in_12_4  = 32'h456F_1233;
    WBUF_data_in_12_5  = 32'h456F_1234;
    WBUF_data_in_12_6  = 32'h456F_1235;
    WBUF_data_in_12_7  = 32'h456F_1236;
    WBUF_data_in_12_8  = 32'h456F_1237;
    WBUF_data_in_12_9  = 32'h456F_1238;
    WBUF_data_in_12_10 = 32'h456F_1239;
    WBUF_data_in_12_11 = 32'h456F_123A;
    WBUF_data_in_12_12 = 32'h456F_123B;
    WBUF_data_in_12_13 = 32'h456F_123C;
    WBUF_data_in_12_14 = 32'h456F_123D;
    WBUF_data_in_12_15 = 32'h456F_123E;
    WBUF_data_in_12_16 = 32'h456F_123F;

    // Row 13
    WBUF_data_in_13_1  = 32'hABAB_CDC0;
    WBUF_data_in_13_2  = 32'hABAB_CDC1;
    WBUF_data_in_13_3  = 32'hABAB_CDC2;
    WBUF_data_in_13_4  = 32'hABAB_CDC3;
    WBUF_data_in_13_5  = 32'hABAB_CDC4;
    WBUF_data_in_13_6  = 32'hABAB_CDC5;
    WBUF_data_in_13_7  = 32'hABAB_CDC6;
    WBUF_data_in_13_8  = 32'hABAB_CDC7;
    WBUF_data_in_13_9  = 32'hABAB_CDC8;
    WBUF_data_in_13_10 = 32'hABAB_CDC9;
    WBUF_data_in_13_11 = 32'hABAB_CDCA;
    WBUF_data_in_13_12 = 32'hABAB_CDCB;
    WBUF_data_in_13_13 = 32'hABAB_CDCC;
    WBUF_data_in_13_14 = 32'hABAB_CDCD;
    WBUF_data_in_13_15 = 32'hABAB_CDCE;
    WBUF_data_in_13_16 = 32'hABAB_CDCF;

    // Row 14
    WBUF_data_in_14_1  = 32'h0001_0002;
    WBUF_data_in_14_2  = 32'h0003_0004;
    WBUF_data_in_14_3  = 32'h0005_0006;
    WBUF_data_in_14_4  = 32'h0007_0008;
    WBUF_data_in_14_5  = 32'h0009_000A;
    WBUF_data_in_14_6  = 32'h000B_000C;
    WBUF_data_in_14_7  = 32'h000D_000E;
    WBUF_data_in_14_8  = 32'h000F_0010;
    WBUF_data_in_14_9  = 32'h0011_0012;
    WBUF_data_in_14_10 = 32'h0013_0014;
    WBUF_data_in_14_11 = 32'h0015_0016;
    WBUF_data_in_14_12 = 32'h0017_0018;
    WBUF_data_in_14_13 = 32'h0019_001A;
    WBUF_data_in_14_14 = 32'h001B_001C;
    WBUF_data_in_14_15 = 32'h001D_001E;
    WBUF_data_in_14_16 = 32'h001F_0020;

    // Row 15
    WBUF_data_in_15_1  = 32'hFACE_CAFE;
    WBUF_data_in_15_2  = 32'hDEAD_BEEF;
    WBUF_data_in_15_3  = 32'hC0DE_C0DE;
    WBUF_data_in_15_4  = 32'hFEED_FACE;
    WBUF_data_in_15_5  = 32'hBABE_FACE;
    WBUF_data_in_15_6  = 32'hFEED_BEEF;
    WBUF_data_in_15_7  = 32'hDEAD_FACE;
    WBUF_data_in_15_8  = 32'hC0DE_BEEF;
    WBUF_data_in_15_9  = 32'hBABE_CAFE;
    WBUF_data_in_15_10 = 32'hFEED_BABE;
    WBUF_data_in_15_11 = 32'hDEAD_BABE;
    WBUF_data_in_15_12 = 32'hC0DE_FACE;
    WBUF_data_in_15_13 = 32'hBABE_BEEF;
    WBUF_data_in_15_14 = 32'hFEED_C0DE;
    WBUF_data_in_15_15 = 32'hDEAD_FEED;
    WBUF_data_in_15_16 = 32'hC0DE_BABE;

    // Row 16
    WBUF_data_in_16_1  = 32'h0000_00FF;
    WBUF_data_in_16_2  = 32'h0000_FF00;
    WBUF_data_in_16_3  = 32'h00FF_0000;
    WBUF_data_in_16_4  = 32'hFF00_0000;
    WBUF_data_in_16_5  = 32'h0F0F_0F0F;
    WBUF_data_in_16_6  = 32'hF0F0_F0F0;
    WBUF_data_in_16_7  = 32'h00FF_FF00;
    WBUF_data_in_16_8  = 32'hFF00_00FF;
    WBUF_data_in_16_9  = 32'h1234_4321;
    WBUF_data_in_16_10 = 32'hABCD_DCBA;
    WBUF_data_in_16_11 = 32'h5678_8765;
    WBUF_data_in_16_12 = 32'h9ABC_CBA9;
    WBUF_data_in_16_13 = 32'h000F_F00F;
    WBUF_data_in_16_14 = 32'hF00F_000F;
    WBUF_data_in_16_15 = 32'h00F0_0FF0;
    WBUF_data_in_16_16 = 32'h0FF0_00F0;

    // … etc …

    #50;  // wait a few cycles

    // 5) Finish simulation
    $display("Simulation complete.");
    #10;
    $finish;
  end

endmodule
