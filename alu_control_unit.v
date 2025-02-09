module alu_control_unit (
    input wire [1:0] alu_op,
    input wire [5:0] funct,
    output reg [3:0] alu_control
);
    always @(*) begin
        case (alu_op)
            2'b00: alu_control = 4'b0000; // add (para lw, sw, addi)
            2'b01: alu_control = 4'b0001; // sub (para beq)
            2'b10: begin // R-type
                case (funct)
                    6'b100000: alu_control = 4'b0000; // add
                    6'b100010: alu_control = 4'b0001; // sub
                    6'b100100: alu_control = 4'b0010; // and
                    6'b100101: alu_control = 4'b0011; // or
                    6'b101010: alu_control = 4'b0100; // slt
                    default: alu_control = 4'b0000;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule