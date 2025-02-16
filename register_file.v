<<<<<<< HEAD
<<<<<<< HEAD
module register_file(
    input clk,
    input reset,
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] reg_file [0:31];
    
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1)
            reg_file[i] = 32'b0;
    end

    always @(posedge clk) begin
        if (reset) begin
            for(i = 0; i < 32; i = i + 1)
                reg_file[i] <= 32'b0;
        end
        else if (reg_write && write_reg != 0)
=======
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
);
    reg [31:0] reg_file [31:0];  // Banco de registradores com 32 registradores de 32 bits

    // Inicialização dos registradores (opcional para simulação)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) reg_file[i] = 0;
>>>>>>> parent of 5ff6c89 (desisto)
    end

    // Leitura dos registradores
    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];

    // Escrita no registrador (sincronizada com o clock)
    always @(posedge clk) begin
        if (reg_write && write_reg != 5'b0) reg_file[write_reg] <= write_data;
    end
endmodule