module shift_add (
    input logic [2:0] input_bitwidth, weight_bitwidth, // 001 - 2bits, 010 - 4bits, 100 - 8bits
    input logic signed [5:0][15:0] products,
    output logic signed [31:0] shift_add_out
);
    
    integer row, col, i;
    always_comb begin
        for (row = 0; row < 4; row++) begin
            for (col = 0; col < 4; col++) begin
                if (row < input_bitwidth && col < weight_bitwidth) begin
                    i = row * 4 + col;
                    shift_add_out = shift_add_out + products[i] <<< (row * 2 + col * 2);
                end
            end
        end
    end
    
endmodule