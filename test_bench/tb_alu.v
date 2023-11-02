`timescale 1ns/100ps

module tb_alu();

parameter DATA_WIDTH = 4;
parameter OP_WIDTH = 2;

reg [DATA_WIDTH-1:0] IN0;
wire [DATA_WIDTH-1:0] ALU_IN1;
reg [OP_WIDTH-1:0] OP;
wire [DATA_WIDTH-1:0] ALU_OUT;
wire [DATA_WIDTH-1:0] ACC_OUT;
reg CLK;
reg CE_ACC;
reg CE_R0;

alu alu1(
    .IN0(IN0),
    .IN1(ALU_IN1),
    .OP(OP),
    .OUT(ALU_OUT)
);

register ACC(
    .IN(ALU_OUT),
    .CLK(CLK),
    .CE(CE_ACC),
    .OUT(ACC_OUT)
);

register R0(
    .IN(ACC_OUT),
    .CLK(CLK),
    .CE(CE_R0),
    .OUT(ALU_IN1)
);

initial begin
    IN0 = 4'h0;
    OP = 2'b00;
    CE_ACC = 1'b0;
    CE_R0 = 1'b0;
    
    CLK = 1'b0;
    forever #5 CLK = ~CLK;
end

initial begin
    #10 IN0 = 4'hA;
    OP = 2'b01;
    CE_ACC = 1'b1; // loading value to ACC
    #10 OP = 2'b10;
    CE_ACC = 1'b1;
    #10 CE_ACC = 1'b0; // incrementing value in ACC
    #10 CE_R0 = 1'b1;
    #10 CE_R0 = 1'b0; // loading value to R0
    #10 OP = 2'b00;
    IN0 = 4'h2;
    CE_ACC = 1'b1;
    #10 CE_ACC = 1'b0; // adding R0(1010) and IN0(0020)
    #10 OP = 2'b11;
    CE_ACC = 1'b1;
    #10 CE_ACC = 1'b0; // loading value from R0

    #20 $finish;
end

initial begin
    $dumpfile("tb_alu.vcd");
    $dumpvars(0, tb_alu);
    $dumpon;
end

endmodule