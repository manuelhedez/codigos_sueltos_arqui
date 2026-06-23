module DFF_tb;
    reg clock;
    reg D;
    wire Q;
    wire Qbar;

    DFF uut (
        .clock(clock), 
        .D(D), 
        .Q(Q), 
        .Qbar(Qbar)
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