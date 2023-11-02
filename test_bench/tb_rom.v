`timescale 1ns/1ps

module tb_rom();

reg CLK;
reg RST;
wire [3:0] ADDR;
wire [7:0] DATA;

program_counter p1(
    .CLK(CLK),
    .RST(RST),
    .DATA(ADDR)
);

rom16x8 rom1(
    .ADDR(ADDR),
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
    $dumpfile("tb_rom.vcd");
    $dumpvars(0, tb_rom);
    $dumpon;
end

endmodule