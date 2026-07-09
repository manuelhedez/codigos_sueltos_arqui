module SignExt(
    input [15:0] in,
    output [31:0] out
);
    // Replica el bit más significativo (el bit de signo in[15]) 16 veces
    // y lo concatena con el número original de 16 bits.
    assign out = {{16{in[15]}}, in};
endmodule