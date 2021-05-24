// mux2_1_1.v

module MUX2_1_1(
	input a,
	input b,
	input ctrl,
	output o
	);

	assign o = ctrl ? b : a;

endmodule
