// Extensão de Sinal
module sign_extension(
    input [15:0] immediate,      // Entrada de 16 bits
    output [31:0] extended       // Saída de 32 bits com extensão de sinal
);
    assign extended = {{16{immediate[15]}}, immediate};
endmodule