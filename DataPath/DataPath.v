module DataPath(
    input clk
);

// ============================================================================
// ETAPA 1: INSTRUCTION FETCH (IF)
// ============================================================================
wire [31:0] if_pc_actual, if_pc_siguiente, if_pc_mas_4;
wire [31:0] if_instruccion;

PC PC_inst(
    .clk(clk),
    .i_dir(if_pc_siguiente),
    .o_dir(if_pc_actual)
);

add Add_PC(
    .d1(if_pc_actual),
    .d2(32'd4),
    .sl1(if_pc_mas_4)
);

MemInstrucciones InstMem(
    .Dir(if_pc_actual),
    .We(1'b0), .Re(1'b1), .DatoE(32'b0),
    .DatoS(if_instruccion)
);

// --- BUFFER IF/ID ---
wire [31:0] id_pc_mas_4, id_instruccion;

IF_ID Buffer_IF_ID(
    .clk(clk),
    .if_pc_mas_4(if_pc_mas_4), .if_instruccion(if_instruccion),
    .id_pc_mas_4(id_pc_mas_4), .id_instruccion(id_instruccion)
);

// ============================================================================
// ETAPA 2: INSTRUCTION DECODE (ID)
// ============================================================================
wire id_reg_dst, id_jump, id_branch, id_mem_read, id_mem_to_reg;
wire [1:0] id_alu_op;
wire id_mem_write, id_alu_src, id_reg_write;
wire [31:0] id_reg_dr1, id_reg_dr2, id_sign_ext;

unidadctl Control(
    .OpCode(id_instruccion[31:26]),
    .RegDst(id_reg_dst), .Jump(id_jump), .Branch(id_branch),
    .MemRead(id_mem_read), .MemtoReg(id_mem_to_reg), .ALUOp(id_alu_op),
    .MemWrite(id_mem_write), .ALUScr(id_alu_src), .RegWrite(id_reg_write)
);

// Conexión al Banco de Registros (Las señales WB regresan desde la última etapa)
wire wb_reg_write, wb_mem_to_reg;
wire [4:0] wb_write_reg;
wire [31:0] wb_write_data;

BancoRegistros RegFile(
    .AR1(id_instruccion[25:21]), .AR2(id_instruccion[20:16]),
    .AW(wb_write_reg), .DW(wb_write_data), .EW(wb_reg_write),
    .Dr1(id_reg_dr1), .Dr2(id_reg_dr2)
);

SignExt ExtSigno(
    .in(id_instruccion[15:0]),
    .out(id_sign_ext)
);

// --- BUFFER ID/EX ---
wire ex_reg_dst, ex_alu_src, ex_branch, ex_mem_read, ex_mem_write, ex_reg_write, ex_mem_to_reg;
wire [1:0] ex_alu_op;
wire [31:0] ex_pc_mas_4, ex_reg_dr1, ex_reg_dr2, ex_sign_ext;
wire [4:0] ex_rt, ex_rd;

ID_EX Buffer_ID_EX(
    .clk(clk),
    .id_reg_dst(id_reg_dst), .id_alu_op(id_alu_op), .id_alu_src(id_alu_src),
    .id_branch(id_branch), .id_mem_read(id_mem_read), .id_mem_write(id_mem_write),
    .id_reg_write(id_reg_write), .id_mem_to_reg(id_mem_to_reg),
    .id_pc_mas_4(id_pc_mas_4), .id_reg_dr1(id_reg_dr1), .id_reg_dr2(id_reg_dr2),
    .id_sign_ext(id_sign_ext), .id_rt(id_instruccion[20:16]), .id_rd(id_instruccion[15:11]),
    
    .ex_reg_dst(ex_reg_dst), .ex_alu_op(ex_alu_op), .ex_alu_src(ex_alu_src),
    .ex_branch(ex_branch), .ex_mem_read(ex_mem_read), .ex_mem_write(ex_mem_write),
    .ex_reg_write(ex_reg_write), .ex_mem_to_reg(ex_mem_to_reg),
    .ex_pc_mas_4(ex_pc_mas_4), .ex_reg_dr1(ex_reg_dr1), .ex_reg_dr2(ex_reg_dr2),
    .ex_sign_ext(ex_sign_ext), .ex_rt(ex_rt), .ex_rd(ex_rd)
);

// ============================================================================
// ETAPA 3: EXECUTE (EX)
// ============================================================================
wire [31:0] ex_branch_offset, ex_branch_target;
wire [31:0] ex_alu_b_in, ex_alu_result;
wire [3:0] ex_alu_ctl;
wire ex_zero;
wire [4:0] ex_write_reg;

// Cálculo del destino del Branch (Shift Left 2 implícito)
assign ex_branch_offset = {ex_sign_ext[29:0], 2'b00};
add Add_Branch(
    .d1(ex_pc_mas_4),
    .d2(ex_branch_offset),
    .sl1(ex_branch_target)
);

// Selector del operando B de la ALU (Mux3)
mux #(32) Mux3_ALUSrc(
    .sel(ex_alu_src),
    .e1(ex_reg_dr2), .e2(ex_sign_ext),
    .s(ex_alu_b_in)
);

ALU_Ctl ALUControl(
    .ALUOp(ex_alu_op), .FNC(ex_sign_ext[5:0]),
    .ALC(ex_alu_ctl)
);

alu ALU_inst(
    .ALUctl(ex_alu_ctl), .A(ex_reg_dr1), .B(ex_alu_b_in),
    .ALUOut(ex_alu_result), .Zero(ex_zero)
);

// Mux2: Elección del registro de destino (rt vs rd)
mux #(5) Mux2_RegDst(
    .sel(ex_reg_dst),
    .e1(ex_rt), .e2(ex_rd),
    .s(ex_write_reg)
);

// --- BUFFER EX/MEM ---
wire mem_branch, mem_read, mem_write, mem_reg_write, mem_mem_to_reg, mem_zero;
wire [31:0] mem_branch_target, mem_alu_result, mem_reg_dr2;
wire [4:0] mem_write_reg;

EX_MEM Buffer_EX_MEM(
    .clk(clk),
    .ex_branch(ex_branch), .ex_mem_read(ex_mem_read), .ex_mem_write(ex_mem_write),
    .ex_reg_write(ex_reg_write), .ex_mem_to_reg(ex_mem_to_reg),
    .ex_branch_target(ex_branch_target), .ex_zero(ex_zero), .ex_alu_result(ex_alu_result),
    .ex_reg_dr2(ex_reg_dr2), .ex_write_reg(ex_write_reg),
    
    .mem_branch(mem_branch), .mem_read(mem_read), .mem_write(mem_write),
    .mem_reg_write(mem_reg_write), .mem_mem_to_reg(mem_mem_to_reg),
    .mem_branch_target(mem_branch_target), .mem_zero(mem_zero), .mem_alu_result(mem_alu_result),
    .mem_reg_dr2(mem_reg_dr2), .mem_write_reg(mem_write_reg)
);

// ============================================================================
// ETAPA 4: MEMORY (MEM)
// ============================================================================
wire [31:0] mem_read_data;
wire mem_and_zero;
wire [31:0] pc_mux_branch;

MemDatos DataMem(
    .Dir(mem_alu_result), .We(mem_write), .Re(mem_read),
    .DatoE(mem_reg_dr2),
    .DatoS(mem_read_data)
);

// Lógica de decisiones del PC (Vuelve de regreso a la Etapa IF)
assign mem_and_zero = mem_branch & mem_zero;

mux #(32) Mux4_Branch(
    .sel(mem_and_zero),
    .e1(if_pc_mas_4), .e2(mem_branch_target),
    .s(if_pc_siguiente) // Retroalimenta la entrada i_dir del PC en IF
);

// --- BUFFER MEM/WB ---
wire [31:0] wb_read_data, wb_alu_result;

MEM_WB Buffer_MEM_WB(
    .clk(clk),
    .mem_reg_write(mem_reg_write), .mem_mem_to_reg(mem_mem_to_reg),
    .mem_read_data(mem_read_data), .mem_alu_result(mem_alu_result), .mem_write_reg(mem_write_reg),
    
    .wb_reg_write(wb_reg_write), .wb_mem_to_reg(wb_mem_to_reg),
    .wb_read_data(wb_read_data), .wb_alu_result(wb_alu_result), .wb_write_reg(wb_write_reg)
);

// ============================================================================
// ETAPA 5: WRITE BACK (WB)
// ============================================================================

// Mux1: Selecciona qué dato guardar en los registros (Regresa a la Etapa ID)
mux #(32) Mux1_MemToReg(
    .sel(wb_mem_to_reg),
    .e1(wb_alu_result), .e2(wb_read_data),
    .s(wb_write_data)
);

endmodule