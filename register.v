// -------------------- REGISTERS --------------------
// only one

module register(
	input [WIDTH-1:0] IN,
	input CLK,
	input CE,
	// input RST,
	output [WIDTH-1:0] OUT
);

parameter WIDTH = 4;

reg [WIDTH-1:0] OUT;

always @(posedge CLK) begin
	// if(RST == 1'b1) OUT <= 1'b0; // needed for sim when there are none ldi instructions
	// else begin
		if(CE == 1'b0) OUT <= OUT;
		else OUT <= IN;
	// end
end

endmodule // register