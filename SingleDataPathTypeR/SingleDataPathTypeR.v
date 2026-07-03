module SingleDataPathTypeR(
    input clk
);

wire [31:0]pc_meminst;
wire [31:0]add_mux1;
wire [31:0]mux1_PC;
wire [31:0]meminst1;
wire [31:0]BR_ALU,[31:0]BR_mux3;
wire [31:0]mux2_BR;
wire [31:0]mux3_ALU;
wire [31:0]ALU_mux4,ALU_AND;
wire [31:0]mux1_pc;
wire [31:0]AND_mux1;
wire [31:0]mux4_BR;
wire RegDst_mux2,Branch_AND,MemRead_DataMemory,MemToReag_mux4,[1:0]ALUOp_ALUCtl,MemWrite_DataMemory,ALUScr_mux3,RegWrite_BR;
wire ALUCtl_ALU

PC PCVR(
    .clk(clk),
    .i_dir(mux1_PC),
    o_dir(pc_meminst)
);
add addpcv(
    .d1(pc_meminst),
    .d2(4),
    sl1(add_mux1)
);
 mux #(
    .DATA_WIDTH(32) // <--- Aquí cambias el tamaño al valor que quieras
) mux1 (
    .sel(Branch_AND & ALU_AND),
    .e1(AND_mux1),
    .e2(),
    .s(mux1_pc)
);
memInstrucciones InstMem(
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

endmodule