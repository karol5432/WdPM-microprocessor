`timescale 1ns/1ps

module tb_register();

reg [3:0] IN;
reg CLK;
reg CE;
// reg RST;
wire [3:0] OUT;

register R0(
    .IN(IN),
    .CLK(CLK),
    .CE(CE),
    // .RST(RST),
    .OUT(OUT)
);

initial begin
    IN = 4'h0;
    CE = 1'b0;
    // RST = 1'b1;
    CLK <= 1'b0;
    forever #5 CLK <= ~CLK;
end

initial begin
    // #20 RST = 1'b0;
    #20 IN = 4'h5;
    #20 CE = 1'b1; // loading value
    #20 CE = 1'b0;
    // #20 RST = 1'b1; // reseting value
    IN = 4'h9;
    #20 CE = 1'b1; // trying to load, while RST enabled
    // #20 RST = 1'b0; // disabling RST with CE = 1
    #20 $finish;
end

initial begin
    $dumpfile("tb_register.vcd");
    $dumpvars(0, tb_register);
    $dumpon;
end

endmodule