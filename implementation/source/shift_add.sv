module shift_add (
    input logic [2:0] input_bitwidth, weight_bitwidth, // 001 - 2bits, 010 - 4bits, 100 - 8bits
    input logic signed [15:0][5:0] products,
    output logic signed [31:0] shift_add_out
);
    
    // integer row, col, i, j;
    // always_comb begin
    //     for (row = 0; row < 4; row++) begin
    //         for (col = 0; col < 4; col++) begin
    //             if (row < input_bitwidth && col < weight_bitwidth) begin
    //                     i = row * 4 + col;
    //                     shift_add_out = shift_add_out + products[i] <<< (row * 2 + col * 2);
    //             end
    //         end
    //     end
    // end

    logic signed [15:0][20:0] shifted_products;
    
    always_comb begin : SHIFT        
        case ({input_bitwidth, weight_bitwidth})
            {3'b100, 3'b100}: begin     // 8-bit input, 8-bit weight
                shifted_products[0] = $signed(products[0]) <<< 0;
                shifted_products[1] = $signed(products[1]) <<< 2;
                shifted_products[2] = $signed(products[2]) <<< 4;
                shifted_products[3] = $signed(products[3]) <<< 6;
                shifted_products[4] = $signed(products[4]) <<< 2;
                shifted_products[5] = $signed(products[5]) <<< 4;
                shifted_products[6] = $signed(products[6]) <<< 6;
                shifted_products[7] = $signed(products[7]) <<< 8;
                shifted_products[8] = $signed(products[8]) <<< 4;
                shifted_products[9] = $signed(products[9]) <<< 6;
                shifted_products[10] = $signed(products[10]) <<< 8;
                shifted_products[11] = $signed(products[11]) <<< 10;
                shifted_products[12] = $signed(products[12]) <<< 6;
                shifted_products[13] = $signed(products[13]) <<< 8;
                shifted_products[14] = $signed(products[14]) <<< 10;
                shifted_products[15] = $signed(products[15]) <<< 12;
            end 

            {3'b100, 3'b010}: begin    // 8-bit input, 4-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 2;
                shifted_products[2] = products[2] <<< 0;
                shifted_products[3] = products[3] <<< 2;
                shifted_products[4] = products[4] <<< 2;
                shifted_products[5] = products[5] <<< 4;
                shifted_products[6] = products[6] <<< 2;
                shifted_products[7] = products[7] <<< 4;
                shifted_products[8] = products[8] <<< 4;
                shifted_products[9] = products[9] <<< 6;
                shifted_products[10] = products[10] <<< 4;
                shifted_products[11] = products[11] <<< 6;
                shifted_products[12] = products[12] <<< 6;
                shifted_products[13] = products[13] <<< 8;
                shifted_products[14] = products[14] <<< 6;
                shifted_products[15] = products[15] <<< 8;
            end 

            {3'b100, 3'b001}: begin    // 8-bit input, 2-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 0;
                shifted_products[2] = products[2] <<< 0;
                shifted_products[3] = products[3] <<< 0;
                shifted_products[4] = products[4] <<< 2;
                shifted_products[5] = products[5] <<< 2;
                shifted_products[6] = products[6] <<< 2;
                shifted_products[7] = products[7] <<< 2;
                shifted_products[8] = products[8] <<< 4;
                shifted_products[9] = products[9] <<< 4;
                shifted_products[10] = products[10] <<< 4;
                shifted_products[11] = products[11] <<< 4;
                shifted_products[12] = products[12] <<< 6;
                shifted_products[13] = products[13] <<< 6;
                shifted_products[14] = products[14] <<< 6;
                shifted_products[15] = products[15] <<< 6;
            end

            {3'b010, 3'b100}: begin    // 4-bit input, 8-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 2;
                shifted_products[2] = products[2] <<< 4;
                shifted_products[3] = products[3] <<< 6;
                shifted_products[4] = products[4] <<< 2;
                shifted_products[5] = products[5] <<< 4;
                shifted_products[6] = products[6] <<< 6;
                shifted_products[7] = products[7] <<< 8;
                shifted_products[8] = products[8] <<< 0;
                shifted_products[9] = products[9] <<< 2;
                shifted_products[10] = products[10] <<< 4;
                shifted_products[11] = products[11] <<< 6;
                shifted_products[12] = products[12] <<< 2;
                shifted_products[13] = products[13] <<< 4;
                shifted_products[14] = products[14] <<< 6;
                shifted_products[15] = products[15] <<< 8;
            end

            {3'b010, 3'b010}: begin    // 4-bit input, 4-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 2;
                shifted_products[2] = products[2] <<< 0;
                shifted_products[3] = products[3] <<< 2;
                shifted_products[4] = products[4] <<< 2;
                shifted_products[5] = products[5] <<< 4;
                shifted_products[6] = products[6] <<< 2;
                shifted_products[7] = products[7] <<< 4;
                shifted_products[8] = products[8] <<< 0;
                shifted_products[9] = products[9] <<< 2;
                shifted_products[10] = products[10] <<< 0;
                shifted_products[11] = products[11] <<< 2;
                shifted_products[12] = products[12] <<< 2;
                shifted_products[13] = products[13] <<< 4;
                shifted_products[14] = products[14] <<< 2;
                shifted_products[15] = products[15] <<< 4;
            end

            {3'b010, 3'b001}: begin    // 4-bit input, 2-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 0;
                shifted_products[2] = products[2] <<< 0;
                shifted_products[3] = products[3] <<< 0;
                shifted_products[4] = products[4] <<< 2;
                shifted_products[5] = products[5] <<< 2;
                shifted_products[6] = products[6] <<< 2;
                shifted_products[7] = products[7] <<< 2;
                shifted_products[8] = products[8] <<< 0;
                shifted_products[9] = products[9] <<< 0;
                shifted_products[10] = products[10] <<< 0;
                shifted_products[11] = products[11] <<< 0;
                shifted_products[12] = products[12] <<< 2;
                shifted_products[13] = products[13] <<< 2;
                shifted_products[14] = products[14] <<< 2;
                shifted_products[15] = products[15] <<< 2;
            end

            {3'b001, 3'b100}: begin    // 2-bit input, 8-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 2;
                shifted_products[2] = products[2] <<< 4;
                shifted_products[3] = products[3] <<< 6;
                shifted_products[4] = products[4] <<< 0;
                shifted_products[5] = products[5] <<< 2;
                shifted_products[6] = products[6] <<< 4;
                shifted_products[7] = products[7] <<< 6;
                shifted_products[8] = products[8] <<< 0;
                shifted_products[9] = products[9] <<< 2;
                shifted_products[10] = products[10] <<< 4;
                shifted_products[11] = products[11] <<< 6;
                shifted_products[12] = products[12] <<< 0;
                shifted_products[13] = products[13] <<< 2;
                shifted_products[14] = products[14] <<< 4;
                shifted_products[15] = products[15] <<< 6;
            end

            {3'b001, 3'b010}: begin    // 2-bit input, 4-bit weight
                shifted_products[0] = products[0] <<< 0;
                shifted_products[1] = products[1] <<< 2;
                shifted_products[2] = products[2] <<< 0;
                shifted_products[3] = products[3] <<< 2;
                shifted_products[4] = products[4] <<< 0;
                shifted_products[5] = products[5] <<< 2;
                shifted_products[6] = products[6] <<< 0;
                shifted_products[7] = products[7] <<< 2;
                shifted_products[8] = products[8] <<< 0;
                shifted_products[9] = products[9] <<< 2;
                shifted_products[10] = products[10] <<< 0;
                shifted_products[11] = products[11] <<< 2;
                shifted_products[12] = products[12] <<< 0;
                shifted_products[13] = products[13] <<< 2;
                shifted_products[14] = products[14] <<< 0;
                shifted_products[15] = products[15] <<< 2;
            end      
            default: shifted_products = products;   //2-bit input, 2-bit weight requires no shifting
        endcase
    end

    always_comb begin : ADD
        shift_add_out = 0;

        for (int i = 0; i < 16; i++) begin
            shift_add_out = $signed(shift_add_out) + $signed(shifted_products[i]);
        end
    end

endmodule
