// -------------------- MUX --------------------
// good one 2 on one

`timescale 1ns/1ns

module mux2 #(
	parameter DATA_WIDTH = 8) (
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input SEL,
	output reg [DATA_WIDTH-1:0] OUT
);

always @(*) begin
	case(SEL)
		1'b0: OUT <= IN0;
		1'b1: OUT <= IN1;
	endcase
end

endmodule // mux2