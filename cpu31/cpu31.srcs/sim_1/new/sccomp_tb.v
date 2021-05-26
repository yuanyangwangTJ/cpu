`timescale 1ns / 1ps

module sccomp_tb;
	
	reg clk, rst;
	wire [31:0] inst, pc;
	reg [31:0] count;
	wire [31:0] icode, D_EXT16;
	assign icode = sc.sccpu.icode;
	assign D_EXT16 = sc.sccpu.D_EXT16;
	wire [31:0] D_ALU = sc.sccpu.D_ALU;
	wire [31:0] D_MUX6 = sc.sccpu.D_MUX6;
	wire [31:0] D_MUX = sc.sccpu.D_MUX;
	wire M6 = sc.sccpu.M6;
	wire [31:0] DM_rd = sc.DM_rd;
	wire [4:0] D_MUX7 = sc.sccpu.D_MUX7;
	wire [1:0] M = sc.sccpu.M;
	wire [31:0] D_ADD8 = sc.sccpu.D_ADD8;

	integer file_open;
	initial begin
		clk <= 1'b0;
		rst <= 1'b1;
		count <= 0;
		file_open = $fopen("D://output.txt", "w");
		#20 rst <= 1'b0;
		
	end

	always begin
        #10 clk = ~clk;
    end


	always @(posedge clk) begin
		count <= count + 1'b1;

		$fdisplay(file_open, "regfile0: %h", sc.sccpu.cpu_ref.array_reg[0]);
		$fdisplay(file_open, "regfile1: %h", sc.sccpu.cpu_ref.array_reg[1]);
		$fdisplay(file_open, "regfile2: %h", sc.sccpu.cpu_ref.array_reg[2]);
		$fdisplay(file_open, "regfile3: %h", sc.sccpu.cpu_ref.array_reg[3]);
		$fdisplay(file_open, "regfile4: %h", sc.sccpu.cpu_ref.array_reg[4]);
		$fdisplay(file_open, "regfile5: %h", sc.sccpu.cpu_ref.array_reg[5]);
		$fdisplay(file_open, "regfile6: %h", sc.sccpu.cpu_ref.array_reg[6]);
		$fdisplay(file_open, "regfile7: %h", sc.sccpu.cpu_ref.array_reg[7]);
		$fdisplay(file_open, "regfile8: %h", sc.sccpu.cpu_ref.array_reg[8]);
		$fdisplay(file_open, "regfile9: %h", sc.sccpu.cpu_ref.array_reg[9]);
		$fdisplay(file_open, "regfile10: %h", sc.sccpu.cpu_ref.array_reg[10]);
		$fdisplay(file_open, "regfile11: %h", sc.sccpu.cpu_ref.array_reg[11]);
		$fdisplay(file_open, "regfile12: %h", sc.sccpu.cpu_ref.array_reg[12]);
		$fdisplay(file_open, "regfile13: %h", sc.sccpu.cpu_ref.array_reg[13]);
		$fdisplay(file_open, "regfile14: %h", sc.sccpu.cpu_ref.array_reg[14]);
		$fdisplay(file_open, "regfile15: %h", sc.sccpu.cpu_ref.array_reg[15]);
		$fdisplay(file_open, "regfile16: %h", sc.sccpu.cpu_ref.array_reg[16]);
		$fdisplay(file_open, "regfile17: %h", sc.sccpu.cpu_ref.array_reg[17]);
		$fdisplay(file_open, "regfile18: %h", sc.sccpu.cpu_ref.array_reg[18]);
		$fdisplay(file_open, "regfile19: %h", sc.sccpu.cpu_ref.array_reg[19]);
		$fdisplay(file_open, "regfile20: %h", sc.sccpu.cpu_ref.array_reg[20]);
		$fdisplay(file_open, "regfile21: %h", sc.sccpu.cpu_ref.array_reg[21]);
		$fdisplay(file_open, "regfile22: %h", sc.sccpu.cpu_ref.array_reg[22]);
		$fdisplay(file_open, "regfile23: %h", sc.sccpu.cpu_ref.array_reg[23]);
		$fdisplay(file_open, "regfile24: %h", sc.sccpu.cpu_ref.array_reg[24]);
		$fdisplay(file_open, "regfile25: %h", sc.sccpu.cpu_ref.array_reg[25]);
		$fdisplay(file_open, "regfile26: %h", sc.sccpu.cpu_ref.array_reg[26]);
		$fdisplay(file_open, "regfile27: %h", sc.sccpu.cpu_ref.array_reg[27]);
		$fdisplay(file_open, "regfile28: %h", sc.sccpu.cpu_ref.array_reg[28]);
		$fdisplay(file_open, "regfile29: %h", sc.sccpu.cpu_ref.array_reg[29]);
		$fdisplay(file_open, "regfile30: %h", sc.sccpu.cpu_ref.array_reg[30]);
		$fdisplay(file_open, "regfile31: %h", sc.sccpu.cpu_ref.array_reg[31]);

		$fdisplay(file_open, "pc: %h", sc.pc);
		$fdisplay(file_open, "instr: %h", sc.inst);
		
	end

	sccomp_dataflow sc(
		.clk_in(clk), .reset(rst),
		.inst(inst), .pc(pc)
		);

endmodule
