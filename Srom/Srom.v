module Srom(
    input [2:0] Dir,
    input clk,
    output reg [31:0] DatoS);

    //crear memoria 
    reg[31:0] Mem [0:4];

    //inicializacion 
    initial 
        begin 
            $readmemb("C:/Users/USUARIO/Documents/MANUELHEDEZGITHUB/codigos_sueltos_arqui/sram/Datos.txt", Mem); 
        end
    //lectura
    always @(posedge clk)
        begin 
            DatoS= Mem[Dir];
         end

endmodule