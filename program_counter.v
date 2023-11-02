// -------------------- COUNTER --------------------
// counter module of WIDTH bits width

module program_counter(
	input RST,
	input CLK,
	output reg [WIDTH-1:0] DATA
);

parameter WIDTH = 4;

always @(posedge CLK) begin
	if(RST == 1) DATA <= 4'h0;
	else DATA <= DATA + 1;
end

endmodule // program_counter