module accumulator (
    input logic clk, nRST,
    input logic clear,
    input logic [31:0] psum,
    output logic [31:0] acc_sum
);

    logic [31:0] next_acc_sum;

    always_ff @(posedge clk, negedge nRST) begin : REG_LOGIC
        if (!nRST) begin
            acc_sum <= '0;
        end
        else begin
            acc_sum <= next_acc_sum;
        end
    end

    always_comb begin : NEXT_ACC_LOGIC
        if (clear == 1'b1) begin
            next_acc_sum = '0;
        end
        else begin
            next_acc_sum = $signed(acc_sum) + $signed(psum);
        end      
    end
    
endmodule