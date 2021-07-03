// mux4_1_32.v

module MUX4_1_32(
	input [31:0] a,
	input [31:0] b,
	input [31:0] c,
	input [31:0] d,
	input [1:0] ctrl,
	output [31:0] o
	);

	reg [31:0] zr;
	always @(*) begin
		case (ctrl)
			2'b00: zr <= a;
			2'b01: zr <= b;
			2'b10: zr <= c;
			2'b11: zr <= d;
			default: zr <= 32'bz;
		endcase
	end
	assign o = zr;
	
endmodule
