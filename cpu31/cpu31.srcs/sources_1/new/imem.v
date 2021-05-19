// imem.v

module IMEM(
	input [10:0] addr,
	output [31:0] instr
	);

	imem imem(
		.a(addr),
		.spo(instr)
		);

endmodule