module Srom(
    input [2:0] Dir,
    input clk,
    output reg [31:0] DatoS);

    //crear memoria 
    reg[31:0] Mem [0:4];

    //inicializacion 
    initial 
        begin 
            Mem[0]=32'd 255;
            Mem[1]=32'd 127;
            Mem[2]=32'd 63;
            Mem[3]=32'd 31;
            Mem[4]=32'd 15;
        end
    //lectura
    always @(posedge clk)
        begin 
            DatoS= Mem[Dir];
         end

endmodule