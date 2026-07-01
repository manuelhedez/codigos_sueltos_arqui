module MemDatos(
    input [31:0] Dir,
    input We,
    input Re,
    input [31:0] DatoE,
    output reg [31:0] DatoS);

    // SOLUCIÓN: Agrega este atributo antes del reg para engañar a Quartus
    (* ramstyle = "logic" *) reg [31:0] Mem [0:31];

    // inicializacion 
    initial 
        begin 
             $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/MemDatoss", Mem);//modificar esta ruta al exportar el archivo a otro dispositivo
        end

    // lectura y escritura
    always @*
        begin 
            case({We,Re})
                10:Mem[dir]=DatoE;
                01: DatoS=Mem[Dir];
                default: datoS=32'b0;
            endcase
         end
endmodule