module unidadctl(
    input [5:0]OpCode,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUScr,
    output reg RegWrite
);

    always @(OpCode)
        6'b000000:
            begin 
                RegDst=1'b1;
                 Branch=1'b0;
                MemRead=1'b0;
                MemtoReg=1'b0;
                ALUOp=2'b10;
                MemWrite=1'b0;
                ALUScr=1'b10;
                RegWrite=1'b1;
            end



endmodule