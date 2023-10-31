// -------------------- ROM --------------------
// 16 cells of f8 bit DATA

module rom16x8(
	input [ADDR_WIDTH-1:0] ADDR,
	output [WIDTH-1:0] DATA
);

parameter WIDTH = 12;
parameter ADDR_WIDTH = 4;

reg [WIDTH-1:0] DATA;

always @(*) begin
	case(ADDR)
		4'h0: DATA <= 12'hC00; // nop				0	0
		4'h1: DATA <= 12'hD20; // ldi 2			1	0
		// 4'h1: DATA <= 12'h90; // inc A			1	0
		4'h2: DATA <= 12'h900; // inc A			2	0
		4'h3: DATA <= 12'h900; // inc A			3	0
		4'h4: DATA <= 12'hB00; // ST R			3	3
		4'h5: DATA <= 12'h900; // inc A			4	3
		4'h6: DATA <= 12'h900; // inc A			5	3
		4'h7: DATA <= 12'h500; // add R			8	3
		4'h8: DATA <= 12'h900; // inc A			9	3
		4'h9: DATA <= 12'h900; // inc A			A	3
		4'hA: DATA <= 12'hA00; // LD R			3	3
		4'hB: DATA <= 12'h500; // add R			6	3
		4'hC: DATA <= 12'h900; // inc A			7	3
		4'hD: DATA <= 12'h900; // inc A			8	3
		4'hE: DATA <= 12'hE00; // rst				8	3
		4'hF: DATA <= 12'hC00;
	endcase
end

endmodule // rom16x8