// ext8.v

module EXT8 #(parameter WIDTH = 8)(
	input [WIDTH-1:0] i,
	input signal,		// 1 resprent for signed
	output [31:0] r
	);
	
	assign r = signal ? {{(32-WIDTH){i[WIDTH-1]}}, i} : {{(32-WIDTH){1'b0}}, i};

endmodule

