module bit_brick (
    input logic [1:0] x, y,
    input logic sx, sy,
    output logic signed [5:0] product
);

    logic signed [2:0] signed_x, signed_y;

    assign signed_x = x[1] && sx;
    assign signed_y = y[1] && sy;

    assign product = signed_x * signed_y;
endmodule