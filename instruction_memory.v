<<<<<<< HEAD
<<<<<<< HEAD
=======
// Memória de Instruções
>>>>>>> parent of ff94c93 (voltei atrás do balde)
module instruction_memory(
    input [31:0] addr,           // Endereço da instrução
    output [31:0] instruction    // Instrução lida
);
    reg [31:0] memory [0:255];   // Memória de instruções com 256 posições de 32 bits

<<<<<<< HEAD
=======
module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instruction
);
    reg [31:0] memory [1023:0];
    assign instruction = memory[pc >> 2];
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
=======
    // Leitura da memória de instruções
    assign instruction = memory[addr[9:2]];
>>>>>>> parent of ff94c93 (voltei atrás do balde)
endmodule