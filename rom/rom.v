module rom(
    input [2:0] Dir,          
    output reg [31:0] DatoS
);                           
    // Crear memoria 
    reg [31:0] Mem [0:4];
    // Inicialización 
    initial 
        begin 
            Mem[0] = 32'd 255; 
            Mem[1] = 32'd 127; 
            Mem[2] = 32'd 63;
            Mem[3] = 32'd 31;
            Mem[4] = 32'd 15; 
        end
    // Lectura combinacional
    always @*
        begin 
            DatoS = Mem[Dir];
        end

endmodule