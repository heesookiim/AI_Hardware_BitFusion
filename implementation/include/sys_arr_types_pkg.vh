`ifndef SYS_ARR_TYPES_PKG_VH
`define SYS_ARR_TYPES_PKG_VH

package sys_arr_types_pkg;
    
    // Depth of buffer tables
    parameter BUFF_TABLE_DEPTH = 10;
    
    // Instrcution format widths
    parameter OP_W = 5;
    parameter OP_SPEC_W = 6;
    parameter LOOP_ID_W = 5;
    parameter IMM_W = 16;

    // Opcode types
    typedef enum logic [OP_W - 1:0] {
        SETUP, LD_MEM, ST_MEM, RD_BUF, WR_BUF,
        GEN_ADDR, COMPUTE, LOOP, BLK_END
    } opcode_t

    // scratchpad type
    typedef enum logic [1:0] {
        IBUF = 3'b001,
        WBUF = 3'b010,
        OBUF = 3'b100,
    } scratchpad_t

    // gen-addr block
    typedef struct packed {
        logic [LOOP_ID_W - 1:0] loop_id,
        logic [IMM_W - 1:0] stride
    } gen_addr_block_t

    // buffer table block
    typedef struct packed {
        logic [OP_W - 1:0] opcode,
        logic [2:0] mem_width,
        logic [IMM_W - 1:0] num_words,
    } buf_block_t

    // buffer table
    buf_block_t [BUFF_TABLE_DEPTH - 1:0] buffer_table;
    
endpackage
`endif