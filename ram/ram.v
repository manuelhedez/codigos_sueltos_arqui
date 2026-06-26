module ram(
    input [4:0] Dir,
    input EN,
    input [31:0] DatoE,
    output reg [31:0] DatoS);

    // SOLUCIÓN: Agrega este atributo antes del reg para engañar a Quartus
    (* ramstyle = "logic" *) reg [31:0] Mem [0:31];

    // inicializacion 
    initial 
        begin 
             $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/Datos.txt", Mem);
        end

    // lectura y escritura
    always @*
        begin 
            if(EN)
                begin
                    Mem[Dir] = DatoE[31:0];
                end
            else
                begin
                    DatoS = Mem[Dir];
                end
         end
endmodule