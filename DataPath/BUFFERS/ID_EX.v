module ID_EX(
    input clk,
    // Señales de Control entrantes (desde ID)
    input id_reg_dst, input [1:0] id_alu_op, input id_alu_src,
    input id_branch, input id_mem_read, input id_mem_write,
    input id_reg_write, input id_mem_to_reg,
    // Datos entrantes
    input [31:0] id_pc_mas_4, input [31:0] id_reg_dr1, input [31:0] id_reg_dr2,
    input [31:0] id_sign_ext, input [4:0] id_rt, input [4:0] id_rd,
    
    // Señales de Control salientes (hacia EX)
    output reg ex_reg_dst, output reg [1:0] ex_alu_op, output reg ex_alu_src,
    output reg ex_branch, output reg ex_mem_read, output reg ex_mem_write,
    output reg ex_reg_write, output reg ex_mem_to_reg,
    // Datos salientes
    output reg [31:0] ex_pc_mas_4, output reg [31:0] ex_reg_dr1, output reg [31:0] ex_reg_dr2,
    output reg [31:0] ex_sign_ext, output reg [4:0] ex_rt, output reg [4:0] ex_rd
);
    always @(posedge clk) begin
        ex_reg_dst   <= id_reg_dst;   ex_alu_op     <= id_alu_op;     ex_alu_src   <= id_alu_src;
        ex_branch    <= id_branch;    ex_mem_read   <= id_mem_read;   ex_mem_write <= id_mem_write;
        ex_reg_write <= id_reg_write; ex_mem_to_reg <= id_mem_to_reg;
        ex_pc_mas_4  <= id_pc_mas_4;  ex_reg_dr1    <= id_reg_dr1;    ex_reg_dr2   <= id_reg_dr2;
        ex_sign_ext  <= id_sign_ext;  ex_rt         <= id_rt;         ex_rd        <= id_rd;
    end
endmodule