//`include "bit_brick.sv"
//`include "shift_add.sv"

module fusion_unit (
    input logic clk, nRST,
    input logic [2:0] input_bitwidth, weight_bitwidth,
    input logic [3:0] input_sign, weight_sign,
    input logic [31:0] input_forward, weight,
    input logic [31:0] psum_in,
    output logic [31:0] psum, input_to_right
);

    // Bitbricks signals
    logic signed [15:0][5:0] products;  
    
    // Instantiate 16 BitBricks   
    genvar i;
    generate
      for (i = 0; i < 16; i++) begin
        // 2 bits of x and y
        bit_brick BB (
          .x(input_forward[2*i+1:2*i]),
          .y(weight[2*i+1:2*i]),
          .sx(input_sign[i/4]),
          .sy(weight_sign[i%4]),
          // .sx(1'b0),
          // .sy(1'b0),
          .product(products[i])
        );
      end
    endgenerate

    // Instantiate shift add logic
    logic signed [31:0] shift_add_out;
    shift_add shift_add (
        .input_bitwidth(input_bitwidth),
        .weight_bitwidth(weight_bitwidth),
        .products(products),
        .shift_add_out(shift_add_out)
    );

    // psum(down) register
//    always_ff @(posedge clk, negedge nRST) begin : OUTPUT_REGISTERS
//         if (!nRST) begin
//             psum <= '0;
//         end
//         else begin
//             psum <= shift_add_out;
//         end
//     end

    // outputs
    assign psum = $signed(shift_add_out) + $signed(psum_in);
    assign input_to_right = input_forward;
endmodule