`timescale 1ns / 1ps

// Processing Element Adder Module
// - Takes 16 partial products (16-bit signed)
// - Extends to 20-bit signed values
// - Computes their sum along with a previous sum (accumulation)

module PE_adder(
    input [15:0] p_shift_0, p_shift_1, p_shift_2, p_shift_3,
    input [15:0] p_shift_4, p_shift_5, p_shift_6, p_shift_7,
    input [15:0] p_shift_8, p_shift_9, p_shift_10, p_shift_11,
    input [15:0] p_shift_12, p_shift_13, p_shift_14, p_shift_15,
    input [19:0] previous_sum,
    
    output [19:0] PE_sum
);

    // Sign-extend each 16-bit product to 20 bits
    wire [19:0] p_shift_extend [15:0];

    assign p_shift_extend[0]  = {{4{p_shift_0[15]}},  p_shift_0};
    assign p_shift_extend[1]  = {{4{p_shift_1[15]}},  p_shift_1};
    assign p_shift_extend[2]  = {{4{p_shift_2[15]}},  p_shift_2};
    assign p_shift_extend[3]  = {{4{p_shift_3[15]}},  p_shift_3};
    assign p_shift_extend[4]  = {{4{p_shift_4[15]}},  p_shift_4};
    assign p_shift_extend[5]  = {{4{p_shift_5[15]}},  p_shift_5};
    assign p_shift_extend[6]  = {{4{p_shift_6[15]}},  p_shift_6};
    assign p_shift_extend[7]  = {{4{p_shift_7[15]}},  p_shift_7};
    assign p_shift_extend[8]  = {{4{p_shift_8[15]}},  p_shift_8};
    assign p_shift_extend[9]  = {{4{p_shift_9[15]}},  p_shift_9};
    assign p_shift_extend[10] = {{4{p_shift_10[15]}}, p_shift_10};
    assign p_shift_extend[11] = {{4{p_shift_11[15]}}, p_shift_11};
    assign p_shift_extend[12] = {{4{p_shift_12[15]}}, p_shift_12};
    assign p_shift_extend[13] = {{4{p_shift_13[15]}}, p_shift_13};
    assign p_shift_extend[14] = {{4{p_shift_14[15]}}, p_shift_14};
    assign p_shift_extend[15] = {{4{p_shift_15[15]}}, p_shift_15};

    // Hierarchical summation of all extended partial products
    wire [19:0] adder_1 = p_shift_extend[0]  + p_shift_extend[1]  + p_shift_extend[2]  + p_shift_extend[3];
    wire [19:0] adder_2 = p_shift_extend[4]  + p_shift_extend[5]  + p_shift_extend[6]  + p_shift_extend[7];
    wire [19:0] adder_3 = p_shift_extend[8]  + p_shift_extend[9]  + p_shift_extend[10] + p_shift_extend[11];
    wire [19:0] adder_4 = p_shift_extend[12] + p_shift_extend[13] + p_shift_extend[14] + p_shift_extend[15];

    // Final PE output sum with accumulation
    assign PE_sum = adder_1 + adder_2 + adder_3 + adder_4 + previous_sum;

endmodule
