// Memória de Instruções
module instruction_memory(
    input [31:0] addr,           // Endereço da instrução
    output [31:0] instruction    // Instrução lida
);
    reg [31:0] memory [0:255];   // Memória de instruções com 256 posições de 32 bits

    // Leitura da memória de instruções
    assign instruction = memory[addr[9:2]];
endmodule