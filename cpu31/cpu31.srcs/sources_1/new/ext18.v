// ext18.v

module EXT18 #(parameter WIDTH = 18)(
	input [WIDTH-1:0] i,
	output [31:0] r
	);
	
	assign r = {{(32-WIDTH){i[WIDTH-1]}}, i};

endmodule