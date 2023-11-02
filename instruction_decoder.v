// -------------------- INSTRUCTION DECODER --------------------
// idk mb i aint good at this, need mo booze

module instruction_decoder(
	input [INSTR_WIDTH-1:0] INSTRUCTION,
	output reg RESET_INSTR,
	output reg SEL,
	output reg CE_R0,
	output reg CE_ACC,
	output reg [OP_WIDTH-1:0] OP
);

parameter INSTR_WIDTH = 4;
parameter OP_WIDTH = 4;

always @(*) begin
	case(INSTRUCTION)
	//					RESET SEL CE(reg) CE(acc) inst1 inst0
		4'h0: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010000; // NOT
		4'h1: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010001; // XOR
		4'h2: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010010; // OR
		4'h3: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010011; // AND
		4'h4: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010100; // SUB
		4'h5: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010101; // ADD R
		4'h6: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010110; // RR
		4'h7: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00010111; // RL
		4'h8: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00011000; // DEC
		4'h9: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00011001; // INC
		4'hA: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00011011; // LD R
		4'hB: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00101010; // ST R
		4'hC: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b00001010; // NOP
		4'hD: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b01011010; // LDI
		4'hE: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b10001010; // RST
		4'hF: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 8'b10001010; // RST
	endcase
end

endmodule // instruction_decoder