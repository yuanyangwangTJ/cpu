// dmem.v

module DMEM(
	input clk,
	input ena,
	input wsignal,
	input rsignal,
	input [10:0] addr,
	input [31:0] wdata,
	output [31:0] rdata
	);

	reg [31:0] data[31:0];
	always @(posedge clk) begin
		if (ena && wsignal) begin
			data[addr] <= wdata;
		end
	end

	assign rdata = (ena && rsignal) ? data[addr] : 32'hz;

endmodule