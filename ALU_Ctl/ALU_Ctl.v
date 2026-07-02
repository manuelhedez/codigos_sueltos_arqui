module ALU_Ctl(
    input[1,0]  ALUOp,
    input[5,0]  FNC,
    output[3,0] ALC
);

    always @*
        begin 
            case(ALUOp)
                00:ALC=4'b0010;
                01:ALC=4'b0110;
                10:
                    case (FNC)
                        100000:ALC=4'b0010;
                        100010:ALC=4'b0110;
                        100100:ALC=4'b0000;
                        100101:ALC=4'b0001;
                        101010:ALC=4'b0111;
                        100111:ALC=4'b1100;
                        default:ALC=4'b1111;
                    endcase
                default: ALC=4'b1111;
            endcase
         end
endmodule