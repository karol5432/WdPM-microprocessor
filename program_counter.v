// -------------------- COUNTER --------------------
// counter module of WIDTH bits width

`timescale 1ns/1ns

module program_counter(
	input nRST,
	input CLK,
	input CE,
	input [WIDTH-1:0] IN,
	output reg [WIDTH-1:0] DATA
);

parameter WIDTH = 6;

always @(posedge CLK) begin
	if(!nRST) DATA <= 0;
	else if (CE) DATA <= IN;
	else DATA <= DATA + 1;
end

endmodule // program_counter