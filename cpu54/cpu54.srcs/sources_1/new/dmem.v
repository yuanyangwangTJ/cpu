// dmem.v

module DMEM(
	input clk,
	input ena,
	input wsignal,
	input rsignal,
	input byte,
	input halfword,
	input [31:0] addr,
	input [31:0] wdata,
	output [31:0] rdata
	);

	reg [31:0] data[2047:0];
	always @(posedge clk) begin
		if (ena && wsignal) begin
			if (byte) begin
				data[addr][7:0] <= wdata[7:0];
			end else if (halfword) begin
				data[addr][15:0] <= wdata[15:0];
			end else begin
				data[addr] <= wdata;	
			end
		end
	end

	assign rdata = (ena && rsignal) ? data[addr] : 32'hz;

endmodule