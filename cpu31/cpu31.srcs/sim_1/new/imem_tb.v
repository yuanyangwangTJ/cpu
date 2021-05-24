module imem_tb;

	reg [10:0] addr;
	wire [31:0] instr;

	initial begin
		addr <= 0;
	end

	always begin
		#20 addr <= addr + 1;
	end

	IMEM imem(.addr(addr), .instr(instr)
		);

endmodule