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
        end
        else if (reg_write && write_reg != 5'b0) begin
            reg_file[write_reg] <= write_data; // Escreve no registrador
        end
    end

    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];
endmodule