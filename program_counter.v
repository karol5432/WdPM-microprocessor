// -------------------- COUNTER --------------------
// counter module of WIDTH bits width

module program_counter(
	input RST,
	input CLK,
	input CE,
	input [WIDTH-1:0] IN,
	output reg [WIDTH-1:0] DATA
);

parameter WIDTH = 5;

always @(posedge CLK) begin
	if(RST) DATA <= 5'h0;
	else if (CE) DATA <= IN;
	else DATA <= DATA + 1;
end

endmodule // program_counter