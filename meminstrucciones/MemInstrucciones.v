module MemInstrucciones(
    input [31:0] Dir,
    input We,
    input Re,
    input [31:0] DatoE,
    output reg [31:0] DatoS);

    (* ramstyle = "logic" *) reg [7:0] Mem [0:255];

    // inicializacion 
    initial 
        begin 
             $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/MemInst.txt", Mem);
        end

    // lectura y escritura
    always @*
        begin 
            DatoS={Mem[Dir],Mem[Dir+1],Mem[Dir+2],Mem[Dir+3]};
         end
endmodule