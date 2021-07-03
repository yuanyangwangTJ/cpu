`timescale 1ns / 1ps

module top(
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel
    );

    wire [31:0] inst, pc;

    reg [20:0] cnt;
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end

    wire clk = cnt[20];

    sccomp_dataflow sc(
        .clk_in(clk), .reset(reset),
        .inst(inst), .pc(pc)
        );

    seg7x16 seg(
        .clk(clk_in), .reset(reset), .cs(1'b1),
        .i_data(pc), .o_seg(o_seg), .o_sel(o_sel)
        );
endmodule
