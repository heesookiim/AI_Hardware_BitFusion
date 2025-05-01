module tb_shift_add ();
    
    parameter PERIOD = 10;

    logic clk = 0, nRST;

    // clock
    always #(PERIOD/2) clk++;

endmodule