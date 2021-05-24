// mux2_1.v

module MUX2_1(
	input [31:0] a,
	input [31:0] b,
	input ctrl,
	output [31:0] o
	);

	assign o = ctrl ? b : a;

endmodule