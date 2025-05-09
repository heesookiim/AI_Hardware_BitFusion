`include "shift_add.sv"

module tb_shift_add ();
    
    parameter PERIOD = 10;

    logic clk = 0, nRST;

    // clock
    always #(PERIOD/2) clk++;

    //*****************************************************************************
    // Declare TB Signals
    //*****************************************************************************
    integer tb_test_case_num;
    integer i;

    // expected value signals
    logic signed [31:0] tb_expected_shift_add_out;
    
    //*****************************************************************************
    // Declare DUT Signals
    //*****************************************************************************
    logic [2:0] tb_input_bitwidth, tb_weight_bitwidth; // 001 - 2bits, 010 - 4bits, 100 - 8bits
    logic signed [5:0][15:0] tb_products;
    logic signed [31:0] tb_shift_add_out;

    //*****************************************************************************
    // DUT Instance
    //*****************************************************************************
    shift_add DUT (
        .input_bitwidth(tb_input_bitwidth),
        .weight_bitwidth(tb_weight_bitwidth),
        .products(tb_products),
        .shift_add_out(tb_shift_add_out)
    );

    //*****************************************************************************
    // Fill tb_products with 0s
    //*****************************************************************************
    // integer i;
    // for (i = 0; i < 16'hffff; i++) begin
    //     tb_products[i] = 
    // end

    //*****************************************************************************
    //*****************************************************************************
    // Main TB Process
    //*****************************************************************************
    //*****************************************************************************
    initial begin
        $dumpfile("alu_control.vcd");
        $dumpvars(0,tb_alu_control);

        // Initiliaze values
        tb_products = '0;
        tb_input_bitwidth = '0;
        tb_weight_bitwidth = '0;

        //*****************************************************************************
        // 8-bit input, 8-bit weight
        //*****************************************************************************
        tb_input_bitwidth = 3'b100;
        tb_weight_bitwidth = 3'b100;



        $finish;
    end
endmodule