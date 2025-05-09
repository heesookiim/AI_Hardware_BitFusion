`include "bit_brick.sv"

module tb_bit_brick ();
    
    parameter PERIOD = 10;

    logic clk = 0, nRST;

    // clock
    always #(PERIOD/2) clk++;

    //*****************************************************************************
    // Declare TB Signals
    //*****************************************************************************
    integer tb_test_case_num;
    integer i, j;
    logic tb_mismatch;

    // expected value signals
    logic signed [5:0] tb_expected_product;
    
    //*****************************************************************************
    // Declare DUT Signals
    //*****************************************************************************
    logic [1:0] tb_x, tb_y;
    logic tb_sx, tb_sy;
    logic [5:0] tb_product;

    //*****************************************************************************
    // DUT Instance
    //*****************************************************************************
    bit_brick DUT (
        .x(tb_x),
        .y(tb_y),
        .sx(tb_sx),
        .sy(tb_sy),
        .product(tb_product)
    );

    //*****************************************************************************
    // Declare TB tasks
    //*****************************************************************************
    task check_output;
        begin
            tb_mismatch = 1'b0;
            
            if (tb_expected_product == tb_product) begin
                $display("Correct 'product' output");
            end
            else begin
                tb_mismatch = 1'b1;
                $display("Incorrect 'product' output");
            end
        end
    endtask


    //*****************************************************************************
    //*****************************************************************************
    // Main TB Process
    //*****************************************************************************
    //*****************************************************************************
    initial begin
        $dumpfile("bit_brick.vcd");
        $dumpvars(0,tb_bit_brick);

        // Initiliaze values
        tb_x = 0;
        tb_y = 0;
        tb_sx = 0;
        tb_sy = 0;

        //*****************************************************************************
        // 8-bit input, 8-bit weight
        //*****************************************************************************
        // Test case 1: x = 2'b00, y = 2'b00 (Product should be 0)
        tb_x = 2'b00; tb_y = 2'b00;
        tb_expected_product = '0;
        
        #10;
        check_output;

        // Test case 2: x = 2'b01, y = 2'b00 (Product should be 0)
        tb_x = 2'b01; tb_y = 2'b00;
        tb_expected_product = '0;
       
        #10;
        check_output;

        // Test case 3: x = 2'b00, y = 2'b01 (Product should be 0)
        tb_x = 2'b00; tb_y = 2'b01;
        tb_expected_product = '0;
       
        #10;
        check_output;

        // Test case 4: x = 2'b01, y = 2'b01 (Product should be 1)
        tb_x = 2'b01; tb_y = 2'b01;
        tb_expected_product = 6'd1;
        
        #10;
        check_output;

        // Test case 5: x = 2'b10, y = 2'b11 (Product should be -6)
        tb_sx = 1;
        tb_x = 2'b10; tb_y = 2'b11;
        tb_expected_product = -6'd6;
        
        #10;
        check_output;

        // Test case 6: x = 2'b11, y = 2'b11 (Product should be 9)
        tb_sx = 0;
        tb_x = 2'b11; tb_y = 2'b11;
        tb_expected_product = 6'd9;
        
        #10;
        check_output;

        // Test case 7: x = 2'b11, y = 2'b10 (Product should be -6)
        tb_sy = 1;
        tb_x = 2'b11; tb_y = 2'b10;
        tb_expected_product = -6'd6;
        
        #10;
        check_output;

        // Test case 8: x = 2'b11, y = 2'b11 (Product should be 1)
        tb_sx = 1;
        tb_sy = 1;
        tb_x = 2'b11; tb_y = 2'b11;
        tb_expected_product = 6'd1;
        
        #10;
        check_output;



        $finish;
    end
endmodule