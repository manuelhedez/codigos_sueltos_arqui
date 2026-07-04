module unidadctl(
    input [5:0] OpCode,
    output reg RegDst,      // Added missing output port
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUScr,      // Note: Often spelled ALUSrc in MIPS architecture
    output reg RegWrite
);

    always @(OpCode) begin
        case (OpCode) // Added missing case statement
            6'b000000:
                begin 
                    RegDst   = 1'b1;
                    Branch   = 1'b0;
                    MemRead  = 1'b0;
                    MemtoReg = 1'b0;
                    ALUOp    = 2'b10;
                    MemWrite = 1'b0;
                    ALUScr   = 1'b1; // Fixed invalid 1'b10 assignment
                    RegWrite = 1'b1;
                end
                
            default: // Added default case to prevent latches
                begin
                    RegDst   = 1'b0;
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