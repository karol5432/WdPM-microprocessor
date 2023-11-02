`timescale 1ns/100ps
`include "memory.v"
`include "program_counter.v"

module tb_memory();

parameter ADDR_WIDTH = 4;
parameter WIDTH = 12;

wire [ADDR_WIDTH-1:0] ADDR;
wire [WIDTH-1:0] DATA;
reg RST;
reg CLK;

program_counter p1(
    .RST(RST),
    .CLK(CLK),
    .DATA(ADDR)
);

memory mem(
    .ADDR(ADDR),
    .DATA(DATA)
);

initial begin
    CLK <= 1'b0;
    forever #5 CLK <= ~CLK;
end

initial begin
    RST <= 1'b1;
    #20 RST <= 1'b0;
end

initial begin
    $dumpfile("tb_memory.vcd");
    $dumpvars(0, tb_memory);
    $dumpon;
end

initial begin
    #200 $finish;
end

endmodule // tb_memory