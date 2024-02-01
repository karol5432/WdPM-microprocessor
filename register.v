// -------------------- REGISTERS --------------------
// only one

`timescale 1ns/1ns

module register #(
	parameter DATA_WIDTH = 8) (
	input [DATA_WIDTH-1:0] IN,
	input CLK,
	input CE,
	input nRST,
	output reg [DATA_WIDTH-1:0] OUT
);

always @(posedge CLK or negedge nRST) begin
	// if(RST == 1'b1) OUT <= 1'b0; // needed for sim when there are none ldi instructions
	// else begin
		// if(CE == 1'b0) OUT <= OUT;
		// else OUT <= IN;
		if(!nRST) OUT <= 0;
		else if(CE) OUT <= IN;
	// end
end

endmodule // register