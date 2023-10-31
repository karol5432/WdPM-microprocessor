module alu(
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input [OP_WIDTH-1:0] OP,
	output [DATA_WIDTH-1:0] OUT
);

parameter DATA_WIDTH = 4;
parameter OP_WIDTH = 2;

reg [DATA_WIDTH-1:0] OUT;

always @(*) begin
	case(OP)
		2'b00: OUT <= IN0 + IN1;		// SUM
		2'b01: OUT <= IN0;				// IN0
		2'b10: OUT <= IN0 + 1'b1;		// INC IN0
		2'b11: OUT <= IN1;				// IN1
	endcase
end

endmodule // alu