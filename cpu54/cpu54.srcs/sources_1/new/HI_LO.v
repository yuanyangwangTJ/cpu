// CPU HI_LO 寄存器
`timescale 1ns / 1ps

module HI_LO(
	input clk,
	input rst,
	input we,
	input ena,
	input [31:0] iData,

	output [31:0] oData
    );

	reg [31:0] data;
	always @(posedge clk or posedge rst) begin
		if (rst) data <= 0;
		else begin
			if (ena && we) data <= iData;
		end
	end
	assign oData = ena ? data:32'bz;
endmodule
