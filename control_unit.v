module control_unit (
    input wire [5:0] opcode,
    output reg reg_dst,
    output reg jump,
    output reg branch,
    output reg mem_read,
    output reg mem_to_reg,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write,
    output reg [1:0] alu_op
);
    always @(*) begin
        case (opcode)
            6'b000000: begin // R-type
                reg_dst = 1;
                jump = 0;
                branch = 0;
                mem_read = 0;
                mem_to_reg = 0;
                mem_write = 0;
                alu_src = 0;
                reg_write = 1;
                alu_op = 2'b10;
            end
            6'b100011: begin // lw
                reg_dst = 0;
                jump = 0;
                branch = 0;
                mem_read = 1;
                mem_to_reg = 1;
                mem_write = 0;
                alu_src = 1;
                reg_write = 1;
                alu_op = 2'b00;
            end
            6'b101011: begin // sw
                reg_dst = 0;
                jump = 0;
                branch = 0;
                mem_read = 0;
                mem_to_reg = 0;
                mem_write = 1;
                alu_src = 1;
                reg_write = 0;
                alu_op = 2'b00;
            end
            6'b000100: begin // beq
                reg_dst = 0;
                jump = 0;
                branch = 1;
                mem_read = 0;
                mem_to_reg = 0;
                mem_write = 0;
                alu_src = 0;
                reg_write = 0;
                alu_op = 2'b01;
            end
            6'b000010: begin // j
                reg_dst = 0;
                jump = 1;
                branch = 0;
                mem_read = 0;
                mem_to_reg = 0;
                mem_write = 0;
                alu_src = 0;
                reg_write = 0;
                alu_op = 2'b00;
            end
            default: begin // Instruções não suportadas
                reg_dst = 0;
                jump = 0;
                branch = 0;
                mem_read = 0;
                mem_to_reg = 0;
                mem_write = 0;
                alu_src = 0;
                reg_write = 0;
                alu_op = 2'b00;
            end
        endcase
    end
endmodule