module mips_single_cycle (
    input wire clk,
    input wire reset,
    output wire [31:0] pc,
    output wire [31:0] instruction,
    output wire [31:0] reg_t0,
    output wire [31:0] reg_t1,
    output wire [31:0] reg_t2,
    output wire [31:0] reg_t3,
    output wire [31:0] mem_read_data,
    output wire [31:0] alu_result,
    output wire zero
);
<<<<<<< HEAD
    // Internal wires
    wire [31:0] pc_next, read_data_1, read_data_2, write_data;
    wire [31:0] sign_extend;
    wire [31:0] alu_input_2;  // Added this wire
    wire [3:0] alu_ctrl;
=======
    wire [31:0] pc_next, instruction, read_data_1, read_data_2, write_data;
    wire [31:0] mem_read_data, sign_extend, alu_result;
    wire [3:0] alu_control;
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
    wire [1:0] alu_op;
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;

    // Banco de registradores
    reg [31:0] reg_file [0:31];

    // Conecta os registradores às portas
    assign reg_t0 = reg_file[8];
    assign reg_t1 = reg_file[9];
    assign reg_t2 = reg_file[10];
    assign reg_t3 = reg_file[11];

    // Program Counter
    pc PC (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );

    assign pc_next = (jump) ? {pc[31:28], instruction[25:0], 2'b00} :
                     (branch & zero) ? (pc + 4 + (sign_extend << 2)) : (pc + 4);

    // Instruction Memory
    instruction_memory IM (
        .pc(pc),
        .instruction(instruction)
    );

    // Register File
    register_file RF (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg((reg_dst) ? instruction[15:11] : instruction[20:16]),
        .write_data(write_data),
        .read_data1(read_data_1),
        .read_data2(read_data_2)
    );

<<<<<<< HEAD

    // ALU
    assign alu_input_2 = (alu_src) ? sign_extend : read_data_2;

alu alu_inst (
        .a(read_data_1),
        .b(alu_input_2),
        .alu_ctrl(alu_ctrl),
=======
    // Control Unit
    control_unit CU (
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst),
        .jump(jump),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    // ALU
    alu ALU (
        .input_1(read_data_1),
        .input_2(alu_input_2),
        .alu_control(alu_control),
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
        .result(alu_result),
        .zero(zero)
);

    // ALU Control
    alu_control_unit ALU_CTRL (
        .alu_op(alu_op),
        .funct(instruction[5:0]),
        .alu_control(alu_control)
    );

    // Sign Extension
    sign_extension SE (
        .immediate(instruction[15:0]),
        .sign_extend(sign_extend)
    );

    // Data Memory
    data_memory DM (
        .clk(clk),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data_2),
        .read_data(mem_read_data)
    );

    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;
endmodule


`timescale 1ns/1ps
module mips(
    input         clk,
    input         reset
);

    // -----------------------------
    // Registrador de PC
    // -----------------------------
    reg [31:0] pc;
    wire [31:0] pc_plus_4, next_pc;

    // -----------------------------
    // Conexões internas
    // -----------------------------
    wire [31:0] instr;
    // Campos da instrução
    wire [5:0] opcode = instr[31:26];
    wire [4:0] rs     = instr[25:21];
    wire [4:0] rt     = instr[20:16];
    wire [4:0] rd     = instr[15:11];
    wire [15:0] imm   = instr[15:0];
    wire [5:0] funct  = instr[5:0];

    // Sinais de controle
    wire RegDst, ALUSrc, MemtoReg, RegWrite;
    wire MemRead, MemWrite, Branch, Jump;
    wire [1:0] ALUOp;

    // Sinais de conexão para a ALU e demais módulos
    wire [31:0] read_data1, read_data2;
    wire [31:0] sign_ext_imm;
    wire [3:0]  alu_control;
    wire [31:0] alu_result;
    wire        alu_zero;
    wire [31:0] mem_read_data;

    // -----------------------------
    // Bloco: Atualização do PC
    // -----------------------------
    assign pc_plus_4 = pc + 4;
    
    // Cálculo de endereço para branch (shift <<2)
    wire [31:0] branch_addr = pc_plus_4 + (sign_ext_imm << 2);
    // Endereço de salto: junta os 4 bits mais significativos do PC+4 com o campo jump (26 bits) + 2 bits 0
    wire [31:0] jump_addr   = {pc_plus_4[31:28], instr[25:0], 2'b00};

    // Seleção do próximo PC:
    // Se for jump, usa jump_addr; se for branch e alu_zero = 1, usa branch_addr; senão, pc+4
    assign next_pc = Jump ? jump_addr :
                     (Branch & alu_zero) ? branch_addr :
                     pc_plus_4;
                     
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= next_pc;
    end

    // -----------------------------
    // Memória de Instruções (ROM)
    // -----------------------------
    imem imem_inst(
        .addr(pc),
        .instr(instr)
    );
    
    // -----------------------------
    // Unidade de Controle
    // -----------------------------
    control_unit ctrl(
        .opcode(opcode),
        .funct(funct),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );
    
    // -----------------------------
    // Banco de Registradores
    // -----------------------------
    // Se RegDst = 1, o destino é rd (R‑type); senão, rt (lw)
    reg_file rf(
        .clk(clk),
        .RegWrite(RegWrite),
        .rs(rs),
        .rt(rt),
        .rd(RegDst ? rd : rt),
        .writeData(MemtoReg ? mem_read_data : alu_result),
        .readData1(read_data1),
        .readData2(read_data2)
    );
    
    // -----------------------------
    // Extensor de Sinal
    // -----------------------------
    assign sign_ext_imm = {{16{imm[15]}}, imm};

    // -----------------------------
    // Unidade de Controle da ALU
    // -----------------------------
    alu_control_unit alu_ctrl(
        .ALUOp(ALUOp),
        .funct(funct),
        .alu_control(alu_control)
    );
    
    // -----------------------------
    // ALU
    // -----------------------------
    // Se ALUSrc = 1, o segundo operando vem do extensor; senão, do banco de registradores
    alu alu_inst(
        .a(read_data1),
        .b(ALUSrc ? sign_ext_imm : read_data2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );
    
    // -----------------------------
    // Memória de Dados
    // -----------------------------
    dmem dmem_inst(
        .clk(clk),
        .addr(alu_result),
        .writeData(read_data2),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .readData(mem_read_data)
    );

endmodule
