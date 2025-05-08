module tb_bitfusion ();
    
    parameter PERIOD = 10;
    parameter ARRAY_SIZE = 2;
    parameter DATA_W = 32;

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
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] expected_OBUF;
    
    //*****************************************************************************
    // Declare DUT Signals
    //*****************************************************************************
    //    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] IBUF;
    //    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][DATA_W - 1:0] WBUF;
    logic [DATA_W - 1:0] data_in;
    logic [ARRAY_SIZE - 1:0] IBUF_wr_en;
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0] WBUF_wr_en;
    logic [ARRAY_SIZE - 1:0] input_rd_en, acc_clear;
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0] weight_rd_en;
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][3:0] input_sign;
    logic [ARRAY_SIZE - 1:0][ARRAY_SIZE - 1:0][3:0] weight_sign;
    logic [2:0] input_bitwidth, weight_bitwidth;
    logic [ARRAY_SIZE - 1:0][DATA_W - 1:0] OBUF;

    //*****************************************************************************
    // DUT Instance
    //*****************************************************************************
    bitfusion #(.ARRAY_SIZE(ARRAY_SIZE), .DATA_W(DATA_W)) DUT (
        .clk(clk), .nRST(nRST),
        //.IBUF(IBUF), .WBUF(WBUF),
        .data_in(data_in),
        .IBUF_wr_en(IBUF_wr_en), .WBUF_wr_en(WBUF_wr_en),
        .input_rd_en(input_rd_en), .weight_rd_en(weight_rd_en), .acc_clear(acc_clear),
        .input_sign(input_sign), .weight_sign(weight_sign),
        .input_bitwidth(input_bitwidth), .weight_bitwidth(weight_bitwidth),
        .OBUF(OBUF)
    );

    //*****************************************************************************
    // Declare TB tasks
    //*****************************************************************************
    task check_output;
        begin
            tb_mismatch = 1'b0;
            
            if (expected_OBUF == OBUF) begin
                $display("Correct 'OBUF' output = %d during %s test case. Expected OBUF = %d", OBUF, tb_test_case, expected_OBUF);
            end
            else begin
                tb_mismatch = 1'b1;
                $display("Incorrect 'OBUF' output = %d during %s test case. Expected psum = %d", OBUF, tb_test_case, expected_OBUF);
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

    task  print_obuf;
        begin
            $display("Cycle %d    OBUF[0] = %d    OBUF[1] = %d", i, OBUF[0], OBUF[1]);
        end
    endtask //


    //*****************************************************************************
    //*****************************************************************************
    // Main TB Process
    //*****************************************************************************
    //*****************************************************************************
    initial begin
        $dumpfile("bitfusion.vcd");
        $dumpvars(0,tb_bitfusion);

        // Initiliaze values
        tb_test_case = "Initialization";
        tb_test_case_num = -1;
        i = 0;
        nRST = 1;
        data_in = '0;
        IBUF_wr_en = '0;
        WBUF_wr_en = '0;
        input_rd_en = '0;
        weight_rd_en = '0;
        acc_clear = '0;
        input_bitwidth = '0;
        weight_bitwidth = '0;
        input_sign = '0;
        weight_sign = '0;

        //*****************************************************************************
        // Reset DUT
        //*****************************************************************************
        reset_dut();

        //*****************************************************************************
        // 2b x 2b. Systolic array is 2 x 2
        //*****************************************************************************
        // // 2b inputs, 2b weights
        // input_bitwidth  = 3'b001;
        // weight_bitwidth = 3'b001;
        
        // // fill buffers with 1s
        // IBUF[0] = 32'h5555_5555;
        // IBUF[1] = 32'h5555_5555;
        // WBUF[0][0] = 32'h5555_5555;
        // WBUF[0][1] = 32'h5555_5555;
        // WBUF[1][0] = 32'h5555_5555;
        // WBUF[1][1] = 32'h5555_5555;        

        // // apply inputs on negative edge
        // @(negedge clk);
        // input_rd_en[0] = 1'b1;
        // weight_rd_en[0][0] = 1'b1;
        
        // @(posedge clk);
        
        // @(negedge clk);
        // //input_rd_en[0] = 1'b0;
        // IBUF[0] = '0;
        // input_rd_en[1] = 1'b1;
        // //weight_rd_en[0][0] = 1'b0;
        // WBUF[0][0] = '0;
        // weight_rd_en[0][1] = 1'b1;
        // weight_rd_en[1][0] = 1'b1;
        // weight_rd_en[1][1] = 1'b0;
        
        // @(posedge clk);
        
        // @(negedge clk);
        // //input_rd_en[0] = 1'b0;
        // //input_rd_en[1] = 1'b0;
        // IBUF[1] = '0;
        // //weight_rd_en[0][1] = 1'b0;
        // WBUF[0][1] = '0;
        // //weight_rd_en[0][0] = 1'b0;
        // //weight_rd_en[1][0] = 1'b0;
        // WBUF[1][0] = '0;
        // weight_rd_en[1][1] = 1'b1;
        
        // @(posedge clk);
        
        // @(negedge clk);
        // //weight_rd_en[1][1] = 1'b0;
        // WBUF[1][1] = '0;
        // @(posedge clk);
        // @(posedge clk);
        // @(posedge clk);
        // @(posedge clk);
        
        //*****************************************************************************
        // 8b x 4b. Systolic array is 2 x 2
        //*****************************************************************************
        // 8b inputs, 4b weights
        input_bitwidth  = 3'b100;
        weight_bitwidth = 3'b010;

        // fill buffers
