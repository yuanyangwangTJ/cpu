// controller.v

`define add icode[0]
`define addu icode[1]
`define sub icode[2]
`define subu icode[3]
`define and icode[4]
`define or icode[5]
`define xor icode[6]
`define nor icode[7]
`define slt icode[8]
`define sltu icode[9]
`define sll icode[10]
`define srl icode[11]
`define sra icode[12]
`define sllv icode[13]
`define srlv icode[14]
`define srav icode[15]
`define jr icode[16]
`define addi icode[17]
`define addiu icode[18]
`define andi icode[19]
`define ori icode[20]
`define xori icode[21]
`define lw icode[22]
`define sw icode[23]
`define beq icode[24]
`define bne icode[25]
`define slti icode[26]
`define sltiu icode[27]
`define lui icode[28]
`define j icode[29]
`define jal icode[30]

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
	assign M6 = `addi||`addiu||`andi||`ori||`xori||`lw||`sw||`slti||`sltiu||`lui;
	assign M7[1] = `jal;
	assign M7[0] = `addi||`addiu||`andi||`ori||`xori||`slti||`sltiu||`lui||`lw;
	assign M[1] = `slt||`sltu||`slti||`sltiu||`jal;
	assign M[0] = `slt||`sltu||`lw||`slti||`sltiu;

	assign ALUC[3] = `slt||`sltu||`sll||`srl||`sra||`sllv||`srlv||`srav||`slti||`sltiu||`lui;
	assign ALUC[2] = `and||`or||`xor||`nor||`sll||`srl||`sra||`sllv||`srlv||`srav||`andi||`ori||`xori;
	assign ALUC[1] = `add||`sub||`xor||`nor||`slt||`sltu||`sll||`sllv||`addi||`xori||`beq||`slti||`sltiu;
	assign ALUC[0] = `sub||`subu||`or||`nor||`slt||`srl||`srlv||`ori||`beq||`bne||`slti;

	assign RF_ena = ~`j;
	assign RF_we = ~(`jr||`sw||`beq||`bne||`j);
	assign DM_ena = `lw||`sw;
	assign DM_re = `lw;
	assign DM_we = `lw||`sw;

	assign EXT16_s = `addi||`addiu||`lw||`sw||`slti||`sltiu;

endmodule
