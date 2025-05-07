`include "bitbrick.v"
`timescale 1ns / 1ps

module tb_bitbrick;

    // Declare inputs as regs and outputs as wires
    reg clk;
    reg reset;
    reg [1:0] x;
    reg [1:0] y;
    reg sign_x;
    reg sign_y;
    wire [5:0] p;

    // Instantiate the bitbrick module
    bitbrick uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y),
        .sign_x(sign_x),
        .sign_y(sign_y),
        .p(p)
    );

    // Generate clock signal
    always begin
        #5 clk = ~clk;  // 100 MHz clock
    end

    // Initialize the test
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        x = 2'b00; // Set to zero
        y = 2'b00; // Set to zero
        sign_x = 0;
        sign_y = 0;

        // Reset the module
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Test case 1: x = 2'b00, y = 2'b00 (Product should be 0)
        x = 2'b00; y = 2'b00;
        #10;

        // Test case 2: x = 2'b01, y = 2'b00 (Product should be 0)
        x = 2'b01; y = 2'b00;
        #10;

        // Test case 3: x = 2'b00, y = 2'b01 (Product should be 0)
        x = 2'b00; y = 2'b01;
        #10;

        // Test case 4: x = 2'b01, y = 2'b01 (Product should be 1)
        x = 2'b01; y = 2'b01;
        #10;

        // Test case 5: x = 2'b10, y = 2'b11 (Product should be -6)
        sign_x = 1;
        x = 2'b10; y = 2'b11;
        #10;

        // Test case 6: x = 2'b11, y = 2'b11 (Product should be 9)
        sign_x = 0;
        x = 2'b11; y = 2'b11;
        #10;

        // Test case 7: x = 2'b11, y = 2'b10 (Product should be -6)
        sign_y = 1;
        x = 2'b11; y = 2'b10;
        #10;

        // Test case 8: x = 2'b11, y = 2'b11 (Product should be 1)
        sign_x = 1;
        sign_y = 1;
        x = 2'b11; y = 2'b11;
        #10;

        // Finish simulation
        $finish;
    end

    // Generate the VCD file for GTKWave visualization
    initial begin
        $dumpfile("tb_bitbrick.vcd");  // Specify the VCD file name
        $dumpvars(0, tb_bitbrick);     // Dump all signals
    end

endmodule
