module sram(
    input [2:0] Dir,
    input EN,
    input clk,
    input [31:0] DatoE,
    output reg [31:0] DatoS);

    //crear memoria 
    reg[31:0] Mem [0:9];

    //inicializacion 
    initial 
        begin 
            $readmemb("Datos.txt", mem);
        end
    //lectura
    always @*
        begin 
            if(EN)
                begin
                    Mem[Dir]=DatoE[31:0];
                end
            else
                begin
                    DatoS= Mem[Dir];
                end
         end
endmodule