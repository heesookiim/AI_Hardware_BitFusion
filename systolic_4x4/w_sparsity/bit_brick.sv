module bit_brick (
    input logic [1:0] x, y,
    input logic sx, sy,
    output logic [5:0] product
);

    logic signed [2:0] signed_x, signed_y;

    assign signed_x = {x[1] && sx, x};
    assign signed_y = {y[1] && sy, y};

    always_comb begin
        if (x == 2'b00 || y == 2'b00) begin
            product = '0;
        end
        else begin
            product = signed_x * signed_y;
        end       
    end
   
endmodule