`timescale 1ns / 1ps

module top_tb;
	reg clk, rst;
	wire [31:0] inst, pc;
	// wire [31:0] ref, D_ALU, D_MUX, Rd, D_MUX2, D_Rs, D_MUX4, D_Rt;
	// wire [31:0] D_CP0, D_HI, D_MUX8, D_MUX1;
	// wire [53:0] icode;
	// wire [2:0] M, M8;
	// wire [1:0] M7,M1;
	// wire [4:0] D_MUX7, Rdc;
	// wire [63:0] D_MULT;
	// wire RF_we, M2, M4, HI_we, HI_ena, MULT_CS,start,busy;
	// wire [31:0] q,r;

	// assign icode = sc.icode;
	// assign ref = sc.cpu_ref.array_reg[1];
	// assign D_ALU = sc.D_ALU;
	// assign M = sc.M;
	// assign D_MUX = sc.D_MUX;
	// assign M7 = sc.M7;
	// assign D_MUX7 = sc.D_MUX7;
	// assign RF_we = sc.RF_we;
	// assign Rd = sc.cpu_ref.Rd;
	// assign Rdc = sc.cpu_ref.Rdc;
	// assign D_MUX2 = sc.D_MUX2;
	// assign D_Rs = sc.D_Rs;
	// assign D_Rt = sc.D_Rt;
	// assign M2 = sc.M2;
	// assign D_MUX4 = sc.D_MUX4;
	// assign M4 = sc.M4;
	// assign M8 = sc.M8;
	// assign HI_ena = sc.HI_ena;
	// assign HI_we = sc.HI_we;
	// assign D_MUX8 = sc.D_MUX8;
	// assign D_HI = sc.D_HI;
	// assign D_MULT = sc.D_MULT;
	// assign MULT_CS = sc.MULT_CS;
	// assign M1 = sc.M1;
	// assign D_MUX1 = sc.D_MUX1;
	// assign q = sc.D_DIV_q;
	// assign r = sc.D_DIV_r;
	// assign start = sc.DIV_start;
	// assign busy = sc.DIV_busy;

	// integer file_open;
	initial begin
		clk <= 1'b0;
		rst <= 1'b1;
		// file_open = $fopen("D://result.txt", "w");
		#225 rst <= 1'b0;
	end

	always begin
		#50 clk = ~clk;
		// if (clk == 1'b1 && rst == 0) begin
		// 	$fdisplay(file_open, "regfile0: %h", sc.cpu_ref.array_reg[0]);
		// 	$fdisplay(file_open, "regfile1: %h", sc.cpu_ref.array_reg[1]);
		// 	$fdisplay(file_open, "regfile2: %h", sc.cpu_ref.array_reg[2]);
		// 	$fdisplay(file_open, "regfile3: %h", sc.cpu_ref.array_reg[3]);
		// 	$fdisplay(file_open, "regfile4: %h", sc.cpu_ref.array_reg[4]);
		// 	$fdisplay(file_open, "regfile5: %h", sc.cpu_ref.array_reg[5]);
		// 	$fdisplay(file_open, "regfile6: %h", sc.cpu_ref.array_reg[6]);
		// 	$fdisplay(file_open, "regfile7: %h", sc.cpu_ref.array_reg[7]);
		// 	$fdisplay(file_open, "regfile8: %h", sc.cpu_ref.array_reg[8]);
		// 	$fdisplay(file_open, "regfile9: %h", sc.cpu_ref.array_reg[9]);
		// 	$fdisplay(file_open, "regfile10: %h", sc.cpu_ref.array_reg[10]);
		// 	$fdisplay(file_open, "regfile11: %h", sc.cpu_ref.array_reg[11]);
		// 	$fdisplay(file_open, "regfile12: %h", sc.cpu_ref.array_reg[12]);
		// 	$fdisplay(file_open, "regfile13: %h", sc.cpu_ref.array_reg[13]);
		// 	$fdisplay(file_open, "regfile14: %h", sc.cpu_ref.array_reg[14]);
		// 	$fdisplay(file_open, "regfile15: %h", sc.cpu_ref.array_reg[15]);
		// 	$fdisplay(file_open, "regfile16: %h", sc.cpu_ref.array_reg[16]);
		// 	$fdisplay(file_open, "regfile17: %h", sc.cpu_ref.array_reg[17]);
		// 	$fdisplay(file_open, "regfile18: %h", sc.cpu_ref.array_reg[18]);
		// 	$fdisplay(file_open, "regfile19: %h", sc.cpu_ref.array_reg[19]);
		// 	$fdisplay(file_open, "regfile20: %h", sc.cpu_ref.array_reg[20]);
		// 	$fdisplay(file_open, "regfile21: %h", sc.cpu_ref.array_reg[21]);
		// 	$fdisplay(file_open, "regfile22: %h", sc.cpu_ref.array_reg[22]);
		// 	$fdisplay(file_open, "regfile23: %h", sc.cpu_ref.array_reg[23]);
		// 	$fdisplay(file_open, "regfile24: %h", sc.cpu_ref.array_reg[24]);
		// 	$fdisplay(file_open, "regfile25: %h", sc.cpu_ref.array_reg[25]);
		// 	$fdisplay(file_open, "regfile26: %h", sc.cpu_ref.array_reg[26]);
		// 	$fdisplay(file_open, "regfile27: %h", sc.cpu_ref.array_reg[27]);
		// 	$fdisplay(file_open, "regfile28: %h", sc.cpu_ref.array_reg[28]);
		// 	$fdisplay(file_open, "regfile29: %h", sc.cpu_ref.array_reg[29]);
		// 	$fdisplay(file_open, "regfile30: %h", sc.cpu_ref.array_reg[30]);
		// 	$fdisplay(file_open, "regfile31: %h", sc.cpu_ref.array_reg[31]);
		// 	$fdisplay(file_open, "pc: %h", pc-32'h0040_0000);
		// 	$fdisplay(file_open, "instr: %h", inst);

		// end
	end

	sccomp_dataflow sc(
		clk, rst, inst, pc
		);


endmodule
