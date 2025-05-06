`timescale 1ns/1ns
`include "hello.v"

module tb_hello;

reg A;
wire B;

hello uut(A, B);

initial begin 

        $dumpfile("tb_hello.vcd");
        $dumpvars(0,tb_hello);

        A = 0;
        #20;

        A = 1;
        #20;

        A= 0;
        #20;

        $display("test Complete");

end

endmodule 