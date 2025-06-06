//`include "fusion_unit.sv"

module tb_fusion_unit ();
    
    parameter PERIOD = 10;

    logic clk = 0, nRST;

    // clock
    always #(PERIOD/2) clk++;

    //*****************************************************************************
    // Declare TB Signals
    //*****************************************************************************
    integer tb_test_case_num;
    integer i, j;
    string tb_test_case;
    logic tb_mismatch;

    // expected value signals
    logic signed [31:0] expected_psum;
    logic [31:0] expected_input_to_right;
    
    //*****************************************************************************
    // Declare DUT Signals
    //*****************************************************************************
    logic [2:0] input_bitwidth, weight_bitwidth;
    logic [3:0] input_sign, weight_sign;
    logic [31:0] input_forward, weight;
    logic [31:0] psum, input_to_right;

    //*****************************************************************************
    // DUT Instance
    //*****************************************************************************
    fusion_unit DUT (
        .clk(clk),
        .nRST(nRST),
        .input_bitwidth(input_bitwidth),
        .weight_bitwidth(weight_bitwidth),
        .input_sign(input_sign),
        .weight_sign(weight_sign),
        .input_forward(input_forward),
        .weight(weight),
        .psum(psum),
        .input_to_right(input_to_right)
    );

    //*****************************************************************************
    // Declare TB tasks
    //*****************************************************************************
    task check_output;
        begin
            tb_mismatch = 1'b0;
            
            if (expected_psum == psum) begin
                $display("Correct 'psum' output = %d during %s test case. Expected psum = %d", psum, tb_test_case, expected_psum);
            end
            else begin
                tb_mismatch = 1'b1;
                $display("Incorrect 'psum' output = %d during %s test case. Expected psum = %d", psum, tb_test_case, expected_psum);
            end

            if (expected_input_to_right == input_to_right) begin
                $display("Correct 'input_to_right' = output %d during %s test case. Expected input_to_right = %d", input_to_right, tb_test_case, expected_input_to_right);
            end
            else begin
                tb_mismatch = 1'b1;
                $display("Incorrect 'input_to_right' = output %d during %s test case. Expected input_to_right = %d", input_to_right, tb_test_case, expected_input_to_right);
            end
        end
    endtask

    task reset_dut;
        begin
            // Activate the reset
            nRST = 1'b0;

            // Maintain the reset for more than one cycle
            @(posedge clk);
            @(posedge clk);

            // Wait until safely away from rising edge of the clock before releasing
            @(negedge clk);
            nRST = 1'b1;

            /*
            // Leave out of reset for a couple cycles before allowing other stimulus
            // Wait for negative clock edges, 
            // since inputs to DUT should normally be applied away from rising clock edges
            @(negedge clk);
            @(negedge clk);
            */
        end
    endtask


    //*****************************************************************************
    //*****************************************************************************
    // Main TB Process
    //*****************************************************************************
    //*****************************************************************************
    initial begin
        $dumpfile("fusion_unit.vcd");
        $dumpvars(0,tb_fusion_unit);

        // Initiliaze values
        tb_test_case = "Initialization";
        tb_test_case_num = -1;
        nRST = 1;
        input_bitwidth = '0;
        weight_bitwidth = '0;
        input_sign = '0;
        weight_sign = '0;
        input_forward = '0;
        weight = '0;

        //*****************************************************************************
        // 8-bit input = 3, 8-bit weight = 7
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = 3, 8b weight = 7";

        input_sign = 4'h0;
        weight_sign = 4'h0;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b100;

        input_forward = 32'h0000_00ff;
        weight = 32'h0707_0707;

        expected_psum = 32'd21;
        expected_input_to_right = 32'h0000_00ff;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = 13, 8-bit weight = 10
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = 13, 8b weight = 10";
    
        input_sign = 4'h0;
        weight_sign = 4'h0;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b100;
    
        input_forward = 32'h0000_ff55;
        weight = 32'h0a0a_0a0a;
    
        expected_psum = 32'd130;
        expected_input_to_right = 32'h0000_ff55;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = -128, 8-bit weight = 127
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = -128, 8b weight = 127";
    
        input_sign = 4'h8;
        weight_sign = 4'h0;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b100;
    
        input_forward = 32'haa00_0000;
        weight = 32'h7f7f_7f7f;
    
        expected_psum = -32'd16256;
        expected_input_to_right = 32'haa00_0000;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = 127, 8-bit weight = -128
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = 127, 8b weight = -128";
    
        input_sign = 4'h0;
        weight_sign = 4'h8;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b100;
    
        weight = 32'h8080_8080;
        input_forward = 32'h55ff_ffff;
    
        expected_psum = -32'd16256;
        expected_input_to_right = 32'h55ff_ffff;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = -6, 8-bit weight = 3
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = -6, 8b weight = 3";
    
        input_sign = 4'h8;          // only top 2 bits are negative
        weight_sign = 4'h0;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b100;
    
        input_forward = 32'hffff_aaaa;
        weight = 32'h0303_0303;
    
        expected_psum = -32'd18;
        expected_input_to_right = 32'hffff_aaaa;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = 127,127, 4-bit weight = 7,7
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = 127,127, 4b weight = 7,7";
    
        input_sign = 4'h0;          
        weight_sign = 4'h0;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b010;
    
        input_forward = 32'h55ff_ffff;
        weight = 32'h7777_7777;
    
        expected_psum = 32'd1778;
        expected_input_to_right = 32'h55ff_ffff;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = -128,-128, 4-bit weight = -8,-8
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = -128,-128,, 4b weight = -8,-8";
    
        input_sign = 4'b1010;          
        weight_sign = 4'b1010;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b010;
    
        input_forward = 32'haa00_0000;
        weight = 32'h8888_8888;
    
        expected_psum = 32'd2048;
        expected_input_to_right = 32'haa00_0000;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = -128,-128, 2-bit weight = 1,1
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = -128,-128, 2b weight = 1,1";
    
        input_sign = 4'b1010;          
        weight_sign = 4'b0000;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b001;
    
        input_forward = 32'haa00_0000;
        weight = 32'h5555_5555;
    
        expected_psum = -32'd512;
        expected_input_to_right = 32'haa00_0000;
        #10
        check_output();
        
        //*****************************************************************************
        // 8-bit input = -128,-128, 2-bit weight = -2,-2
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "8b input = -128,-128, 2b weight = -2,-2";
    
        input_sign = 4'b1010;          
        weight_sign = 4'b1111;
        input_bitwidth = 3'b100;
        weight_bitwidth = 3'b001;
    
        input_forward = 32'haa00_0000;
        weight = 32'haaaa_aaaa;
    
        expected_psum = 32'd1024;
        expected_input_to_right = 32'haa00_0000;
        #10
        check_output();
        
        //*****************************************************************************
        // 4-bit input = 7,7, 8-bit weight = 127
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "4b input = 7,7, 8b weight = 127";
    
        input_sign = 4'b0000;          
        weight_sign = 4'b0000;
        input_bitwidth = 3'b010;
        weight_bitwidth = 3'b100;
    
        input_forward = 32'h55ff_55ff;
        weight = 32'h7f7f_7f7f;
    
        expected_psum = 32'd1778;
        expected_input_to_right = 32'h55ff_55ff;
        #10
        check_output();
        
        //*****************************************************************************
        // 4-bit input = 7,7,7,7, 4-bit weight = -8,-8,-8,-8
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "4b input = 7,7,7,7, 4b weight = -8,-8,-8,-8";
    
        input_sign = 4'b0000;          
        weight_sign = 4'b1010;
        input_bitwidth = 3'b010;
        weight_bitwidth = 3'b010;
    
        input_forward = 32'h55ff_55ff;
        weight = 32'h8888_8888;
    
        expected_psum = -32'd224;
        expected_input_to_right = 32'h55ff_55ff;
        #10
        check_output();
        
        //*****************************************************************************
        // 4-bit input = -8,-8,-8,-8, 2-bit weight = 1,1,1,1,1,1,1,1
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "4b input = -8,-8,-8,-8, 2b weight = 1,1,1,1,1,1,1,1";
    
        input_sign = 4'b1010;          
        weight_sign = 4'b0000;
        input_bitwidth = 3'b010;
        weight_bitwidth = 3'b001;
    
        input_forward = 32'haa00_aa00;
        weight = 32'h5555_5555;
    
        expected_psum = -32'd64;
        expected_input_to_right = 32'haa00_aa00;
        #10
        check_output();
        
        //*****************************************************************************
        // 2-bit input = 1, 8-bit weight = 127
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "2b input = 1, 8b weight = 127";
    
        input_sign = 4'b0000;          
        weight_sign = 4'b0000;
        input_bitwidth = 3'b001;
        weight_bitwidth = 3'b100;
    
        input_forward = 32'h5555_5555;
        weight = 32'h7f7f_7f7f;
    
        expected_psum = 32'd508;
        expected_input_to_right = 32'h5555_5555;
        #10
        check_output();
        
        //*****************************************************************************
        // 2-bit input = 1, 4-bit weight = -8
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "2b input = 1, 4b weight = -8";
    
        input_sign = 4'b0000;          
        weight_sign = 4'b1010;
        input_bitwidth = 3'b001;
        weight_bitwidth = 3'b010;
    
        input_forward = 32'h5555_5555;
        weight = 32'h8888_8888;
    
        expected_psum = -32'd64;
        expected_input_to_right = 32'h5555_5555;
        #10
        check_output();
        
        //*****************************************************************************
        // 2-bit input = 1, 2-bit weight = 1
        //*****************************************************************************
        tb_test_case_num += 1;
        tb_test_case = "2b input = 1, 2b weight = 1";
    
        input_sign = 4'b0000;          
        weight_sign = 4'b0000;
        input_bitwidth = 3'b001;
        weight_bitwidth = 3'b001;
    
        input_forward = 32'h5555_5555;
        weight = 32'h5555_5555;
    
        expected_psum = 32'd16;
        expected_input_to_right = 32'h5555_5555;
        #10
        check_output();
        
   

        $finish;
    end
endmodule