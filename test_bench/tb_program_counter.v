`timescale 1ns/1ps

module tb_program_counter();

reg CLK;
reg RST;
reg CE;
reg [3:0] IN;
wire [3:0] DATA;

program_counter p1(
    .CLK(CLK),
    .RST(RST),
    .DATA(DATA),
    .IN(IN),
    .CE(CE)
);

initial begin
    CLK = 1'b0;
    forever #5 CLK <= ~CLK;
end

initial begin
    RST = 1'b1;
    IN = 4'b0101;
    CE = 1'b0;
    #10 CE = 1'b1;
    #10 CE = 1'b0;
    RST = 1'b0;
    #10 CE = 1'b1;
    #10 CE = 1'b0;
    IN = 4'b1010;
    #70 CE = 1'b1;
    #10 CE = 1'b0;
end

initial #200 $finish;

initial begin
    $dumpfile("tb_program_counter.vcd");
    $dumpvars(0, tb_program_counter);
    $dumpon;
end

endmodule