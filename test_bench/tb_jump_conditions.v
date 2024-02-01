`include "../jump_conditions.v"
`timescale 1ns/1ps

module tb_jump_conditions();

reg [1:0] JUMP;
reg ZF;
wire CE_PC;

jump_conditions jmp(
    .JUMP(JUMP),
    .ZF(ZF),
    .CE_PC(CE_PC)
);

initial begin
    JUMP = 2'b00;
    ZF = 1'b0;
    #20 JUMP = 2'b01;
    #20 JUMP = 2'b10;
    #20 JUMP = 2'b11;
    #20 ZF = 1'b1;
    #20 JUMP = 2'b00;
    #20 JUMP = 2'b01;
    #20 JUMP = 2'b10;
    #20 JUMP = 2'b11;
    #20 $finish;
end

initial begin
    $dumpfile("tb_jump_conditions.vcd");
    $dumpvars(0, tb_jump_conditions);
    $dumpon;
end

endmodule // tb_jump_conditions