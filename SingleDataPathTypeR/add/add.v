module add(
    input [31,:0]d1,
    input [31:0]d2,
    output [31:0]sl1
);
assign sl1=d1+d2;
endmodule