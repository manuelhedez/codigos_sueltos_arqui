module EX_MEM(
    input clk,
    // Control entrante (desde EX)
    input ex_branch, input ex_mem_read, input ex_mem_write,
    input ex_reg_write, input ex_mem_to_reg,
    // Datos entrantes
    input [31:0] ex_branch_target, input ex_zero, input [31:0] ex_alu_result,
    input [31:0] ex_reg_dr2, input [4:0] ex_write_reg,
    
    // Control salientes (hacia MEM)
    output reg mem_branch, output reg mem_read, output reg mem_write,
    output reg mem_reg_write, output reg mem_mem_to_reg,
    // Datos salientes
    output reg [31:0] mem_branch_target, output reg mem_zero, output reg [31:0] mem_alu_result,
    output reg [31:0] mem_reg_dr2, output reg [4:0] mem_write_reg
);
    always @(posedge clk) begin
        mem_branch        <= ex_branch;       mem_read     <= ex_mem_read;   mem_write <= ex_mem_write;
        mem_reg_write     <= ex_reg_write;    mem_mem_to_reg <= ex_mem_to_reg;
        mem_branch_target <= ex_branch_target; mem_zero     <= ex_zero;
        mem_alu_result    <= ex_alu_result;   mem_reg_dr2  <= ex_reg_dr2;
        mem_write_reg     <= ex_write_reg;
    end
endmodule