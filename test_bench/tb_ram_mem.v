`timescale 1ns/1ps
`include "ram_mem.v"

module tb_ram_mem();

reg CLK;
reg [7:0] DATA_IN;
reg [3:0] ADDR;
reg CE;
wire [7:0] DATA_OUT;

ram_mem RAM(
    .CLK(CLK),
    .DATA_IN(DATA_IN),
    .ADDR(ADDR),
    .CE(CE),
    .DATA_OUT(DATA_OUT)
);

initial begin
    CLK = 1'b0;
    forever #5 CLK = ~CLK;
end

initial begin
    DATA_IN = 8'b00000000;
    ADDR = 4'b0000;
    CE = 1'b0;

    #10 DATA_IN = 8'b00101011;
    ADDR = 4'b1010;
    CE = 1'b1;
    
    #10 CE = 1'b0;
    ADDR = 4'b1011;

    #10 DATA_IN = 8'b11011010;
    CE = 1'b1;

    #10 CE = 1'b0;
    ADDR = 4'b1010;

    #10 ADDR = 4'b1011;

    #10 $finish;
end

initial begin
    $dumpfile("tb_ram_mem.vcd");
    $dumpvars(0, tb_ram_mem);
    $dumpon;
end

endmodule