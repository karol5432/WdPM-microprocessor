`timescale 1ns/100ps
`include "program_counter.v"
`include "rom.v"
`include "instruction_decoder.v"
`include "ALU.v"
`include "register.v"
`include "mux.v"

module tb_processor();

parameter DATA_WIDTH = 8;
parameter OP_WIDTH = 2;
parameter PC_WIDTH = 4;
parameter ROM_WIDTH = 12;

reg RESET;
reg CLK;
wire [PC_WIDTH-1:0] TO_ROM;
wire [ROM_WIDTH-1:0] TO_ID;
wire RST_CODE;
wire MUX_SEL;
wire CE_R0;
wire CE_ACC;
wire [OP_WIDTH-1:0] OP;
wire [DATA_WIDTH-1:0] ACC_OUT;
wire [DATA_WIDTH-1:0] R0_OUT;
wire [DATA_WIDTH-1:0] ALU_OUT;
wire [DATA_WIDTH-1:0] MUX_OUT;

program_counter p1(
    .RST(RESET | RST_CODE),
    .CLK(CLK),
    .DATA(TO_ROM)
);

rom16x8 ROM(
    .ADDR(TO_ROM),
    .DATA(TO_ID)
);

instruction_decoder ID(
    .INSTRUCTION(TO_ID[11:8]),
    .RESET_INSTR(RST_CODE),
    .SEL(MUX_SEL),
    .CE_R0(CE_R0),
    .CE_ACC(CE_ACC),
    .OP(OP)
);

alu ALU(
    .IN0(MUX_OUT),
    .IN1(R0_OUT),
    .OP(OP),
    .OUT(ALU_OUT)
);

register ACC(
    .IN(ALU_OUT),
    .CLK(CLK),
    .CE(CE_ACC),
    // .RST(RESET),
    .OUT(ACC_OUT)
);

register R0(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R0),
    // .RST(RESET),
    .OUT(R0_OUT)
);

mux2 mux_alu(
    .IN0(ACC_OUT),
    .IN1(TO_ID[7:0]),
    .SEL(MUX_SEL),
    .OUT(MUX_OUT)
);

initial begin // clock generation
    CLK = 1'b0;
    forever #5 CLK = ~CLK;
end

initial begin // start conditions
    RESET = 1'b1;
end

initial begin // testbench program
    #20 RESET = 1'b0;

    #200 $finish;
end

initial begin
    $dumpfile("tb_processor.vcd");
    $dumpvars(0, tb_processor);
    $dumpon;
end

endmodule