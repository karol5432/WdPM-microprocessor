`timescale 1ns/1ps
`include "register.v"
`include "mux2.v"
`include "decoder2.v"

module tb_2registers();

parameter DATA_WIDTH = 8;

reg CLK;
reg [DATA_WIDTH-1:0] REG_IN;
reg REG_WR;
reg REG_SEL;

wire [DATA_WIDTH-1:0] IN0;
wire [DATA_WIDTH-1:0] IN1;
wire [DATA_WIDTH-1:0] OUT;
wire CE_R0;
wire CE_R1;

mux2 mux_reg(
    .IN0(IN0),
    .IN1(IN1),
    .SEL(REG_SEL),
    .OUT(OUT)
);

decoder2 dec_reg(
    .SEL(REG_SEL),
    .EN(REG_WR),
    .OUT({CE_R1, CE_R0})
);

register R0(
    .IN(REG_IN),
    .CLK(CLK),
    .CE(CE_R0),
    .OUT(IN0)
);

register R1(
    .IN(REG_IN),
    .CLK(CLK),
    .CE(CE_R1),
    .OUT(IN1)
);

initial begin
    CLK = 1'b0;
    forever #5 CLK <= ~CLK;
end

initial begin
    REG_IN = 8'b00000000;
    REG_WR = 1'b0;
    REG_SEL = 1'b0;
end

initial begin
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b00000000_0_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b11010100_1_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b11010001_0_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b11010001_1_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b11010001_0_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b00010110_1_0;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b00010110_0_0;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b00000000_0_1;
    #10 {REG_IN, REG_WR, REG_SEL} = 10'b00000000_0_0;
    #10 $finish;
end

initial begin
    $dumpfile("tb_2registers.vcd");
    $dumpvars(0, tb_2registers);
    $dumpon;
end

endmodule