module ram_mem(
    input CLK,
    input CE,
    input [ADDR_WIDTH-1:0] ADDR,
	input [WIDTH-1:0] DATA_IN,
	output reg [WIDTH-1:0] DATA_OUT
);

parameter ADDR_WIDTH = 4;
parameter WIDTH = 8;

reg [WIDTH-1:0] MEM [0:(2**ADDR_WIDTH)-1];

always @(posedge CLK) begin
    if(CE) MEM[ADDR] <= DATA_IN;
    DATA_OUT <= MEM[ADDR];
end

// initial begin
//     $readmemb("ram_test.mem", MEM);
// end

endmodule // ram_mem