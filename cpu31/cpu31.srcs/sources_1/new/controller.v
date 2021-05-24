// controller.v
`include "instrName.v"

module Controller(
	input clk,
	input z,
	input [31:0] icode,
	output PC_clk,
	output PC_ena,
	output M1,
	output M2,
	output M3,
	output M4,
	output M5,
	output M6,
	output [1:0] M7,
	output M8,
	output [1:0] M,
	output [3:0] ALUC,
	output RF_ena,
	output RF_we,
	output RF_clk,
	output DM_ena,
	output DM_we,
	output DM_re,
	output EXT16_s
    );

	assign PC_clk = clk;
	assign RF_clk = clk;
	assign PC_ena = 1'b1;
	assign M1 = `j||`jal;
	assign M2 = `jr||(`beq & z)||(`bne & ~z);
	assign M3 = `sllv||`srlv||`srav;
	assign M4 = `jr;
	assign M5 = `sll||`srl||`sra||`sllv||`srlv||`srav;
	assign M6 = `addi||`addiu||`andi||`ori||`xori||`lw||`sw||`slti||`sltiu;
	assign M7[1] = `jal;
	assign M7[0] = `addi||`addiu||`andi||`ori||`xori||`slti||`sltiu||`lui;
	assign M8 = `sltiu;
	assign M[1] = `slt||`sltu||`slti||`sltiu||`jal;
	assign M[0] = `slt||`sltu||`lw||`slti||`sltiu;

	assign ALUC[3] = `slt||`sltu||`sll||`srl||`sra||`sllv||`srlv||`srav||`slti||`sltiu||`lui;
	assign ALUC[2] = `and||`or||`xor||`nor||`sll||`srl||`sra||`sllv||`srlv||`srav||`andi||`ori||`xori;
	assign ALUC[1] = `add||`sub||`xor||`nor||`slt||`sltu||`sll||`sllv||`addi||`xori||`lw||`sw||`beq||`slti||`sltiu;
	assign ALUC[0] = `sub||`subu||`or||`nor||`slt||`srl||`srlv||`ori||`beq||`bne||`slti;

	assign RF_ena = ~`j;
	assign RF_we = ~(`jr||`sw||`beq||`bne||`j);
	assign DM_ena = `lw||`sw;
	assign DM_re = `lw;
	assign DM_we = `lw||`sw;

	assign EXT16_s = `addi||`addiu||`lw||`sw||`slti||`sltiu;

endmodule
