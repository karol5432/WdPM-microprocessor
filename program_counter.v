// -------------------- COUNTER --------------------
// counter module of WIDTH bits width

module program_counter(
	input RST,
	input CLK,
	output [WIDTH-1:0] DATA
);

parameter WIDTH = 4;

reg [WIDTH-1:0] DATA;

always @(posedge CLK) begin
	if(RST == 1) DATA <= 4'h0;
	else DATA <= DATA + 1;
end

endmodule // program_counter