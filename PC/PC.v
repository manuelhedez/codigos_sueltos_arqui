module PC(
    input clk,
    input rst,                 // Señal de control para inicializar
    input [31:0] i_dir,        // Entrada limpia, sin asignaciones
    output reg [31:0] o_dir
);

always @(posedge clk or posedge rst) begin
    if (rst)
        o_dir <= 32'd0;        // Cuando rst es 1, el PC se va a 0 (Inicialización)
    else
        o_dir <= i_dir;        // Cuando rst es 0, el PC avanza normalmente
end

endmodule