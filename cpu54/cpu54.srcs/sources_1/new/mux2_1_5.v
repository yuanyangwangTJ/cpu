// mux2_1_5.v

module MUX2_1_5(
	input [4:0] a,
	input [4:0] b,
	input ctrl,
	output [4:0] o
	);

	assign o = ctrl ? b : a;

endmodule
