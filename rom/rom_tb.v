module rom_tb;
    reg clock;
    reg D;
    wire Q;
    wire Qbar;
    rom uut (
        .clock(clock),
    );
    always begin
        #10 clock = ~clock;
    end
    initial begin
        clock = 0;
        D = 0;
        #25;
        D = 1;
        #20;
        D = 0;
        #20;
        D = 1;
        #15;
        D = 0;
        #25;
    end
endmodule