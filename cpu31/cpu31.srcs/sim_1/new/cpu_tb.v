module cpu_tb;
	reg clk, rst;
	reg [31:0] inst, rdata;
	wire [31:0] pc, addr, wdata;
	wire ena, we, re;

	initial begin
		clk <= 1;
		rst <= 1;
		inst <= 0;
		rdata <= 0;
		#20 rst <= 0;
	end

	always begin
		#20 begin
		 	inst <= inst + 1;
		 	rdata <= rdata + 1;
		end
	end



	CPU31 cpu(clk, rst, inst, rdata, pc, addr, wdata, ena, we, re);
endmodule
