// MUX8_1_32.v

module MUX8_1_32(
	input [31:0] a,
	input [31:0] b,
	input [31:0] c,
	input [31:0] d,
	input [31:0] e,
	input [31:0] f,
	input [31:0] g,
	input [31:0] h,
	input [2:0] ctrl,
	output [31:0] o
    );

	reg [31:0] zr;
	always @(*) begin
		case (ctrl)
			3'b000: zr <= a;
			3'b001: zr <= b;
			3'b010: zr <= c;
			3'b011: zr <= d;
			3'b100: zr <= e;
			3'b101: zr <= f;
			3'b110: zr <= g;
			3'b111: zr <= h;
			default: zr <= 32'bz;
		endcase
	end
	assign o = zr;

endmodule
