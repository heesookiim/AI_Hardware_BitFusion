module w_mux (
    input logic clk, nRST,
    input logic [2:0] input_bitwidth, // 001 - 2bits, 010 - 4bits, 100 - 8bits
    input logic rd_en,
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    logic [31:0] next_data_out;
    logic [1:0] rd_ptr, next_rd_ptr;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
        if (!nRST) begin
            data_out <= '0;
            rd_ptr   <= '0;
        end

        else begin
            data_out <= next_data_out;
            rd_ptr   <= next_rd_ptr;
        end
    end

    always_comb begin : NEXT_RD_PTR_LOGIC
        next_rd_ptr = rd_ptr;

        if (rd_en == 1'b1) begin
            next_rd_ptr = rd_ptr + 1;
            
            case (input_bitwidth)
                {3'b100}: begin         // 8b x 8b, read 8bits 4 times
                    if (rd_ptr == 2'd3) begin
                        next_rd_ptr = 2'd0;
                        end
                    end

                {3'b010}: begin         // 8b x 4b, read 16bits 2 times
                    if (rd_ptr == 2'd1) begin
                            next_rd_ptr = 2'd0;
                    end
                end

                {3'b001}: begin         // 8b x 2b, read 32bits 1 time 
                    next_rd_ptr = 2'd0;
                end
            endcase
        end
    end

    always_comb begin : NEXT_DATA_OUT_LOGIC
        next_data_out = data_out;
        
        if (rd_en == 1'b1) begin
            case (input_bitwidth)
                {3'b100}: begin
                    case (rd_ptr)
                        {2'd0}: next_data_out = {4{data_in[7:0]}};
                        {2'd1}: next_data_out = {4{data_in[15:8]}};
                        {2'd2}: next_data_out = {4{data_in[23:16]}};
                        {2'd3}: next_data_out = {4{data_in[31:24]}};
                    endcase
                end

                {3'b010}: begin
                    case (rd_ptr)
                        {2'd0}: next_data_out = {{2{data_in[15:8]}}, {2{data_in[7:0]}}};
                        {2'd1}: next_data_out = {{2{data_in[31:24]}}, {2{data_in[23:16]}}};
                    endcase
                end

                {3'b001}: begin
                    next_data_out = data_in;
                end
            endcase
        end
    end
    
endmodule