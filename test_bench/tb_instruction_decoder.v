`timescale 1ns/1ps
`include "program_counter.v"
`include "rom.v"
`include "instruction_decoder.v"

module tb_instruction_decoder();

reg CLK;
reg RST;
wire [3:0] TO_ROM;
wire [7:0] TO_IC;
wire [4:0] MC;
wire RST_CODE;

program_counter p1(
    .CLK(CLK),
    .RST(RST | RST_CODE),
    .DATA(TO_ROM)
);

rom16x8 rom1(
    .ADDR(TO_ROM),
    .DATA(TO_IC)
);

instruction_decoder decoder1(
    .INSTRUCTION(TO_IC[7:4]),
    .RESET_INSTR(RST_CODE),
    .DECODED(MC)
);

initial begin
    CLK = 1'b0;
    forever #5 CLK <= ~CLK;
end

initial begin
    RST <= 1'b1;
    #20 RST <= 1'b0;
end

initial #200 $finish;

initial begin
    $dumpfile("tb_instruction_decoder.vcd");
    $dumpvars(0, tb_instruction_decoder);
    $dumpon;
end

endmodule