//        IBUF[0] = 32'h7f7f_7f7f;    // all 4 8b values are 127
//        IBUF[1] = 32'h7f7f_7f7f;    // all 4 8b values are 127
        @(negedge clk);
        data_in = 32'h7f7f_7f7f;    // all 4 8b values are 127
        IBUF_wr_en = 2'b11;
        
        @(posedge clk);
        
        @(negedge clk);
        // turn off IBUF write
        IBUF_wr_en = 2'b00;
        
        // WBUF[0][0] = 32'h7777_7777; // all 8 4b values are 7
        // WBUF[0][1] = 32'h7777_7777; // all 8 4b values are 7
        // WBUF[1][0] = 32'h7777_7777; // all 8 4b values are 7
        // WBUF[1][1] = 32'h7777_7777; // all 8 4b values are 7
        data_in = 32'h7777_7777;
        WBUF_wr_en = 4'hf;
        
        
        
        @(posedge clk);
        // FU[0][0] is on
        // IBUF[0] [15:0] used, WBUF[0][0] [7:0] used 
        @(negedge clk);
        // turn off WBUF write
        WBUF_wr_en = 4'h0;
        
        input_rd_en[0] = 1'b1;
        weight_rd_en[0][0] = 1'b1;
        
        @(posedge clk);
        i = i + 1;
        
        ////// FU[0][0], FU[0][1], FU[1][0] on //////
        @(negedge clk);
        print_obuf();
        // IBUF[0] [31:16] used, WBUF[0][0] [15:8] used in FU[0][0]
        input_rd_en[0] = 1'b1;
        weight_rd_en[0][0] = 1'b1;
        // IBUF[1] [15:0] used, WBUF[1][0] [7:0] used in FU[1][0]
        input_rd_en[1] = 1'b1;
        weight_rd_en[1][0] = 1'b1;
        // IBUF[0] [15:0] used, WBUF[0][1] [7:0] used in F[0][1]
        weight_rd_en[0][1] = 1'b1;
       
        @(posedge clk);
        i = i + 1;
        
        ////// FU[0][1], FU[1][0], FU[1][1] on //////
        @(negedge clk);
        print_obuf();
        // FU[0][0] is off
        input_rd_en[0] = 1'b0;
        weight_rd_en[0][0] = 1'b0;
//        IBUF[0] = '0;
//        WBUF[0][0] = '0;
        // IBUF[1] [31:16] used, WBUF[1][0] [15:8] used in FU[1][0]
        input_rd_en[1] = 1'b1;
        weight_rd_en[1][0] = 1'b1;
        // IBUF[0] [31:16] used, WBUF[0][1] [15:8] used in F[0][1]
        weight_rd_en[0][1] = 1'b1;
        // IBUF[1] [15:0] used, WBUF[1][1] [7:0] used in FU[1][1]
        weight_rd_en[1][1] = 1'b1;

        @(posedge clk);
        i = i + 1;
        
        ////// FU[1][1] on //////
        @(negedge clk);
        print_obuf();
        //  FU[0][1] is off
        weight_rd_en[0][1] = 1'b0;
        // WBUF[0][1] = '0;
        //  FU[1][0] is off
        input_rd_en[1] = 1'b0;
        weight_rd_en[1][0] = 1'b0;
        // IBUF[1] = '0;
        // WBUF[0][1] = '0;
        // IBUF[1] [31:16] used, WBUF[1][1] [15:8] used in FU[1][1]
        weight_rd_en[1][1] = 1'b1;
    
        @(posedge clk);
        i = i + 1;
        
        ////// All off //////
        @(negedge clk);
        print_obuf();
        // FU[1][1] is off
        weight_rd_en[1][1] = 1'b0;
        // WBUF[1][1] = '0;
        
        @(posedge clk);
        i = i + 1;
        
        @(negedge clk);
        print_obuf();

        @(posedge clk);
        i = i + 1;
        
        @(negedge clk);
        print_obuf();

        @(posedge clk);
        i = i + 1;
        
        @(negedge clk);
        print_obuf();
        
        @(posedge clk);
        i = i + 1;
        
        @(negedge clk);
        print_obuf();
        
        @(posedge clk);
        i = i + 1;
        
        @(negedge clk);
        print_obuf();


        $finish;
    end
endmodule