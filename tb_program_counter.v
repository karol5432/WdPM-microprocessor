`timescale 1ns/1ps

module tb_program_counter();

reg CLK;
reg RST;
wire [3:0] DATA;

program_counter p1(
    .CLK(CLK),
    .RST(RST),
    .DATA(DATA)
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
    $dumpfile("tb_program_counter.vcd");
    $dumpvars(0, tb_program_counter);
    $dumpon;
end

endmodule