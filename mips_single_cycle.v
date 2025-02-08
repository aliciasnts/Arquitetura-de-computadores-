module mips_single_cycle (
    input wire clk,
    input wire reset
);
    // Definição dos sinais internos
    wire [31:0] pc_next, pc_current, pc_plus_4, pc_branch, pc_jump;
    wire [31:0] instruction, read_data_1, read_data_2, write_data, mem_read_data;
    wire [31:0] sign_extend, shift_left_2, alu_input_2;
    wire [3:0] alu_control;
    wire [1:0] alu_op;
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
    wire zero;

    // Registradores
    reg [31:0] pc;
    reg [31:0] reg_file [31:0];
    reg [31:0] memory [1023:0];
    reg [31:0] alu_result; // Corrigido: alu_result agora é um reg

    // PC Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc_next;
    end

    assign pc_plus_4 = pc + 4;
    assign pc_branch = pc_plus_4 + (sign_extend << 2);
    assign pc_jump = {pc_plus_4[31:28], instruction[25:0], 2'b00};
    assign pc_next = (jump) ? pc_jump : (branch & zero) ? pc_branch : pc_plus_4;

    // Instruction Memory
    assign instruction = memory[pc >> 2];

    // Register File
    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;
    always @(posedge clk) begin
        if (reg_write)
            reg_file[instruction[15:11]] <= write_data;
    end
    assign read_data_1 = reg_file[instruction[25:21]];
    assign read_data_2 = reg_file[instruction[20:16]];

    // ALU
    assign alu_input_2 = (alu_src) ? sign_extend : read_data_2;
    assign zero = (alu_result == 0);
    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = read_data_1 + alu_input_2; // add
            4'b0001: alu_result = read_data_1 - alu_input_2; // sub
            4'b0010: alu_result = read_data_1 & alu_input_2; // and
            4'b0011: alu_result = read_data_1 | alu_input_2; // or
            4'b0100: alu_result = (read_data_1 < alu_input_2) ? 1 : 0; // slt
            default: alu_result = 0;
        endcase
    end

    // Data Memory
    always @(posedge clk) begin
        if (mem_write)
            memory[alu_result >> 2] <= read_data_2;
    end
    assign mem_read_data = memory[alu_result >> 2];

    // Control Unit
    assign reg_dst = (instruction[31:26] == 6'b000000); // R-type
    assign jump = (instruction[31:26] == 6'b000010);    // j
    assign branch = (instruction[31:26] == 6'b000100);  // beq
    assign mem_read = (instruction[31:26] == 6'b100011); // lw
    assign mem_to_reg = (instruction[31:26] == 6'b100011); // lw
    assign mem_write = (instruction[31:26] == 6'b101011); // sw
    assign alu_src = (instruction[31:26] != 6'b000000);  // I-type
    assign reg_write = (instruction[31:26] == 6'b000000 || instruction[31:26] == 6'b100011); // R-type or lw
    assign alu_op = (instruction[31:26] == 6'b000000) ? 2'b10 : (instruction[31:26] == 6'b000100) ? 2'b01 : 2'b00;

    // ALU Control
    assign alu_control = (alu_op == 2'b00) ? 4'b0000 : // add
                         (alu_op == 2'b01) ? 4'b0001 : // sub
                         (instruction[5:0] == 6'b100000) ? 4'b0000 : // add
                         (instruction[5:0] == 6'b100010) ? 4'b0001 : // sub
                         (instruction[5:0] == 6'b100100) ? 4'b0010 : // and
                         (instruction[5:0] == 6'b100101) ? 4'b0011 : // or
                         (instruction[5:0] == 6'b101010) ? 4'b0100 : // slt
                         4'b0000;

    // Sign Extend
    assign sign_extend = {{16{instruction[15]}}, instruction[15:0]};
endmodule