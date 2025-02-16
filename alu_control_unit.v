// Unidade de Controle da ALU
module alu_control_unit(
    input [1:0] alu_op,           // Sinal de controle da ALU (vem da unidade de controle principal)
    input [5:0] funct,            // Campo funct da instrução (usado para instruções do tipo R)
    output reg [3:0] alu_ctrl     // Sinal de controle para a ALU
);
    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; // LW/SW: operação de ADD (soma)
            2'b01: alu_ctrl = 4'b0110; // BEQ: operação de SUB (subtração)
            2'b10: begin
                case (funct)
                    6'b100000: alu_ctrl = 4'b0010; // ADD
                    6'b100010: alu_ctrl = 4'b0110; // SUB
                    6'b100100: alu_ctrl = 4'b0000; // AND
                    6'b100101: alu_ctrl = 4'b0001; // OR
                    6'b101010: alu_ctrl = 4'b0111; // SLT
                    default: alu_ctrl = 4'b0000;   // Caso padrão
                endcase
            end
            default: alu_ctrl = 4'b0000; // Caso padrão
        endcase
    end
endmodule