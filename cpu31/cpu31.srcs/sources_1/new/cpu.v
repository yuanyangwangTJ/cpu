// cpu.v

module cpu(
	input clk,
	input rst,
	input [31:0] IM_inst,
	input [31:0] DM_rdata,
	output [31:0] pc,
	output [31:0] DM_addr,
	output [31:0] DM_wdata,
	output DM_ena,
	output DM_we,
	output DM_re
	);

	wire PC_clk, PC_ena;
	wire M1, M2, M3, M4, M5, M6;
	wire [1:0] M, M7;
	wire [3:0] ALUC;
	wire EXT16_s, zero, carry, negative, overflow;
	wire RF_clk, RF_we, RF_ena;
	wire [31:0] icode;
	wire [31:0] D_PC, D_ALU, D_EXT5, D_EXT16, D_EXT18;
	wire [31:0] D_MUX1, D_MUX2, D_MUX4, D_MUX5, D_MUX6, D_MUX;
	wire [31:0] D_NPC, D_ADD, D_ADD8, D_II;
	wire [31:0] D_Rs, D_Rt;
	wire [4:0] D_MUX3, D_MUX7;
	wire [4:0] GR_addr1, GR_addr2; 	// 31 register

	assign pc = D_PC;
	assign DM_addr = D_ALU;
	assign DM_wdata = D_Rt;
	assign GR_addr1 = 5'b11111;
	assign GR_addr2 = 5'b11111;

	InstrDecode cpu_inst(
		.instr_raw(IM_inst),
		.instr_code(icode)
		);

	Controller cpu_control(
		.clk(clk), .z(zero), .icode(icode), .PC_clk(PC_clk), .PC_ena(PC_ena),
		.M1(M1), .M2(M2), .M3(M3), .M4(M4), .M5(M5), 
		.M6(M6), .M7(M7), .M(M),
		.ALUC(ALUC), .RF_ena(RF_ena), .RF_we(RF_we), .RF_clk(RF_clk),
		.DM_ena(DM_ena), .DM_we(DM_we), .DM_re(DM_re), .EXT16_s(EXT16_s)
		);

	PCReg cpu_pc(
		.clk(PC_clk), .rst(rst), .ena(PC_ena),
		.data_in(D_MUX2), .data_out(D_PC)
		);

	NPC cpu_npc(
		.pc(D_PC), .npc(D_NPC)
		);

	ALU cpu_alu(
		.a(D_MUX5), .b(D_MUX6), .aluc(ALUC), .r(D_ALU),
		.zero(zero), .carry(carry), .negative(negative), .overflow(overflow)
		);

	regfile cpu_ref(
		.clk(RF_clk), .ena(RF_ena), .rst(rst), .we(RF_we),
		.Rsc(IM_inst[25:21]), .Rtc(IM_inst[20:16]), .Rdc(D_MUX7),
		.Rd(D_MUX), .Rs(D_Rs), .Rt(D_Rt)
		);

	MUX2_1 cpu_mux1(
		.a(D_NPC), .b(D_II),
		.ctrl(M1), .o(D_MUX1)
		);
	MUX2_1 cpu_mux2(
	.a(D_MUX1), .b(D_MUX4),
	.ctrl(M2), .o(D_MUX2)
	);

	MUX2_1_5 cpu_mux3(
		.a(IM_inst[10:6]), .b(D_Rs[4:0]),
		.ctrl(M3), .o(D_MUX3)
		);

	MUX2_1 cpu_mux4(
		.a(D_ADD), .b(D_Rs),
		.ctrl(M4), .o(D_MUX4)
		);

	MUX2_1 cpu_mux5(
		.a(D_Rs), .b(D_EXT5),
		.ctrl(M5), .o(D_MUX5)
		);

	MUX2_1 cpu_mux6(
		.a(D_Rt), .b(D_EXT16),
		.ctrl(M6), .o(D_MUX6)
		);

	MUX4_1_5 cpu_mux7(
		.a(IM_inst[15:11]), .b(IM_inst[20:16]), .c(GR_addr1), .d(GR_addr2),
		.ctrl(M7), .o(D_MUX7)
		);

	MUX4_1 cpu_mux(
		.a(D_ALU), .b(DM_rdata), .c(D_ADD8), .d(D_ALU),
		.ctrl(M), .o(D_MUX)
		);

	Add cpu_add(
		.a(D_EXT18), .b(D_NPC), .r(D_ADD)
		);

	Add8 cpu_add8(
		.a(D_PC - 4), .r(D_ADD8)
		);

	II cpu_ii(
		.a(D_PC[31:28]), .b(IM_inst[25:0]), .r(D_II)
		);

	EXT5 cpu_ext5(
		.i(D_MUX3), .r(D_EXT5)
		);

	EXT16 cpu_ext16(
		.i(IM_inst[15:0]), .signal(EXT16_s), .r(D_EXT16)
		);

	EXT18 cpu_ext18(
		.i({IM_inst[15:0],{2'b00}}), .r(D_EXT18)
		);




endmodule