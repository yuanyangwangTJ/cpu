// imem.v

module IMEM(
	input [10:0] addr,
	output [31:0] instr
	);

	mips_imem imem(
		.a(addr),
		.spo(instr)
		);

endmodule