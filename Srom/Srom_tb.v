module Srom_tb;
    reg [2:0] Dir;
    reg clk;
    wire DatoS;
    Srom uut (
        .Dir(Dir), 
        .clk(clk), 
        .DatoS(DatoS),
    );
    always begin
        #10 clock = ~clock;
    end
    initial begin
        clock = 0;
        Dir = 0;
        #20;
        Dir = 1;
        #20;
        Dir = 2;
        #20;
        Dir = 3;
        #20;
        Dir = 4;
        #20;
    end
endmodule