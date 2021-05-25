`timescale 1ns / 1ps

module cpu31_tb;

	reg clk, rst;
	reg [31:0] inst, rdata;
	wire [31:0] pc, addr, wdata;
	wire ena, we, re;
	wire [31:0] icode;
	assign icode = cpu.icode;

	initial begin
		clk <= 1'b1;
		rst <= 1'b1;
		inst <= 32'b001111_00000_00001_0000_0000_0000_1111;
		#20 rst <= 1'b0;
	end

	always begin
		clk <= ~clk;
	end

	CPU31 cpu(clk, rst, inst, rdata, pc, addr, wdata, ena, we, re);


endmodule
