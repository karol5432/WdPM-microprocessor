// -------------------- MUX --------------------
// good one 8 on one

`timescale 1ns/1ns

module mux8 #(
	parameter DATA_WIDTH = 8) (
	input [DATA_WIDTH-1:0] IN0,
	input [DATA_WIDTH-1:0] IN1,
	input [DATA_WIDTH-1:0] IN2,
	input [DATA_WIDTH-1:0] IN3,
	input [DATA_WIDTH-1:0] IN4,
	input [DATA_WIDTH-1:0] IN5,
	input [DATA_WIDTH-1:0] IN6,
	input [DATA_WIDTH-1:0] IN7,
	input [2:0] SEL,
	output reg [DATA_WIDTH-1:0] OUT
);

always @(*) begin
	case(SEL)
		3'b000: OUT <= IN0;
		3'b001: OUT <= IN1;
		3'b010: OUT <= IN2;
		3'b011: OUT <= IN3;
		3'b100: OUT <= IN4;
		3'b101: OUT <= IN5;
		3'b110: OUT <= IN6;
		3'b111: OUT <= IN7;
	endcase
end

endmodule // mux8