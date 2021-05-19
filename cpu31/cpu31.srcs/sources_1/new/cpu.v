// cpu.v

module CPU31(
	input clk,
	input rst,
	input [31:0] IM_inst,
	input [31:0] DM_rdata,
	output [31:0] pc,
	output [31:0] DM_addr,
	output [31:0] DM_wdata,
	output DM_ena,
	output DM_wsignal,
	output DM_rsignal

	);


endmodule