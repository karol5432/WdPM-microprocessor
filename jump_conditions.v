`timescale 1ns/1ns

module jump_conditions (
    input [1:0] JUMP,
    input ZF,
    output CE_PC
);

assign CE_PC = ZF && JUMP[0] || ~ZF && JUMP[1];

/* Jump conditions:
JUMP =
        00  no jump
        01  JZ
        10  JNZ
        11  JMP (unconditional)
*/

endmodule // jump_conditions