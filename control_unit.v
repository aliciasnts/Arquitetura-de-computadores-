// Unidade de Controle Principal
module control_unit(
    input [5:0] opcode,          // Campo opcode da instrução
    output reg reg_dst,          // Seleciona o registrador de destino (rt ou rd)
    output reg alu_src,          // Seleciona a fonte do segundo operando da ALU
    output reg mem_to_reg,       // Seleciona a fonte do dado a ser escrito no registrador
    output reg reg_write,        // Habilita escrita no banco de registradores
    output reg mem_read,         // Habilita leitura da memória de dados
    output reg mem_write,        // Habilita escrita na memória de dados
    output reg branch,           // Habilita o desvio condicional (BEQ)
    output reg jump,             // Habilita o salto incondicional (JUMP)
    output reg [1:0] alu_op      // Sinal de controle para a ALU
);
    always @(*) begin
        case (opcode)
            6'b000000: begin // Instrução do tipo R
                reg_dst = 1;
                alu_src = 0;
                mem_to_reg = 0;
                reg_write = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                jump = 0;
                alu_op = 2'b10;
            end
            6'b100011: begin // LW (Load Word)
                reg_dst = 0;
                alu_src = 1;
                mem_to_reg = 1;
                reg_write = 1;
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                jump = 0;
                alu_op = 2'b00;
            end
            6'b101011: begin // SW (Store Word)
                reg_dst = 0;
                alu_src = 1;
                mem_to_reg = 0;
                reg_write = 0;
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                jump = 0;
                alu_op = 2'b00;
            end
            6'b000100: begin // BEQ (Branch if Equal)
                reg_dst = 0;
                alu_src = 0;
                mem_to_reg = 0;
                reg_write = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 1;
                jump = 0;
                alu_op = 2'b01;
            end
            6'b000010: begin // JUMP
                reg_dst = 0;
                alu_src = 0;
                mem_to_reg = 0;
                reg_write = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                jump = 1;
                alu_op = 2'b00;
            end
            6'b001000: begin // ADDI
                reg_dst = 0;
                alu_src = 1;
                mem_to_reg = 0;
                reg_write = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                jump = 0;
                alu_op = 2'b00;
            end
            default: begin // Caso padrão
                reg_dst = 0;
                alu_src = 0;
                mem_to_reg = 0;
                reg_write = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                jump = 0;
                alu_op = 2'b00;
            end
        endcase
    end
endmodule