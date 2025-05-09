module IBUF #(
    parameter ARRAY_SIZE = 4, DATA_W = 32
) (
    input logic clk, nRST,
    input logic IBUF_wr_en,
    input logic [DATA_W - 1:0] IBUF_data_in,
    output logic [DATA_W - 1:0] IBUF_data_out
);

    logic [DATA_W - 1:0] next_IBUF_data_out;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
         if (!nRST) begin
            IBUF_data_out <= '0;
        end
        else begin
            IBUF_data_out <= next_IBUF_data_out;
        end
    end

    integer i;
    always_comb begin : NEXT_LOGIC
        next_IBUF_data_out = IBUF_data_out;
        
        if (IBUF_wr_en == 1'b1) begin 
            next_IBUF_data_out = IBUF_data_in;
        end      
    end    
endmodule