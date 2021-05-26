`timescale 1ns / 1ps

module sccomp_dataflow(
	input clk_in,
	input reset,
	output [31:0] inst,
	output [31:0] pc
    );
	
	wire DM_ena, DM_we, DM_re;
	wire [31:0] DM_wd, DM_rd;
	wire [10:0] IM_addr, DM_addr;
	wire [31:0] res;

	assign IM_addr = (pc - 32'h0040_0000) / 4;
	assign DM_addr = (res - 32'h1001_0000) / 4;

	IMEM imem(
		.addr(IM_addr), .instr(inst)
		);

	DMEM dmem(
		.clk(clk_in), .ena(DM_ena), .wsignal(DM_we), .rsignal(DM_re),
		.addr(DM_addr), .wdata(DM_wd), .rdata(DM_rd)
		);

	cpu sccpu(
		.clk(clk_in), .rst(reset), .IM_inst(inst), .pc(pc),
		.DM_rdata(DM_rd), .DM_addr(res), .DM_wdata(DM_wd),
		.DM_ena(DM_ena), .DM_we(DM_we), .DM_re(DM_re)
		);

endmodule
