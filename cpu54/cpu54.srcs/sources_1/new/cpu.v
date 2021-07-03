// cpu.v

module cpu(
	input clk,
	input reset,
	output [31:0] inst,
	output [31:0] pc
	);

	wire [53:0] icode;
	wire [31:0] D_NPC, D_PC, D_MUX1, D_MUX2, D_II, D_ADD8, D_MUX, D_MUX5, D_MUX6, D_ALU;
	wire [31:0] D_DM, D_CLZ, D_ADD, D_EXT5, D_EXT16, D_EXT18, D_CP0, D_EPC, D_Rs, D_Rt;
	wire [31:0] DM_rd, D_MUX8, D_MUX9, D_EXT8, D_EXT16_2, D_MUX10, D_MUX4;
	wire [4:0] D_MUX3, D_MUX7, CP0_cause;
	wire [3:0] ALUC;
	wire [1:0] M1, M6, M7, M10;
	wire [2:0] M8, M9, M;
	wire [31:0] DM_addr;
	wire M2, M3, M5, M4, DM_ena, DM_we, DM_re, DM_byte, DM_half, EXT16_s;
	wire DIV_start, DIV_busy, DIVU_start, DIVU_busy, HI_ena, HI_we, LO_we, LO_ena;
	wire CP0_mf, CP0_mt, CP0_eret, CP0_exc, EXT8_s, EXT16_s_2, RF_we, MULT_CS, MULTU_CS;
	wire [63:0] D_MULT, D_MULTU;
	wire [31:0] D_DIV_q, D_DIV_r, D_DIVU_q, D_DIVU_r, D_HI, D_LO;
	wire [31:0] D_CP0_STA;

	assign DM_addr = D_ALU - 32'h1001_0000;	// 考虑此地�?是否会溢�?
	assign pc = D_PC;

	IMEM imem(
		.a((pc - 32'h0040_0000) >> 2), .spo(inst)
		);

	DMEM dmem(
		.clk(clk), .ena(DM_ena), .wsignal(DM_we), .rsignal(DM_re),
		.byte(DM_byte), .halfword(DM_half),
		.addr(DM_addr), .wdata(D_Rt), .rdata(DM_rd)
		);

	InstrDecode cpu_inst(
		.instr_raw(inst), .instr_code(icode)
		);

	Controller cpu_control(
		.z(zero), .n(negative), .icode(icode), .DIV_busy(DIV_busy), .DIVU_busy(DIVU_busy),
		.M1(M1), .M2(M2), .M3(M3), .M4(M4),
		.M5(M5), .M6(M6), .M7(M7), .M8(M8), .M9(M9), .M10(M10), .M(M), .ALUC(ALUC),
		.RF_we(RF_we), .DM_ena(DM_ena), .DM_we(DM_we), .DM_re(DM_re), .DM_byte(DM_byte),
		.DM_half(DM_half), .EXT16_s(EXT16_s), .HI_ena(HI_ena), .HI_we(HI_we),
		.LO_ena(LO_ena), .LO_we(LO_we), .EXT8_s(EXT8_s), .EXT16_s_2(EXT16_s_2),
		.CP0_cause(CP0_cause), .CP0_mf(CP0_mf), .CP0_mt(CP0_mt), .MULT_CS(MULT_CS),
		.MULTU_CS(MULTU_CS), .DIV_start(DIV_start), .DIVU_start(DIVU_start),
		.CP0_exc(CP0_exc), .CP0_eret(CP0_eret)
		);

	PCReg cpu_pc(
		.clk(clk), .rst(reset), .ena(1'b1),
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
		.clk(clk), .ena(1'b1), .rst(reset), .we(RF_we),
		.Rsc(inst[25:21]), .Rtc(inst[20:16]), .Rdc(D_MUX7),
		.Rd(D_MUX), .Rs(D_Rs), .Rt(D_Rt)
		);

	Add8 cpu_add8(
		.a(D_PC - 4), .r(D_ADD8)
		);

	Add cpu_add(
		.a(D_EXT18), .b(D_NPC), .r(D_ADD)
		);

	II cpu_ii(
		.a(D_PC[31:28]), .b(inst[25:0]), .r(D_II)
		);

	MUX4_1_32 cpu_mux1(
		.a(D_NPC), .b(D_II), .c(D_EPC), .d(D_PC), .ctrl(M1), .o(D_MUX1)
		);

	MUX2_1_32 cpu_mux2(
		.a(D_MUX1), .b(D_MUX4), .ctrl(M2), .o(D_MUX2)
		);

	MUX2_1_5 cpu_mux3(
		.a(inst[10:6]), .b(D_Rs[4:0]), .ctrl(M3), .o(D_MUX3)
		);

	MUX2_1_32 cpu_mux4(
		.a(D_ADD), .b(D_Rs), .ctrl(M4), .o(D_MUX4)
		);

	MUX2_1_32 cpu_mux5(
		.a(D_Rs), .b(D_EXT5), .ctrl(M5), .o(D_MUX5)
		);

	MUX4_1_32 cpu_mux6(
		.a(D_Rt), .b(D_EXT16), .c(0), .d(0), .ctrl(M6), .o(D_MUX6)
		);

	MUX4_1_5 cpu_mux7(
		.a(inst[15:11]), .b(inst[20:16]), .c(31), .d(31),
		.ctrl(M7), .o(D_MUX7)
		);

	MUX8_1_32 cpu_mux8(
		.a(D_MULT[63:32]), .b(D_MULTU[63:32]), .c(D_DIV_r), .d(D_DIVU_r),
		.e(D_Rs), .f(32'bz), .g(32'bz), .h(32'bz), .ctrl(M8), .o(D_MUX8)
		);

	MUX8_1_32 cpu_mux9(
		.a(D_MULT[31:0]), .b(D_MULTU[31:0]), .c(D_DIV_q), .d(D_DIVU_q),
		.e(D_Rs), .f(32'bz), .g(32'bz), .h(32'bz), .ctrl(M9), .o(D_MUX9)	
		);

	MUX4_1_32 cpu_mux10(
		.a(D_HI), .b(D_LO), .c(D_MULT[31:0]), .d(32'bz), .ctrl(M10), .o(D_MUX10)
		);

	MUX8_1_32 cpu_mux(
		.a(D_ALU), .b(DM_rd), .c(D_ADD8), .d(D_CLZ), .e(D_CP0), .f(D_EXT8),
		.g(D_EXT16_2), .h(D_MUX10), .ctrl(M), .o(D_MUX)
		);

	MULT cpu_mult(
		.clk(clk), .reset(reset), .cs(MULT_CS), .a(D_Rs), .b(D_Rt), .z(D_MULT)
		);

	MULTU cpu_multu(
		.clk(clk), .reset(reset), .cs(MULTU_CS), .a(D_Rs), .b(D_Rt), .z(D_MULTU)
		);

	DIV cpu_div(
		.dividend(D_Rs), .divisor(D_Rt), .start(DIV_start), .clock(clk),
		.reset(reset), .q(D_DIV_q), .r(D_DIV_r), .busy(DIV_busy)
		);

	DIVU cpu_divu(
		.dividend(D_Rs), .divisor(D_Rt), .start(DIVU_start), .clock(clk),
		.reset(reset), .q(D_DIVU_q), .r(D_DIVU_r), .busy(DIVU_busy)
		);

	HI_LO HI(
		.clk(clk), .rst(reset), .we(HI_we), .ena(HI_ena), .iData(D_MUX8), .oData(D_HI)
		);

	HI_LO LO(
		.clk(clk), .rst(reset), .we(LO_we), .ena(LO_ena), .iData(D_MUX9), .oData(D_LO)
		);

	CP0 cpu_cp0(
		.clk(clk), .rst(reset), .mfc0(CP0_mf), .mtc0(CP0_mt), .pc(D_PC), .rd(inst[15:11]),
		.wdata(D_Rt), .exception(CP0_exc), .eret(CP0_eret), .cause(CP0_cause), 
		.rdata(D_CP0), .status(D_CP0_STA), .exc_addr(D_EPC)
		);

	CLZ cpu_clz(
		.in(D_MUX5), .out(D_CLZ)
		);

	EXT5 cpu_ext5(
		.i(D_MUX3), .r(D_EXT5)
		);

	EXT16 cpu_ext16(
		.i(inst[15:0]), .signal(EXT16_s), .r(D_EXT16)
		);

	EXT18 cpu_ext18(
		.i({inst[15:0],{2'b00}}), .r(D_EXT18)
		);

	// lb, lbu 扩展
	EXT8 cpu_ext8(
		.i(DM_rd[7:0]), .signal(EXT8_s), .r(D_EXT8)
		);

	// lh, lhu 扩展
	EXT16 cpu_ext16_2(
		.i(DM_rd[15:0]), .signal(EXT16_s_2), .r(D_EXT16_2)
		);


endmodule