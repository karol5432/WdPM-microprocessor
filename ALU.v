`timescale 1ns/1ns

module ALU #(
	parameter DATA_WIDTH = 8) (
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input [OP_WIDTH-1:0] OP,
	output reg ZF,
	output reg [DATA_WIDTH-1:0] OUT
);

parameter OP_WIDTH = 4;

always @(*) begin
	case(OP)
		4'b0000: OUT <= ~IN0;			// NOT
		4'b0001: OUT <= IN0 ^ IN1;		// XOR
		4'b0010: OUT <= IN0 | IN1;		// OR
		4'b0011: OUT <= IN0 & IN1;		// AND
		4'b0100: OUT <= IN0 - IN1;		// SUB
		4'b0101: OUT <= IN0 + IN1;		// ADD
		4'b0110: OUT <= IN0 >> 1;		// RR
		4'b0111: OUT <= IN0 << 1;		// RL
		4'b1000: OUT <= IN0 - 1'b1;		// DEC
		4'b1001: OUT <= IN0 + 1'b1;		// INC
		4'b1010: OUT <= IN0;			// IN0
		4'b1011: OUT <= IN1;			// IN1
		4'b1100: OUT <= ~(IN0 ^ IN1);	// XNOR
		default: OUT <= IN0;
	endcase
end

always @(OUT, OP) begin
	case(OP)
		4'b0000: ZF <= ~|OUT; // NOT
		4'b0001: ZF <= ~|OUT; // XOR
		4'b0010: ZF <= ~|OUT; // OR
		4'b0011: ZF <= ~|OUT; // AND
		4'b0100: ZF <= ~|OUT; // SUB
		4'b0101: ZF <= ~|OUT; // ADD
		4'b0110: ZF <= ~|OUT; // RR
		4'b0111: ZF <= ~|OUT; // RL
		4'b1000: ZF <= ~|OUT; // DEC
		4'b1001: ZF <= ~|OUT; // INC
		4'b1100: ZF <= ~|OUT; // XNOR
		default: ZF <= ZF;
	endcase
end

endmodule // ALU