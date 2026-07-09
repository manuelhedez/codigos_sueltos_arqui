module unidadctl(
    input [5:0] OpCode,
    output reg RegDst,
    output reg Jump,       // ¡NUEVA SEÑAL!
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUScr,
    output reg RegWrite
);
    always @(*) begin 
        case (OpCode)
            6'b000000: // Tipo R (add, sub, and, or, slt)
                begin 
                    RegDst   = 1'b1;
                    Jump     = 1'b0;
                    Branch   = 1'b0;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0;
                    ALUOp    = 2'b10;
                    MemWrite = 1'b0;
                    ALUScr   = 1'b0; 
                    RegWrite = 1'b1;
                end
            6'b100011: // lw (Load Word)
                begin
                    RegDst   = 1'b0;
                    Jump     = 1'b0;
                    Branch   = 1'b0;
                    MemRead  = 1'b1;
                    MemtoReg = 1'b1;
                    ALUOp    = 2'b00;
                    MemWrite = 1'b0;
                    ALUScr   = 1'b1;
                    RegWrite = 1'b1;
                end
            6'b101011: // sw (Store Word)
                begin
                    RegDst   = 1'b0; 
                    Jump     = 1'b0;
                    Branch   = 1'b0;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0; 
                    ALUOp    = 2'b00;
                    MemWrite = 1'b1;
                    ALUScr   = 1'b1;
                    RegWrite = 1'b0;
                end
            6'b000100: // beq (Branch on Equal)
                begin
                    RegDst   = 1'b0; 
                    Jump     = 1'b0;
                    Branch   = 1'b1;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0; 
                    ALUOp    = 2'b01;
                    MemWrite = 1'b0;
                    ALUScr   = 1'b0;
                    RegWrite = 1'b0;
                end
            6'b000010: // j (Jump)
                begin
                    RegDst   = 1'b0; 
                    Jump     = 1'b1;
                    Branch   = 1'b0;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0; 
                    ALUOp    = 2'b00; 
                    MemWrite = 1'b0;
                    ALUScr   = 1'b0; 
                    RegWrite = 1'b0;
                end
            default: // Prevención de Latches
                begin
                    RegDst   = 1'b0;
                    Jump     = 1'b0;
                    Branch   = 1'b0;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0;
                    ALUOp    = 2'b00;
                    MemWrite = 1'b0;
                    ALUScr   = 1'b0;
                    RegWrite = 1'b0;
                end
        endcase
    end
endmodule