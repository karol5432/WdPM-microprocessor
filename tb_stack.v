`timescale 1ns/100ps
`include "stack.v"

module tb_stack();

parameter DATA_WIDTH = 8;
parameter DEPTH = 3;

reg [DATA_WIDTH-1:0] DATA_IN;
reg CLK;
reg nRW;
reg CE;
reg nRST;
wire [DATA_WIDTH-1:0] DATA_OUT;
wire FULL;
wire EMPTY;

stack stack(
    .DATA_IN(DATA_IN),
    .CLK(CLK),
    .nRW(nRW),
    .CE(CE),
    .nRST(nRST),
    .DATA_OUT(DATA_OUT),
    .FULL(FULL),
    .EMPTY(EMPTY)
);

initial begin
    #10 nRST = 1'b1;
    #10 DATA_IN = 8'h2A;
    CE = 1'b1;
    nRW = 1'b1;
    #10 CE = 1'b0;
    nRW = 1'b0;
    #10 CE = 1'b1;
    #10 CE = 1'b0;
    #10 DATA_IN = 8'h18;
    CE = 1'b1;
    nRW = 1'b1;
    #10 DATA_IN = 8'h16;
    #10 DATA_IN = 8'h44;
    #10 CE = 1'b0;
    #10 nRW = 1'b0;
    CE = 1'b1;
    #20 nRW = 1'b1;
    DATA_IN = 8'h15;
    #10 DATA_IN = 8'h15;
    #10 DATA_IN = 8'h21;
    #10 DATA_IN = 8'hFE;
    #10 DATA_IN = 8'hAC;
    #10 DATA_IN = 8'hAB;
    #10 DATA_IN = 8'h66;
    #10 DATA_IN = 8'h11;
    #10 CE = 1'b0;
    #10 nRW = 1'b0;
    CE = 1'b1;
    #50 CE = 1'b0;
    #10 DATA_IN = 8'h33;
    CE = 1'b1;
    nRW = 1'b1;
    #10 nRW = 1'b0;
    #40 CE = 1'b0;
    #10 nRW = 1'b1;
    DATA_IN = 8'h55;
    CE = 1'b1;
    #10 CE = 1'b0;
    #30 nRW = 1'b0;
    CE = 1'b1;
    #10 CE = 1'b0;
    #100 $finish;
end

initial begin
    CE = 1'b0;
    DATA_IN = 8'b00000000;
    nRST = 1'b0;
    CLK = 1'b0;
    forever #5 CLK = ~CLK;
end

initial begin
    $dumpfile("tb_stack.vcd");
    $dumpvars(0, tb_stack);
    $dumpon;
end

endmodule