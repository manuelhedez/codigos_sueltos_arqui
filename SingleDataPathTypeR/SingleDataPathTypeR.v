module SingleDataPathTypeR(
    input clk
);

wire [31:0] pc_meminst;
wire [31:0] add_mux1;
wire [31:0] mux1_pc;
wire [31:0] meminst1;
wire [31:0] BR_ALU, BR_mux3;
wire [4:0]  mux2_BR;
wire [31:0] mux3_ALU;
wire [31:0] ALU_mux4;
wire [31:0] mux4_BR;
wire RegDst_mux2, Branch_AND, MemRead_DataMemory, MemToReag_mux4;
wire MemWrite_DataMemory, ALUScr_mux3, RegWrite_BR;
wire [1:0] ALUOp_ALUCtl;
wire [3:0] ALUCtl_ALU; 
wire zero;
wire [31:0] DataMem_mux4;

PC PCVR(
    .clk(clk),
    .i_dir(mux1_pc),
    .o_dir(pc_meminst)
);

add addpcv(
    .d1(pc_meminst),
    .d2(32'd4),
    .sl1(add_mux1)
);

mux #(.DATA_WIDTH(32)) mux1 (
    .sel(Branch_AND & zero),
    .e1(add_mux1),
    .e2(0), 
    .s(mux1_pc)
);
MemInstrucciones InstMem(
    .Dir(pc_meminst),
    .We(),
    .Re(1),
    .DatoE(),
    .DatoS(meminst1)
);
unidadctl unidadctlpcv(
    .OpCode(meminst1[31:26]),
    .Branch(Branch_AND),
    .MemRead(MemRead_DataMemory),
    .MemtoReg(MemToReag_mux4),
    .ALUOp(ALUOp_ALUCtl),
    .MemWrite(MemWrite_DataMemory),
    .ALUScr(ALUScr_mux3),
    .RegWrite(RegWrite_BR),
    .RegDst(RegDst_mux2)


);
 mux #(
    .DATA_WIDTH(5)
) mux2 (
    .sel(RegDst_mux2),
    .e1(meminst1[20:16]),
    .e2(meminst1[15:11]),
    .s(mux2_BR)
);
BancoRegistros BR(
    .AR1(meminst1[25:21]),
    .AR2(meminst1[20:16]),
    .AW(mux2_BR),
    .DW(mux4_BR),
    .EW(RegWrite_BR),
    .Dr1(BR_ALU), 
    .Dr2(BR_mux3)  
);

 mux #(
    .DATA_WIDTH(32)
) mux3 (
    .sel(ALUScr_mux3),
    .e1(BR_mux3),
    .e2(0),
    .s(mux3_ALU)
);

ALU_Ctl ALUCtl(
    .ALUOp(ALUOp_ALUCtl),
    .FNC(meminst1[5:0]),
    .ALC(ALUCtl_ALU)
);
alu alu(    
    .ALUctl(ALUCtl_ALU),
    .A(BR_ALU),
    .B(mux3_ALU),
    .ALUOut(ALU_mux4),
    .Zero(zero)
);

MemDatos DataMemory(
    .Dir(ALU_mux4),
    .We(MemWrite_DataMemory),
    .Re(MemRead_DataMemory),
    .DatoE(BR_mux3),
    .DatoS(DataMem_mux4)
);
 mux #(
    .DATA_WIDTH(32)
) mux4 (
    .sel(MemToReag_mux4),
    .e1(DataMem_mux4),
    .e2(ALU_mux4),
    .s(mux4_BR)
);

endmodule