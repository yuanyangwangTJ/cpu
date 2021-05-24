// ext1.v

module EXT1 #(parameter WIDTH = 1)(
	input i,
	output [31:0] r
	);
	
	assign r = {{(32-WIDTH){1'b0}}, i};

endmodule