`timescale 1ns/1ps
`include "program_counter.v"
`include "rom16x8.v"
`include "instruction_decoder.v"
`include "ALU.v"
`include "register.v"
`include "mux2.v"
`include "memory.v"
`include "decoder8.v"
`include "mux8.v"
`include "ram_mem.v"
`include "stack.v"
`include "mux4.v"

module tb_processor();

parameter DATA_WIDTH = 8;
parameter OP_WIDTH = 4;
parameter PC_WIDTH = 5;
parameter ROM_WIDTH = 16;

reg RESET;
reg CLK;
reg [DATA_WIDTH-1:0] PORTA_IN;
wire [DATA_WIDTH-1:0] PORTA_OUT;

wire [PC_WIDTH-1:0] TO_ROM;
wire [ROM_WIDTH-1:0] TO_ID;
wire RST_CODE;
wire [1:0] MUX_SEL;
wire [7:0] CE_R;
wire CE_ACC;
wire [OP_WIDTH-1:0] OP;
wire [DATA_WIDTH-1:0] ACC_OUT;
wire [DATA_WIDTH-1:0] R7_OUT, R6_OUT, R5_OUT, R4_OUT, R3_OUT, R2_OUT, R1_OUT, R0_OUT;
wire [DATA_WIDTH-1:0] R_OUT;
wire [DATA_WIDTH-1:0] ALU_OUT;
wire [DATA_WIDTH-1:0] MUX_OUT;
wire REG_WR;
wire [DATA_WIDTH-1:0] RAM_OUT;
wire [DATA_WIDTH-1:0] MEM_OUT;
wire MEM_SEL;
wire CE_RAM;
wire CE_PC;
wire [DATA_WIDTH-1:0] STACK_OUT;
wire CE_STACK;
wire nRW_STACK;
wire STACK_SEL;
wire [DATA_WIDTH-1:0] STACK_IN;
wire PC_SEL;
wire [DATA_WIDTH-1:0] PC_IN;

program_counter p1(
    .nRST(RESET & RST_CODE),
    .CLK(CLK),
    .DATA(TO_ROM),
    .CE(CE_PC),
    .IN(PC_IN[4:0])
);

mux2 pc_in(
    .IN0(TO_ID[7:0]),
    .IN1(STACK_OUT),
    .SEL(PC_SEL),
    .OUT(PC_IN)
);

// rom16x8 ROM(
//     .ADDR(TO_ROM),
//     .DATA(TO_ID)
// );

memory mem(
    .ADDR(TO_ROM),
    .DATA(TO_ID)
);

instruction_decoder ID(
    .INSTRUCTION(TO_ID[15:11]),
    .RESET_INSTR(RST_CODE),
    .MUX_SEL(MUX_SEL),
    .CE_ACC(CE_ACC),
    .OP(OP),
    .REG_WR(REG_WR),
    .MEM_SEL(MEM_SEL),
    .CE_RAM(CE_RAM),
    .CE_PC(CE_PC),
    .CE_STACK(CE_STACK),
    .nRW_STACK(nRW_STACK),
    .STACK_SEL(STACK_SEL),
    .PC_SEL(PC_SEL),
    .CE_PORTA(CE_PORTA)
);

alu ALU(
    .IN0(MUX_OUT),
    .IN1(MEM_OUT),
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

decoder8 dec(
    .SEL(TO_ID[10:8]),
    .EN(REG_WR),
    .OUT({CE_R7, CE_R6, CE_R5, CE_R4, CE_R3, CE_R2, CE_R1, CE_R0})
);

mux8 reg_mux(
    .IN0(R0_OUT),
    .IN1(R1_OUT),
    .IN2(R2_OUT),
    .IN3(R3_OUT),
    .IN4(R4_OUT),
    .IN5(R5_OUT),
    .IN6(R6_OUT),
    .IN7(R7_OUT),
    .SEL(TO_ID[10:8]),
    .OUT(R_OUT)
);

register R0(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R0),
    // .RST(RESET),
    .OUT(R0_OUT)
);

register R1(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R1),
    // .RST(RESET),
    .OUT(R1_OUT)
);

register R2(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R2),
    // .RST(RESET),
    .OUT(R2_OUT)
);

register R3(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R3),
    // .RST(RESET),
    .OUT(R3_OUT)
);

register R4(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R4),
    // .RST(RESET),
    .OUT(R4_OUT)
);

register R5(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R5),
    // .RST(RESET),
    .OUT(R5_OUT)
);

register R6(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R6),
    // .RST(RESET),
    .OUT(R6_OUT)
);

register R7(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R7),
    // .RST(RESET),
    .OUT(R7_OUT)
);

mux4 mux_alu(
    .IN0(ACC_OUT),
    .IN1(TO_ID[7:0]),
    .IN2(STACK_OUT),
    .IN3(PORTA_IN),
    .SEL(MUX_SEL),
    .OUT(MUX_OUT)
);

mux2 mux_mem(
    .IN0(R_OUT),
    .IN1(RAM_OUT),
    .SEL(MEM_SEL),
    .OUT(MEM_OUT)
);

ram_mem RAM(
    .CLK(CLK),
    .CE(CE_RAM),
    .ADDR(R_OUT),
    .DATA_IN(ACC_OUT),
    .DATA_OUT(RAM_OUT)
);

mux2 stack_in(
    .IN0(ACC_OUT),
    .IN1({3'b000, TO_ROM+1'b1}),
    .SEL(STACK_SEL),
    .OUT(STACK_IN)
);

stack stack(
    .DATA_IN(STACK_IN),
    .CLK(CLK),
    .nRW(nRW_STACK),
    .CE(CE_STACK),
    .nRST(RESET & RST_CODE),
    .DATA_OUT(STACK_OUT)
);

register porta(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_PORTA),
    .OUT(PORTA_OUT)
);

initial begin // clock generation
    CLK = 1'b0;
    forever #5 CLK = ~CLK;
end

initial begin // start conditions
    RESET = 1'b0;
    PORTA_IN = 8'h00;
end

initial begin // testbench program (very demanding)
    #10 RESET = 1'b1;
    PORTA_IN = 8'd250;

    #1000 $finish;
end

initial begin
    $dumpfile("tb_processor.vcd");
    $dumpvars(0, tb_processor);
    $dumpon;
end

endmodule