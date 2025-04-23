module control_unit #(
    parameter INPUT_W = 8,
              WEIGHT_W = 8,
              DATA_W = 32,
              ARRAY_SIZE = 4
)(
    input logic clk, nRST,
    // input logic [31:0] instruction,
    // output logic [31:0] instruction_addr,

    input logic [31:0] mem_data,
    output logic [31:0] mem_addr,
    output logic mem_rd_en, mem_wr_en,

    // Fusion Unit operands precision
    input logic [2:0] op0_precision, op1_precision,
    output logic [2:0] input_precision, output_precision,

    // base addresses
    input logic [9:0] input_base_addr, weight_base_addr, output_base_addr,

    output logic compute_en,

    output logic [ARRAY_SIZE - 1:0][INPUT_W - 1:0] input_forward
);

    typedef enum logic [2:0] {IDLE, SETUP, LD_WEIGHT, LD_INPUT, COMPUTE, ST_OUTPUT} state_t;
    state_t state, next_state;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
        if (!nRST) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin : COMB_LOGIC
        next_state = state;

        case (state)
            IDLE : next_state = SETUP;

            SETUP : next_state = LD_WEIGHT;

            LD_WEIGHT : begin
                if (ld_weight_done) begin
                    next_state = LD_INPUT;
                end
            end

            LD_INPUT : begin
                if (ld_input_done) begin
                    next_state = COMPUTE;
                end
            end

            COMPUTE : begin
                if (compute_done) begin
                    next_state = ST_OUTPUT;
                end
            end

            ST_OUTPUT : next_state = IDLE;
        endcase
    end

    logic [1:0] ld_weight_count, ld_input_count;
    logic [1:0] next_ld_weight_count, next_ld_input_count;
    logic ld_weight_done, ld_input_done, compute_done;

    always_ff @(posedge clk, negedge nRST) begin : LOAD_COUNTS_REG
        if (!nRST) begin
            ld_weight_count <= 2'd0;
            ld_input_count <= 2'd0;
        end

        else begin
            ld_weight_count <= next_ld_weight_count;
            ld_input_count <= next_ld_input_count;
        end
    end
    
    always_comb begin : OUTPUT_LOGIC
        compute_en = 1'b0;
        mem_rd_en = 1'b0;
        mem_wr_en = 1'b0;
        ld_input_done = 1'b0;
        ld_weight_done = 1'b0;
        next_ld_weight_count = ld_weight_count;
        next_ld_input_count = ld_input_count;

        case (state)
            SETUP : begin
                input_precision = op0_precision;
                output_precision = op1_precision;
            end

            LD_WEIGHT : begin
                next_ld_weight_count = ld_weight_count + 1;
                mem_addr = weight_base_addr + ld_weight_count;
                mem_rd_en = 1;
                if (ld_weight_count == 2'd3) begin
                    ld_weight_done = 1'b1;
                end
            end
            
            LD_INPUT : begin
                next_ld_input_count = ld_input_count + 1;
                mem_addr = input_base_addr + ld_input_count;
                mem_rd_en = 1;
                if (ld_input_count == 2'd3) begin
                    ld_input_done = 1'b1;
                end
            end

            COMPUTE : begin
                compute_en = 1;
            end

            ST_OUTPUT : begin
                mem_wr_en = 1;
            end
        endcase
    end

    // Buffer definitions
    logic [ARRAY_SIZE - 1:0][INPUT_W - 1:0] IBUF_0, IBUF_1, IBUF_2, IBUF_3;
    logic [ARRAY_SIZE - 1:0][INPUT_W - 1:0] next_IBUF_0, next_IBUF_1, next_IBUF_2, next_IBUF_3;
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] OBUF;

    always_ff @(posedge clk, negedge nRST) begin : IBUF_REG
        if (!nRST) begin
            IBUF_0 <= '0;
            IBUF_1 <= '0;
            IBUF_2 <= '0;
            IBUF_3 <= '0;
        end

        else begin
            IBUF_0 <= next_IBUF_0;
            IBUF_1 <= next_IBUF_1;
            IBUF_2 <= next_IBUF_2;
            IBUF_3 <= next_IBUF_3;
        end
    end

    // always_comb begin : IBUF_COMB
    //     next_IBUF_0 = IBUF_0;
    //     next_IBUF_1 = IBUF_1;
    //     next_IBUF_2 = IBUF_2;
    //     next_IBUF_3 = IBUF_3;

    //     if (state == LD_INPUT) begin
    //         next_IBUF_0[ld_input_count] = 8'd11; //mem_data[7:0];
    //         next_IBUF_1[ld_input_count] = 8'd11; //mem_data[15:8];
    //         next_IBUF_2[ld_input_count] = 8'd11; //mem_data[23:16];
    //         next_IBUF_3[ld_input_count] = 8'd11; //mem_data[31:24];
    //     end
    // end

    logic [7:0] mem_data_byte0, mem_data_byte1, mem_data_byte2, mem_data_byte3;

    assign mem_data_byte0 = mem_data[7:0];
    assign mem_data_byte1 = mem_data[15:8];
    assign mem_data_byte2 = mem_data[23:16];
    assign mem_data_byte3 = mem_data[31:24];

    always_comb begin : IBUF_COMB
        next_IBUF_0 = IBUF_0;
        next_IBUF_1 = IBUF_1;
        next_IBUF_2 = IBUF_2;
        next_IBUF_3 = IBUF_3;

        if (state == LD_INPUT) begin
            next_IBUF_0[ld_input_count] = mem_data_byte0;
            next_IBUF_1[ld_input_count] = mem_data_byte1;
            next_IBUF_2[ld_input_count] = mem_data_byte2;
            next_IBUF_3[ld_input_count] = mem_data_byte3;
        end
    end

    // Moving inputs to PE
    logic [9:0] compute_count, next_compute_count;

    always_ff @(posedge clk, negedge nRST) begin : COMPUTE_COUNT_REG
        if (!nRST) begin
            compute_count <= '0;
        end
        else begin
            compute_count <= next_compute_count; 
        end
    end
    
    always_comb begin : INPUT_TO_COMPUTE
        next_compute_count = compute_count;
        input_forward = '0;

        if (state == COMPUTE) begin
            next_compute_count = compute_count + 1;

            if (compute_count <= 10'd3) begin
                input_forward[0] = IBUF_0[compute_count];
            end

            if (compute_count >= 10'd1 && compute_count <= 10'd4) begin
                input_forward[1] = IBUF_1[compute_count - 1];
            end

            if (compute_count >= 10'd2 && compute_count <= 10'd5) begin
                input_forward[2] = IBUF_2[compute_count - 2];
            end

            if (compute_count >= 10'd3 && compute_count <= 10'd6) begin
                input_forward[3] = IBUF_3[compute_count - 3];
            end
        end
    end

    
endmodule