// CP0.v
`timescale 1ns / 1ps

module CP0(
	input clk,
	input rst,
	input mfc0, 	// CPU 指令 Mfc0，读信号
	input mtc0, 	// CPU 指令 Mtc0，写信号
	input [31:0] pc,
	input [4:0] rd, 	// 指定 CP0 寄存器
	input [31:0] wdata, // 数据从 GP 寄存器到 CP0 寄存器
	input exception,
	input eret, 	// 指令 ERET(Exception Return)
	input [4:0] cause,

	output [31:0] rdata, 	// 数据从 CP0 寄存器到 GP 寄存器
	output [31:0] status,
	output [31:0] exc_addr 	// 异常起始地址
    );

	parameter 	STATUS = 12,
				CAUSE = 13,
				EPC = 14;

	reg [31:0] rf [31:0];

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			rf[0]<=32'b0;
            rf[1]<=32'b0;
            rf[2]<=32'b0;
            rf[3]<=32'b0;
            rf[4]<=32'b0;
            rf[5]<=32'b0;
            rf[6]<=32'b0;
            rf[7]<=32'b0;
            rf[8]<=32'b0;
            rf[9]<=32'b0;
            rf[10]<=32'b0;
            rf[11]<=32'b0;
            rf[12]<=32'b0000000011100000001;
            rf[13]<=32'b0;
            rf[14]<=32'b0;
            rf[15]<=32'b0;
            rf[16]<=32'b0;
            rf[17]<=32'b0;
            rf[18]<=32'b0;
            rf[19]<=32'b0;
            rf[20]<=32'b0;
            rf[21]<=32'b0;
            rf[22]<=32'b0;
            rf[23]<=32'b0;
            rf[24]<=32'b0;
            rf[25]<=32'b0;
            rf[26]<=32'b0;
            rf[27]<=32'b0;
            rf[28]<=32'b0;
            rf[29]<=32'b0;
            rf[30]<=32'b0;
            rf[31]<=32'b0;
		end else begin
			if (mtc0) rf[rd] <= wdata;
			if (exception) begin
				rf[EPC] <= pc - 32'h4;
				rf[STATUS] <= rf[STATUS] << 5;
				rf[CAUSE][6:2] <= cause;
			end else if (eret) begin
				rf[STATUS] <= rf[STATUS] >> 5;
			end
		end
	end

	assign exc_addr = rf[EPC];
	assign status = rf[STATUS];
	assign rdata = mfc0 ? rf[rd] : 32'bz;
	
endmodule
