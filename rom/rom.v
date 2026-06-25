module rom(
    input [2:0] Dir,
    output reg [31:0] DatoS);

    //crear memoria 
    reg[31:0] Mem [4:0];

    //inicializacion 
    initial 
        begin 
             $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/Datos.txt", Mem);
        end
    //lectura
    always @*
        begin 
            DatoS= Mem[Dir];
         end

endmodule