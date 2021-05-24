// ext16.v

module EXT16 #(parameter WIDTH = 16)(
	input [WIDTH-1:0] i,
	input signal,		// 1 resprent for signed
	output [31:0] r
	);
	
	assign r = signal ? {{(32-WIDTH){i[WIDTH-1]}}, i} : {{(32-WIDTH){1'b0}}, i};

endmodule