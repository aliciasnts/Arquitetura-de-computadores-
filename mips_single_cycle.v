module mips_single_cycle(
    input wire clk,
    input wire reset,
    output wire [31:0] alu_input_2
);
    wire [31:0] pc_next, instruction, read_data_1, read_data_2, write_data;
    wire [31:0] pc; // Declaração PC (32 bits)
    wire [31:0] mem_read_data, sign_extend, alu_result;
    wire [3:0] alu_ctrl;
    wire [1:0] alu_op;
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, zero;
    wire [1:0] pc_src;

    assign pc_src = (jump) ? 2'b10 : (branch & zero) ? 2'b01 : 2'b00;
    assign alu_input_2 = (alu_src) ? sign_extend : read_data_2;

    // Program Counter
  pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next), 
        .pc(pc)
);
    assign pc_next = (jump) ? {pc[31:28], instruction[25:0], 2'b00} :
                     (branch & zero) ? (pc + 4 + (sign_extend << 2)) : (pc + 4);

    // Memória de Instruções
    instruction_memory IM (
        .addr(pc),
        .instruction(instruction)
);

    // Unidade de Controle
    control_unit cu_inst (
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );

    // Banco de Registradores
    register_file rf_inst (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg((reg_dst) ? instruction[15:11] : instruction[20:16]),
        .write_data(write_data),
        .read_data1(read_data_1),
        .read_data2(read_data_2)
    );

    // ALU
    alu alu_inst (
        .a(read_data_1),
        .b(alu_input_2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );

    // Unidade de Controle da ALU
    alu_control_unit alu_ctrl_inst (
        .alu_op(alu_op),
        .funct(instruction[5:0]),
        .alu_ctrl(alu_ctrl)
    );

    // Extensão de Sinal
    sign_extension se_inst (
        .immediate(instruction[15:0]),
        .extended(sign_extend)
    );

    // Memória de Dados
    data_memory dm_inst (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(read_data_2),
        .read_data(mem_read_data)
    );

    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;
endmodule