// Unidade Lógica e Aritmética (ALU)
module alu(
    input [31:0] a,              // Operando 1
    input [31:0] b,              // Operando 2
    input [3:0] alu_ctrl,        // Sinal de controle para selecionar a operação
    output reg [31:0] result,    // Resultado da operação
    output zero                  // Sinal que indica se o resultado é zero
);
    always @(*) begin
        case (alu_ctrl)
            4'b0010: result = a + b;  // Soma
            4'b0110: result = a - b;  // Subtração
            4'b0000: result = a & b;  // AND lógico
            4'b0001: result = a | b;  // OR lógico
            4'b0111: result = (a < b) ? 1 : 0; // SLT (set less than)
            default: result = 0;      // Caso padrão
        endcase
    end

    assign zero = (result == 0); // Define o sinal zero como 1 se o resultado for zero
endmodule