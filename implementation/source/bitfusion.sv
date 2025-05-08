module bitfusion #(
    parameter ARRAY_SIZE = 4, DATA_W = 32
)(
    input logic clk, nRST,
    input logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] IBUF,
    input logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][DATA_W - 1:0] WBUF,
    input logic [ARRAY_SIZE - 1:0] input_rd_en, acc_clear,
    input logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0] weight_rd_en,
    input logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][3:0] input_sign,
    input logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][3:0] weight_sign,
    input logic [2:0] input_bitwidth, weight_bitwidth,
    output logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] OBUF
);

    // input forward registers. rows = ARRAY_SIZE, columns = ARRAY_SIZE - 1
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 2:0][DATA_W - 1:0] input_forward_reg, next_input_forward_reg;
    always_ff @(posedge clk, negedge nRST) begin : INPUT_FORWARD_REG_LOGIC
        if (!nRST) begin
            input_forward_reg <= '0;
        end
        else begin
            input_forward_reg <= next_input_forward_reg;
        end
    end
    assign next_input_forward_reg = input_forward_reg;

    // partial sum registers
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][DATA_W - 1:0] psums, next_psums;
    //    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][DATA_W - 1:0] psums_in;
    //    assign psums_in[0] = '0;   //1st row of psum in is always zero
    always_ff @(posedge clk, negedge nRST) begin : PSUM_REG_LOGIC
        if (!nRST) begin
            psums <= '0;
        end
        else begin
            psums <= next_psums;
        end
    end
    assign next_psums = psums;

    // input and weight mux outs
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][DATA_W - 1:0] weight_mux_outs;
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] input_mux_outs;
    

    genvar i, j, k;
    generate
        for (i = 0; i < ARRAY_SIZE; i = i + 1) begin
            for (j = 0; j < ARRAY_SIZE; j = j + 1) begin

                // instantiate weight mux registers    
                w_mux wmux (
                    .clk(clk), .nRST(nRST),
                    .rd_en(weight_rd_en[i][j]), .input_bitwidth(input_bitwidth),
                    .data_in(WBUF[i][j]), .data_out(weight_mux_outs[i][j])
                );

                // for each row
                if (j % ARRAY_SIZE == 0) begin
                    // for each row instantiate an input mux register
                    in_mux imux (
                        .clk(clk), .nRST(nRST),
                        .rd_en(input_rd_en[i]), .weight_bitwidth(weight_bitwidth),
                        .data_in(IBUF[i]), .data_out(input_mux_outs[i])
                    );
                    // for each row connect 1st column fusion unit to input mux reg
                    if (i == 0) begin
                        fusion_unit fu (
                        .clk(clk), .nRST(nRST),
                        .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                        .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                        .input_forward(input_mux_outs[i]), .weight(weight_mux_outs[i][j]),
                        .psum_in(32'h0), .psum(next_psums[i][j]), .input_to_right(next_input_forward_reg[i][j])
                    );
                    end
                    else begin
                        fusion_unit fu (
                            .clk(clk), .nRST(nRST),
                            .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                            .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                            .input_forward(input_mux_outs[i]), .weight(weight_mux_outs[i][j]),
                            .psum_in(psums[i-1][j]), .psum(next_psums[i][j]), .input_to_right(next_input_forward_reg[i][j])
                        );
                    end
                end
                else if (j % ARRAY_SIZE == ARRAY_SIZE - 1) begin
                    if (i == 0) begin
                        fusion_unit fu (
                            .clk(clk), .nRST(nRST),
                            .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                            .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                            .input_forward(input_forward_reg[i][j - 1]), .weight(weight_mux_outs[i][j]),
                            .psum_in(32'h0), .psum(next_psums[i][j]), .input_to_right()
                    );
                    end
                    else begin
                        fusion_unit fu (
                            .clk(clk), .nRST(nRST),
                            .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                            .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                            .input_forward(input_forward_reg[i][j - 1]), .weight(weight_mux_outs[i][j]),
                            .psum_in(psums[i-1][j]), .psum(next_psums[i][j]), .input_to_right()
                        );
                    end
                end
                else begin
                    if (i == 0) begin
                        fusion_unit fu (
                        .clk(clk), .nRST(nRST),
                        .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                        .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                        .input_forward(input_forward_reg[i][j - 1]), .weight(weight_mux_outs[i][j]),
                        .psum_in(32'h0), .psum(next_psums[i][j]), .input_to_right(next_input_forward_reg[i][j])
                    );
                    end
                    fusion_unit fu (
                        .clk(clk), .nRST(nRST),
                        .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
                        .input_sign(input_sign[i][j]), .weight_sign(weight_sign[i][j]),
                        .input_forward(input_forward_reg[i][j - 1]), .weight(weight_mux_outs[i][j]),
                        .psum_in(psums[i-1][j]), .psum(next_psums[i][j]), .input_to_right(next_input_forward_reg[i][j])
                    );
                end                   
            end
        end
    endgenerate

    // instantiate accumulator for each columnn
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] acc_sums;
    generate
        for (k = 0; k < ARRAY_SIZE; k = k + 1) begin
            accumulator acc (
                .clk(clk), .nRST(nRST), .clear(acc_clear[k]),
                .psum(psums[ARRAY_SIZE - 1][k]), .acc_sum(acc_sums[k])
            );
        end
    endgenerate

    // OBUF is just accumulated sums for now
    assign OBUF = acc_sums;
    
endmodule