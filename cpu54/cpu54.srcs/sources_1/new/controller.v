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
`define clz icode[31]
`define div icode[32]
`define divu icode[33]
`define mul icode[34]
`define multu icode[35]
`define eret icode[36]
`define jalr icode[37]
`define lb icode[38]
`define lbu icode[39]
`define lhu icode[40]
`define sb icode[41]
`define sh icode[42]
`define lh icode[43]
`define mfc0 icode[44]
`define mfhi icode[45]
`define mflo icode[46]
`define mtc0 icode[47]
`define mthi icode[48]
`define mtlo icode[49]
`define syscall icode[50]
`define teq icode[51]
`define bgez icode[52]
`define break icode[53]

module Controller(
	input z,
	input n, // negative
	input [53:0] icode,
	input DIV_busy,
	input DIVU_busy,
	output [1:0] M1,
	output M2,
	output M3,
	output M4,
	output M5,
	output [1:0] M6,
	output [1:0] M7,
	output [2:0] M8,
	output [2:0] M9,
	output [1:0] M10,
	output [2:0] M,
	output [3:0] ALUC,
	output RF_we,
	output DM_ena,
	output DM_we,
	output DM_re,
	output DM_byte,
	output DM_half,
	output EXT16_s,
	output HI_ena,
	output HI_we,
	output LO_ena,
	output LO_we,
	output EXT8_s,
	output EXT16_s_2,
	output [4:0] CP0_cause,
	output CP0_mf,
	output CP0_mt,
	output MULT_CS,
	output MULTU_CS,
	output DIV_start,
	output DIVU_start,
	output CP0_exc,
	output CP0_eret
    );

	assign M1[0] = `j||`jal;
	assign M1[1] = `eret;
	assign M2 = `jr||(`beq & z)||(`bne & ~z)||`jalr||(`bgez & ~n);
	assign M3 = `sllv||`srlv||`srav;
	assign M4 = `jr||`jalr;
	assign M5 = `sll||`srl||`sra||`sllv||`srlv||`srav;
	assign M6[0] = `addi||`addiu||`andi||`ori||`xori||`lw||`sw||`slti||`sltiu||`lui||`lb||`lbu||`lhu||`sb||`sh||`lh;
	assign M6[1] = `bgez;
	assign M7[1] = `jal;
	assign M7[0] = `addi||`addiu||`andi||`ori||`xori||`slti||`sltiu||`lui||`lw||`lb||`lbu||`lh||`lhu||`mfc0;
	assign M8[2] = `mthi;
	assign M8[1] = `div||`divu;
	assign M8[0] = `divu||`multu;
	assign M9[2] = `mtlo;
	assign M9[1] = `div||`divu;
	assign M9[0] = `divu||`multu;
	assign M10[0] = `mflo;
	assign M10[1] = `mul;
	assign M[2] = `lb||`lbu||`lhu||`lh||`mfc0||`mfhi||`mflo||`mul;
	assign M[1] = `jal||`clz||`jalr||`lhu||`lh||`mfhi||`mflo||`mul;
	assign M[0] = `lw||`clz||`lb||`lbu||`mfhi||`mflo||`mul;

	assign ALUC[3] = `slt||`sltu||`sll||`srl||`sra||`sllv||`srlv||`srav||`slti||`sltiu||`lui||`bgez;
	assign ALUC[2] = `and||`or||`xor||`nor||`sll||`srl||`sra||`sllv||`srlv||`srav||`andi||`ori||`xori;
	assign ALUC[1] = `add||`sub||`xor||`nor||`slt||`sltu||`sll||`sllv||`addi||`xori||`beq||`slti||`sltiu||`bgez;
	assign ALUC[0] = `sub||`subu||`or||`nor||`slt||`srl||`srlv||`ori||`beq||`bne||`slti||`teq||`bgez;

	assign RF_we = ~(`jr||`sw||`beq||`bne||`j||`div||`divu||`multu||`eret||`sb||`sh||`mtc0||`mthi||`mtlo||`syscall||`teq||`bgez||`break);
	assign DM_ena = `lw||`sw||`lb||`lbu||`lhu||`sb||`sh||`lh;
	assign DM_re = `lw||`lb||`lbu||`lhu||`lh;
	assign DM_we = `lw||`sw||`sb||`sh;
	assign DM_byte = `sb;
	assign DM_half = `sh;

	assign EXT16_s = `addi||`addiu||`lw||`sw||`slti||`sltiu;

	assign HI_ena = `mfhi||`mthi||`multu||`div||`divu;
	assign HI_we = `mthi||`multu||`div||`divu;
	assign LO_ena = `mflo||`mtlo||`mul||`multu||`div||`divu;
	assign LO_we = `mtlo||`mul||`multu||`div||`divu;
	assign EXT8_s = `lb;
	assign EXT16_s_2 = `lh;

	assign CP0_cause[4] = 1'b0;
	assign CP0_cause[3] = 1'b0;
	assign CP0_cause[2] = 1'b0;
	assign CP0_cause[1] = 1'b0;
	assign CP0_cause[0] = `break||`syscall;

	assign CP0_mt = `mtc0;
	assign CP0_mf = `mfc0;
	assign MULT_CS = `mul;
	assign MULTU_CS = `multu;

	assign DIV_start = (~DIV_busy) & `div;
	assign DIVU_start = (~DIVU_busy) & `divu;

	assign CP0_exc = `break||`syscall||`eret;
	assign CP0_eret = `eret;
	
endmodule
