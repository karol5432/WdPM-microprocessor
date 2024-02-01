// `include "../ALU.v"
// `include "../register.v"
// `timescale 1ns/100ps

// module tb_alu();

// parameter DATA_WIDTH = 8;
// parameter OP_WIDTH = 4;

// reg [DATA_WIDTH-1:0] IN0;
// wire [DATA_WIDTH-1:0] ALU_IN1;
// reg [OP_WIDTH-1:0] OP;
// wire [DATA_WIDTH-1:0] ALU_OUT;
// wire [DATA_WIDTH-1:0] ACC_OUT;
// wire ZF;
// reg CLK;
// reg CE_ACC;
// reg CE_R0;

// ALU alu1(
//     .IN0(IN0),
//     .IN1(ALU_IN1),
//     .OP(OP),
//     .ZF(ZF),
//     .OUT(ALU_OUT)
// );

// register ACC(
//     .IN(ALU_OUT),
//     .CLK(CLK),
//     .CE(CE_ACC),
//     .OUT(ACC_OUT)
// );

// register R0(
//     .IN(ACC_OUT),
//     .CLK(CLK),
//     .CE(CE_R0),
//     .OUT(ALU_IN1)
// );

// initial begin
//     nRST = 1'b0;
//     IN0 = 8'h0;
//     OP = 4'b1010;
//     CE_ACC = 1'b0;
//     CE_R0 = 1'b0;
    
//     CLK = 1'b0;
//     forever #5 CLK = ~CLK;
// end

// initial begin
//     #10 nRST = 1'b1;
//     #10 IN0 = 8'hAA;
//     OP = 4'b1010;
//     CE_ACC = 1'b1; // loading value to ACC
//     #10 OP = 2'b0010;
//     CE_ACC = 1'b1;
//     #10 CE_ACC = 1'b0; // incrementing value in ACC
//     #10 CE_R0 = 1'b1;
//     #10 CE_R0 = 1'b0; // loading value to R0
//     #10 OP = 2'b00;
//     IN0 = 8'h2;
//     CE_ACC = 1'b1;
//     #10 CE_ACC = 1'b0; // adding R0(1010) and IN0(0020)
//     #10 OP = 2'b11;
//     CE_ACC = 1'b1;
//     #10 CE_ACC = 1'b0; // loading value from R0

//     #20 $finish;
// end

// initial begin
//     $dumpfile("tb_alu.vcd");
//     $dumpvars(0, tb_alu);
//     $dumpon;
// end

// endmodule

`include "../ALU.v"
`include "../register.v"
`timescale 1ns/100ps

module tb_alu();

parameter DATA_WIDTH = 8;
parameter OP_WIDTH = 4;

reg [DATA_WIDTH-1:0] IN0;
reg [DATA_WIDTH-1:0] IN1;
reg [OP_WIDTH-1:0] OP;
wire [DATA_WIDTH-1:0] OUT;
wire ZF;

ALU alu1(
    .IN0(IN0),
    .IN1(IN1),
    .OP(OP),
    .ZF(ZF),
    .OUT(OUT)
);

initial begin
    IN0 = 8'h0;
    IN1 = 8'h0;
    OP = 4'b1010;
    #20 IN0 = 8'h23;
    IN1 = 8'hDC;
    OP = 4'b0101;
    #20 IN0 = 8'h24;
    #20 IN0 = 8'hFF;
    #20 OP = 4'b0000;
    #20 OP = 4'b0011;
    #20 OP = 4'b1001;
    #20 IN0 = 8'h2A;
    OP = 4'b1010;
    #20 OP = 4'b0001;

    #20 $finish;
end

initial begin
    $dumpfile("tb_alu.vcd");
    $dumpvars(0, tb_alu);
    $dumpon;
end

endmodule