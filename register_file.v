<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
module register_file(
    input clk,
    input reset, // Adicione o sinal de reset
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] reg_file [0:31];

    // Inicialização dos registradores com reset
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 32'b0; // Inicializa todos os registradores com zero
<<<<<<< HEAD
        end
        else if (reg_write && write_reg != 5'b0) begin
            reg_file[write_reg] <= write_data; // Escreve no registrador
        end
<<<<<<< HEAD
        else if (reg_write && write_reg != 0)
=======
=======
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
module register_file (
    input wire clk,
    input wire reset,
    input wire reg_write,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
<<<<<<< HEAD
);
    reg [31:0] reg_file [31:0];
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 0;
        end
        else if (reg_write)
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
            reg_file[write_reg] <= write_data;
=======
// Banco de Registradores
module register_file(
    input clk,                   // Sinal de clock
    input reg_write,             // Habilita escrita no registrador
    input [4:0] read_reg1,       // Endereço do primeiro registrador a ser lido
    input [4:0] read_reg2,       // Endereço do segundo registrador a ser lido
    input [4:0] write_reg,       // Endereço do registrador a ser escrito
    input [31:0] write_data,     // Dado a ser escrito no registrador
    output [31:0] read_data1,    // Dado lido do primeiro registrador
    output [31:0] read_data2     // Dado lido do segundo registrador
=======
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
);
    reg [31:0] reg_file [31:0];
    integer i;
<<<<<<< HEAD
    initial begin
        for (i = 0; i < 32; i = i + 1) reg_file[i] = 0;
>>>>>>> parent of 5ff6c89 (desisto)
=======
>>>>>>> parent of ff94c93 (voltei atrás do balde)
=======

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 0;
        end
        else if (reg_write)
            reg_file[write_reg] <= write_data;
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
=======
        end
        else if (reg_write && write_reg != 5'b0) begin
            reg_file[write_reg] <= write_data; // Escreve no registrador
        end
>>>>>>> parent of ff94c93 (voltei atrás do balde)
    end

    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];
endmodule