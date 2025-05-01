module fusion_unit (
    input logic clk, nRST,
    input logic [2:0] input_bitwidth, weight_bitwidth,
    input logic [31:0] input_forward,
    input logic [31:0] weight,
    output logic [31:0] psum,
    output logic [31:0] input_to_right
);

    logic signed [5:0][15:0] products;  
    
    // Instantiate 16 BitBricks   
    genvar i;
    generate
      for (i = 0; i < 16; i = i + 1) begin : gen_PE_bricks
        // 2-bit lanes of x and y
        bitbrick BB (
          .x(input_forward[2*i+1:2*i]),
          .y(weight[2*i+1:2*i]),
          .sx(sign_x[i/4]),
          .sy(sign_y[i%4]),
          .products(products[i])
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

    always_ff @(posedge clk, negedge nRST) begin : PSUM_REGISTER
        if (!nRST) begin
            psum <= '0;
        end
        else begin
            psum <= shift_add_out;
        end
    end
endmodule