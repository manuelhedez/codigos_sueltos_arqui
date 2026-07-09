module IF_ID(
    input clk,
    input [31:0] if_pc_mas_4,
    input [31:0] if_instruccion,
    output reg [31:0] id_pc_mas_4,
    output reg [31:0] id_instruccion
);
    always @(posedge clk) begin
        id_pc_mas_4    <= if_pc_mas_4;
        id_instruccion <= if_instruccion;
    end
endmodule