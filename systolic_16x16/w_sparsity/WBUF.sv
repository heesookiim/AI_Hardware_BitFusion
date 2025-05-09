module WBUF #(
    parameter ARRAY_SIZE = 4, DATA_W = 32
) (
    input logic clk, nRST,
    input logic WBUF_wr_en,
    input logic [DATA_W - 1:0] WBUF_data_in,
    output logic [DATA_W - 1:0] WBUF_data_out
);

    //logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] next_BUF_data_out;
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] WBUF_reg_out, next_WBUF_reg_out;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
         if (!nRST) begin
            WBUF_reg_out <= '0;
        end
        else begin
            WBUF_reg_out <= next_WBUF_reg_out;
        end
    end

    logic zero_sel;
    assign zero_sel = (WBUF_data_in == 32'h0) ? 1 : 0;

    integer i;
    always_comb begin : NEXT_LOGIC
        next_WBUF_reg_out = WBUF_reg_out;
        
        if ((WBUF_wr_en == 1'b1) && !zero_sel) begin
                next_WBUF_reg_out = WBUF_data_in;
        end
    end

    assign WBUF_data_out = (zero_sel == 1'b1) ? 32'h0 : WBUF_reg_out;        
endmodule