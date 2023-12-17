module memory(
    input [ADDR_WIDTH-1:0] ADDR,
	output reg [WIDTH-1:0] DATA
);

parameter ADDR_WIDTH = 5;
parameter WIDTH = 16;

reg [WIDTH-1:0] MEM [0:(2**ADDR_WIDTH)-1];

always @(ADDR) DATA <= MEM[ADDR];

initial begin
    $readmemb("rom.mem", MEM);
end

endmodule // memory