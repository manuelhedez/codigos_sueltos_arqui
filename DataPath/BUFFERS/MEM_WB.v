module MEM_WB(
    input clk,
    // Control entrante (desde MEM)
    input mem_reg_write, input mem_mem_to_reg,
    // Datos entrantes
    input [31:0] mem_read_data, input [31:0] mem_alu_result, input [4:0] mem_write_reg,
    
    // Control salientes (hacia WB)
    output reg wb_reg_write, output reg wb_mem_to_reg,
    // Datos salientes
    output reg [31:0] wb_read_data, output reg [31:0] wb_alu_result, output reg [4:0] wb_write_reg
);
    always @(posedge clk) begin
        wb_reg_write   <= mem_reg_write;   wb_mem_to_reg <= mem_mem_to_reg;
        wb_read_data   <= mem_read_data;   wb_alu_result <= mem_alu_result;
        wb_write_reg   <= mem_write_reg;
    end
endmodule