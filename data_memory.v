<<<<<<< HEAD
<<<<<<< HEAD
=======
// Memória de Dados
>>>>>>> parent of ff94c93 (voltei atrás do balde)
module data_memory(
    input clk,                   // Sinal de clock
    input mem_read,              // Habilita leitura da memória
    input mem_write,             // Habilita escrita na memória
    input [31:0] addr,           // Endereço de memória
    input [31:0] write_data,     // Dado a ser escrito na memória
    output [31:0] read_data      // Dado lido da memória
);
    reg [31:0] memory [0:255];   // Memória com 256 posições de 32 bits

    // Leitura da memória
    assign read_data = (mem_read) ? memory[addr[7:0]] : 0;

<<<<<<< HEAD
=======
module data_memory (
    input wire clk,
    input wire mem_write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);
    reg [31:0] memory [1023:0];

>>>>>>> parent of 3ffac98 (acho que fiz progresso)
=======
    // Escrita na memória (sincronizada com o clock)
>>>>>>> parent of ff94c93 (voltei atrás do balde)
    always @(posedge clk) begin
        if (mem_write)
            memory[address >> 2] <= write_data;
    end

    assign read_data = memory[address >> 2];
endmodule
