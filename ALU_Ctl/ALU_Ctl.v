module ALU_Ctl(
    input[1:0]  ALUOp,
    input[5:0]  FNC,
    output reg [3:0] ALC
);

    always @*
        begin 
            case(ALUOp)
                2'b00:ALC=4'b0010;
                2'b01:ALC=4'b0110;
                2'b10:
                    case (FNC)
                        6'b100000:ALC=4'b0010;
                        6'b100010:ALC=4'b0110;
                        6'b100100:ALC=4'b0000;
                        6'b100101:ALC=4'b0001;
                        6'b101010:ALC=4'b0111;
                        6'b100111:ALC=4'b1100;
                        default:ALC=4'b1111;
                    endcase
                default: ALC=4'b1111;
            endcase
         end
endmodule