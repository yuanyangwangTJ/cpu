// ext5.v

module EXT5 #(parameter WIDTH = 5)(
	input [WIDTH-1:0] i,
	output [31:0] r
	);
	
	assign r = {{(32-WIDTH){1'b0}}, i};

endmodule