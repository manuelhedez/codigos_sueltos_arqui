module BBQ(
    input [18:0] ins
);
wire [31:0] c1, c2, c3;
wire zf_bbq;


BancoRegistros costilla(
      .AR1(ins[18:14]),
      .AR2(ins[13:9]),
      .AW(0),
      .DW(0),
      .EW(0),
      .Dr1(c1), 
      .Dr2(c2)  
);

alu brisket(
    .ALUctl(ins[3:0]),
    .A(c1),
    .B(c2),
    .ALUOut(c3),
    .Zero(zf_bbq)
);

ram macnchesse(
    .Dir(ins[8:4]),
    .EN(1),
    .DatoE(c3),
    .DatoS()
);

endmodule