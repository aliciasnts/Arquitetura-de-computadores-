module mips_single_cycle (
    input wire clk,
    input wire reset,
    output wire [31:0] alu_input_2

);
    wire [31:0] pc_next, instruction, read_data_1, read_data_2, write_data;
    wire [31:0] mem_read_data, sign_extend, alu_result;
    wire [3:0] alu_control;
    wire [1:0] alu_op;
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, zero;
    wire [1:0] pc_src;   
    assign pc_src = (jump) ? 2'b10 : (branch & zero) ? 2'b01 : 2'b00;
    assign alu_input_2 = (alu_src) ? sign_extend : read_data_2;


    // Program Counter
    reg [31:0] pc;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;  // Reinicia o PC para 0 no reset
        end else begin
            pc <= pc_next;
        end
    end

    assign pc_next = (jump) ? {pc[31:28], instruction[25:0], 2'b00} :
                     (branch & zero) ? (pc + 4 + (sign_extend << 2)) : (pc + 4);

    // Instruction Memory
    reg [31:0] memory [1023:0];
    assign instruction = memory[pc >> 2];

    // Register File
    reg [31:0] reg_file [31:0];
    integer i; 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 0;
        end
        else if (reg_write)
            reg_file[(reg_dst) ? instruction[15:11] : instruction[20:16]] <= write_data;
    end
    assign read_data_1 = reg_file[instruction[25:21]];
    assign read_data_2 = reg_file[instruction[20:16]];

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
        .input_2((alu_src) ? sign_extend : read_data_2),
        .alu_control(alu_control),
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
    assign sign_extend = {{16{instruction[15]}}, instruction[15:0]};

    // Data Memory
    reg [31:0] data_memory [1023:0];
    always @(posedge clk) begin
        if (mem_write)
            data_memory[alu_result >> 2] <= read_data_2;
    end
    assign mem_read_data = data_memory[alu_result >> 2];

    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;
    
endmodule