`timescale 1ns / 1ps

module Srom_tb;

    // 1. Declarar señales para conectar con el módulo Srom
    reg [2:0] Dir;
    reg clk;
    wire [31:0] DatoS;

    // 2. Instanciar el módulo bajo prueba (UUT - Unit Under Test)
    Srom uut (
        .Dir(Dir),
        .clk(clk),
        .DatoS(DatoS)
    );

    // 3. Generación del Reloj (Periodo de 10ns -> 100 MHz)
    always begin
        #5 clk = ~clk;
    end

    // 4. Bloque de estímulos
    initial begin
        // Inicializar señales
        clk = 0;
        Dir = 3'b000;

        // Esperar un momento a que se estabilice la simulación
        #10;

        // Recorrer las posiciones de la memoria (0 a 4)
        // Nota: Cambiamos de dirección en cada ciclo de reloj
        
        Dir = 3'd0; #10; // Lee la posición 0
        Dir = 3'd1; #10; // Lee la posición 1
        Dir = 3'd2; #10; // Lee la posición 2
        Dir = 3'd3; #10; // Lee la posición 3
        Dir = 3'd4; #10; // Lee la posición 4
        
        // Intentar leer una posición fuera del rango declarado [0:4] para ver qué pasa
        Dir = 3'd5; #10; 

        // Terminar la simulación
        $display("Simulación de la Srom finalizada.");
        $finish;
    end
      
endmodule