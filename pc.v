// Program Counter (PC)
module pc(
    input clk,                   // Sinal de clock
    input reset,                 // Sinal de reset
    input [31:0] pc_next,        // Próximo valor do PC
    output reg [31:0] pc         // Valor atual do PC
);
    always @(posedge clk, posedge reset) begin
        if (reset)
            pc <= 32'b0; // Reinicializa o PC se o reset estiver ativo
        else
            pc <= pc_next; // Atualiza o PC com o próximo valor
    end
endmodule