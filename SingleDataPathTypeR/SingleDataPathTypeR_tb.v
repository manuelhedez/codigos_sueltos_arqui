`timescale 1ns / 1ps

module tb_SingleDataPathTypeR;

    // Declaración del reloj
    reg clk;

    // Instancia del módulo principal (Design Under Test)
    SingleDataPathTypeR uut (
        .clk(clk)
    );

    // Generación de la señal de reloj (Periodo = 10)
    always begin
        #5 clk = ~clk;
    end

    // Bloque de estímulos
    initial begin
        // Inicializamos el reloj en 0
        clk = 0;

        // Dejamos correr la simulación (ajusta este tiempo según necesites)
        #100;

        // Terminamos la simulación
        $finish;
    end

endmodule