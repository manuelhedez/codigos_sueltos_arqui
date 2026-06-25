module BancoRegistros(
    input [4:0] AR1,
    input [4:0] AR2,
    input [4:0] AW,
    input [31:0] DW,
    input EW,
    output reg [31:0] Dr1, 
    output reg [31:0] Dr2  
);

    reg [31:0] banco [0:31];

    initial begin 
        $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/Datos.txt", banco);
    end

    always @* begin 
        if (EW) begin
            banco[AW] = DW;
        end
        Dr1 = banco[AR1];
        Dr2 = banco[AR2];
    end
endmodule
