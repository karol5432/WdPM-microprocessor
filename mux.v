// -------------------- MUX --------------------
// good one 2 on one

module mux2(
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input SEL,
	output [DATA_WIDTH-1:0] OUT
);

parameter DATA_WIDTH = 4;

reg [3:0] OUT;

always @(*) begin
	case(SEL)
		1'b0: OUT <= IN0;
		1'b1: OUT <= IN1;
	endcase
end

endmodule // mux2