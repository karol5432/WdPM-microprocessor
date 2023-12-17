// -------------------- MUX --------------------
// good one 4 on one

module mux4(
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input [DATA_WIDTH-1:0] IN2,
	input [DATA_WIDTH-1:0] IN3,
	input [1:0] SEL,
	output reg [DATA_WIDTH-1:0] OUT
);

parameter DATA_WIDTH = 8;

always @(*) begin
	case(SEL)
		2'b00: OUT <= IN0;
		2'b01: OUT <= IN1;
		2'b10: OUT <= IN2;
		2'b11: OUT <= IN3;
	endcase
end

endmodule // mux4