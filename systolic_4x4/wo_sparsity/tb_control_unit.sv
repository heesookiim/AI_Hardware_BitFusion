`timescale 1 ns / 1 ns
`include "control_unit.sv"

module tb_control_unit ();
    
    parameter PERIOD = 10;
    parameter CPU_PERIOD = 2 * PERIOD;
    parameter INPUT_W = 8;
    parameter WEIGHT_W = 8;
    parameter DATA_W = 32;
    parameter ARRAY_SIZE = 4;

    logic clk = 0, nRST;

    // clock
    always #(PERIOD/2) clk++;

    // tb signals


    logic [31:0] mem_data;
    logic [31:0] mem_addr;
    logic mem_rd_en, mem_wr_en;

    // Fusion Unit operands precision
    logic [2:0] op0_precision, op1_precision;
    logic [2:0] input_precision, output_precision;

    // base addresses
    logic [9:0] input_base_addr, weight_base_addr, output_base_addr;

    logic compute_en;

    logic [ARRAY_SIZE - 1:0][INPUT_W - 1:0] input_forward;

    // instantiate module
    control_unit # (.INPUT_W(INPUT_W), .WEIGHT_W(WEIGHT_W), .DATA_W(DATA_W), .ARRAY_SIZE(ARRAY_SIZE)) DUT (
    //control_unit DUT (
        .clk(clk),
        .nRST(nRST),
        .mem_data(mem_data),
        .mem_addr(mem_addr),
        .mem_rd_en(mem_rd_en),
        .mem_wr_en(mem_wr_en),
        .op0_precision(op0_precision),
        .op1_precision(op1_precision),
        .input_precision(input_precision),
        .output_precision(output_precision),
        .input_base_addr(input_base_addr),
        .weight_base_addr(weight_base_addr),
        .output_base_addr(output_base_addr),
        .compute_en(compute_en),
        .input_forward(input_forward)
    );

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

            @(negedge clk);
            @(negedge clk);

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
        // tb_test_case = "Initialization";
        // tb_test_case_num = -1;
        $dumpfile("control_unit.vcd");
        $dumpvars(0, tb_control_unit);
        
        nRST = 1;

        mem_data = '0;
        op0_precision = 3'd4;
        op1_precision = 3'd4;
        input_base_addr = '0;
        weight_base_addr = '0;
        output_base_addr = '0;


        //*****************************************************************************
        // Power-on-Reset Test Case
        //*****************************************************************************
        // tb_test_case     = "Power-on-Reset";
        // tb_test_case_num = tb_test_case_num + 1;

        reset_dut();

        //@(posedge clk)

        //*****************************************************************************
        // Normal operation
        //*****************************************************************************
        
        mem_data = 32'haaaaaaaa;
        #1000
        $finish;
    end
endmodule