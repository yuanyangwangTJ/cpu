// mux4_1_5.v

module MUX4_1_5(
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [1:0] ctrl,
	output [4:0] o
	);

	reg [4:0] zr;
	always @(*) begin
		case (ctrl)
			2'b00: zr <= a;
			2'b01: zr <= b;
			2'b10: zr <= c;
			2'b11: zr <= d;
			default: zr <= 5'bz;
		endcase
	end
	assign o = zr;
	
endmodule
