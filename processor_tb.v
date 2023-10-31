module processor_tb();

reg clk, reset;
wire [3:0] acc_out;

wire rst;
wire [3:0] bits;
wire [3:0] id_bus;
wire [3:0] alu_out;
wire [3:0] reg_wy;
wire [4:0] decoded;
wire [3:0] to_alu;
wire [3:0] imm_val;

program_counter licznik(
	.rst(rst | reset),
	.clk(~clk),
	.data(bits)
);

rom16x8 pamiec(
	.addr(bits),
	.data({id_bus, imm_val})
);

instruction_decoder id(
	.instr(id_bus),
	.decoded(decoded),
	.reset(rst)
);

alu jedn(
	.in1(acc_out),
	.in2(reg_wy),
	.out(alu_out),
	.op(decoded[1:0])
);

register akumulator(
	.in(to_alu),
	.out(acc_out),
	.ce(decoded[2]),
	.clk(~clk)
);

register rejestr(
	.in(alu_out),
	.out(reg_wy),
	.ce(decoded[3]),
	.clk(~clk)
);

mux2bit4 mux(
	.in1(acc_out),
	.in2(imm_val),
	.out(to_alu),
	.sel(decoded[4])
);

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
	reset = 1'b1;
	#10 reset = 1'b0;
    #300 $finish;
end

initial begin
	$dumpfile("processor_tb.vcd");
	$dumpvars(0, processor_tb);
	$dumpon;
end

endmodule