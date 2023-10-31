// -------------------- ROM --------------------
// 16 cells of f8 bit DATA

module rom16x8(
	input [ADDR_WIDTH-1:0] ADDR,
	output [WIDTH-1:0] DATA
);

parameter WIDTH = 8;
parameter ADDR_WIDTH = 4;

reg [WIDTH-1:0] DATA;

always @(*) begin
	case(ADDR)
		4'h0: DATA <= 8'hC0; // nop				0	0
		4'h1: DATA <= 8'hD2; // ldi 2			1	0
		// 4'h1: DATA <= 8'h90; // inc A			1	0
		4'h2: DATA <= 8'h90; // inc A			2	0
		4'h3: DATA <= 8'h90; // inc A			3	0
		4'h4: DATA <= 8'hB0; // ST R			3	3
		4'h5: DATA <= 8'h90; // inc A			4	3
		4'h6: DATA <= 8'h90; // inc A			5	3
		4'h7: DATA <= 8'h50; // add R			8	3
		4'h8: DATA <= 8'h90; // inc A			9	3
		4'h9: DATA <= 8'h90; // inc A			A	3
		4'hA: DATA <= 8'hA0; // LD R			3	3
		4'hB: DATA <= 8'h50; // add R			6	3
		4'hC: DATA <= 8'h90; // inc A			7	3
		4'hD: DATA <= 8'h90; // inc A			8	3
		4'hE: DATA <= 8'hE0; // rst				8	3
		4'hF: DATA <= 8'hC0;
	endcase
end

endmodule // rom16x8