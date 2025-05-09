module IBUF #(
    parameter ARRAY_SIZE = 4, DATA_W = 32
) (
    input logic clk, nRST,
    input logic IBUF_wr_en,
    input logic [DATA_W - 1:0] IBUF_data_in,
    output logic [DATA_W - 1:0] IBUF_data_out
);

    //logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] next_BUF_data_out;
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] IBUF_reg_out, next_IBUF_reg_out;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
         if (!nRST) begin
            IBUF_reg_out <= '0;
        end
        else begin
            IBUF_reg_out <= next_IBUF_reg_out;
        end
    end

    logic zero_sel;
    assign zero_sel = (IBUF_data_in == 32'h0) ? 1 : 0;

    integer i;
    always_comb begin : NEXT_LOGIC
        next_IBUF_reg_out = IBUF_reg_out;
        
        if ((IBUF_wr_en == 1'b1) && !zero_sel) begin
                next_IBUF_reg_out = IBUF_data_in;
        end
    end

    assign IBUF_data_out = (zero_sel == 1'b1) ? 32'h0 : IBUF_reg_out;        
endmodule