`timescale 1ns/1ps
`include "decoder2.v"

module tb_decoder2();

reg SEL;
reg EN;
wire [1:0] OUT;

decoder2 dec2(
    .SEL(SEL),
    .EN(EN),
    .OUT(OUT)
);

initial begin
    SEL = 1'b0;
    EN = 1'b0;
end

initial begin
    #10 SEL = 1'b1;
    #10 EN = 1'b1;
    #10 SEL = 1'b0;
    #10 EN = 1'b0;
    #10 $finish;
end

initial begin
    $dumpfile("tb_decoder2.vcp");
    $dumpvars(0, tb_decoder2);
    $dumpon;
end

endmodule 