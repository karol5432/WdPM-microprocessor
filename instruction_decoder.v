// -------------------- INSTRUCTION DECODER --------------------
// idk mb i aint good at this, need mo booze

module instruction_decoder(
	input [INSTR_WIDTH-1:0] INSTRUCTION,
	output RESET_INSTR,
	output SEL,
	output CE_R0,
	output CE_ACC,
	output [OP_WIDTH-1:0] OP
);

parameter INSTR_WIDTH = 4;
parameter OP_WIDTH = 2;

reg RESET_INSTR;
reg SEL;
reg CE_R0;
reg CE_ACC;
reg [OP_WIDTH-1:0] OP;

always @(*) begin
	case(INSTRUCTION)
	//					RESET SEL CE(reg) CE(acc) inst1 inst0
		4'h0: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000001; // -NOT
		4'h1: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000010; // -XOR
		4'h2: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000011; // -OR
		4'h3: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000100; // -AND
		4'h4: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000101; // -SUB
		4'h5: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000100; // ADD R
		4'h6: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000111; // -RR
		4'h7: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b001000; // -RL
		4'h8: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b001001; // -DEC
		4'h9: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000110; // INC
		4'hA: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000111; // LD
		4'hB: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b001001; // ST
		4'hC: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b000010; // NOP
		4'hD: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b010101; // LDI
		4'hE: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b100010; // RST
		4'hF: {RESET_INSTR, SEL, CE_R0, CE_ACC, OP[OP_WIDTH-1:0]} <= 6'b100010; // RST
	endcase
end

endmodule // instruction_decoder