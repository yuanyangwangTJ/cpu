// pcreg.v

module PCReg(
	input clk,
	input rst,
	input ena,
	input [31:0] data_in,
	output reg [31:0] data_out 
	);

	always @(posedge clk or posedge rst) begin
		if (ena) begin
			if (rst) begin
				data_out <= 32'h0040_0000;
			end
			else begin
				data_out <= data_in;
			end
		end
		else begin
			data_out <= 32'hz;
		end
	end

endmodule
