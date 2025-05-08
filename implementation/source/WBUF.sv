module WBUF #(
    parameter ARRAY_SIZE = 4, DATA_W = 32
) (
    input logic clk, nRST,
    input logic WBUF_wr_en,
    input logic [DATA_W - 1:0] WBUF_data_in,
    output logic [DATA_W - 1:0] WBUF_data_out
);

    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] next_WBUF_data_out;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
         if (!nRST) begin
            WBUF_data_out <= '0;
        end
        else begin
            WBUF_data_out <= next_WBUF_data_out;
        end
    end

    integer i, j;
    always_comb begin : NEXT_LOGIC
        next_WBUF_data_out = WBUF_data_out;
        
        if (WBUF_wr_en == 1'b1) begin 
            next_WBUF_data_out = WBUF_data_in;
        end        
    end    
endmodule