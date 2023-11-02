module alu(
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input [OP_WIDTH-1:0] OP,
	output reg [DATA_WIDTH-1:0] OUT
);

parameter DATA_WIDTH = 8;
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
		default: OUT <= IN0;
	endcase
end

endmodule // alu