`timescale 1ns/1ps

module tb_mips_single_cycle;
    reg clk;
    reg reset;
    integer i;

    // Sinais de saída do módulo mips_single_cycle
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] reg_t0, reg_t1, reg_t2, reg_t3;
    wire [31:0] mem_read_data;
    wire [31:0] alu_result;
    wire zero;

    // Instância do processador
    mips_single_cycle uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .reg_t0(reg_t0),
        .reg_t1(reg_t1),
        .reg_t2(reg_t2),
        .reg_t3(reg_t3),
        .mem_read_data(mem_read_data),
        .alu_result(alu_result),
        .zero(zero)
    );

    // Geração do clock
   always #10 clk = ~clk;

    // Inicialização e monitoramento
    initial begin

          for(integer i = 0; i < 256; i = i + 1) begin
        uut.IM.memory[i] = 32'b0;
    end

        // Inicializa arquivo de onda (se necessário)
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_mips_single_cycle);

        // Inicializa clock e reset
        clk = 0;
        reset = 1;

<<<<<<< HEAD
        // Carrega as instruções na memória
        uut.IM.memory[0] = 32'h20090005; // addi $t1, $zero, 5
        uut.IM.memory[1] = 32'h200A000A; // addi $t2, $zero, 10
        uut.IM.memory[2] = 32'h012A4020; // add $t0, $t1, $t2
        uut.IM.memory[3] = 32'h012A4022; // sub $t0, $t1, $t2
        uut.IM.memory[4] = 32'h012A4024; // and $t0, $t1, $t2
        uut.IM.memory[5] = 32'h012A4025; // or $t0, $t1, $t2
        uut.IM.memory[6] = 32'hAC0A0000; // sw $t2, 0($zero)
        uut.IM.memory[7] = 32'h8C0B0000; // lw $t3, 0($zero)
        uut.IM.memory[8] = 32'h11690002; // beq $t3, $t1, próximo
        uut.IM.memory[9] = 32'h08000000; // j 0 (loop infinito)

        // Mensagem inicial
        $display("================================================");
        $display("Iniciando simulação do MIPS single-cycle");
        $display("================================================");

        // Desativa reset após 10 ns
        #10 reset = 0;
        $display("[Tempo %0t] Reset desativado.", $time);

        // Configura o $monitor para acompanhar mudanças nos sinais principais
        $monitor("[Tempo %0t] PC = 0x%h | Instrução = 0x%h | $t0 = 0x%h | $t1 = 0x%h | $t2 = 0x%h | $t3 = 0x%h | ALU Result = 0x%h | Zero = %b | Mem Read Data = 0x%h",
                 $time, pc, instruction, reg_t0, reg_t1, reg_t2, reg_t3, alu_result, zero, mem_read_data);

        // Executa por 200 ns
        #200;

        // Exibe resultados finais
        $display("\n================================================");
        $display("Resultados finais:");
        $display("================================================");
        $display("PC final: 0x%h", pc);
        $display("Conteúdo de registradores:");
        $display("  - Registrador \$t0 (reg[8]) = 0x%h", reg_t0);
        $display("  - Registrador \$t1 (reg[9]) = 0x%h", reg_t1);
        $display("  - Registrador \$t2 (reg[10]) = 0x%h", reg_t2);
        $display("  - Registrador \$t3 (reg[11]) = 0x%h", reg_t3);
        $display("Resultado final da ALU: 0x%h", alu_result);
        $display("Flag Zero: %b", zero);
        $display("Dado lido da memória: 0x%h", mem_read_data);
        $display("================================================");

        // Finaliza a simulação
        $finish;
=======
        // Limpa memória e registradores antes do teste
        for (i = 0; i < 1024; i = i + 1) uut.memory[i] = 32'h0;
        for (i = 0; i < 32; i = i + 1) uut.reg_file[i] = 32'h0;

        // Define o programa de teste na memória de instruções
        uut.memory[0] = 32'h20090005; // addi $t1, $zero, 5
        uut.memory[1] = 32'h200A000A; // addi $t2, $zero, 10
        uut.memory[2] = 32'h012A4020; // add $t0, $t1, $t2
        uut.memory[3] = 32'h012A4022; // sub $t0, $t1, $t2
        uut.memory[4] = 32'h012A4024; // and $t0, $t1, $t2
        uut.memory[5] = 32'h012A4025; // or $t0, $t1, $t2
        uut.memory[6] = 32'hAC0A0000; // sw $t2, 0($zero)
        uut.memory[7] = 32'h8C0B0000; // lw $t3, 0($zero)
        uut.memory[8] = 32'h11690002; // beq $t3, $t1, próximo
        uut.memory[9] = 32'h08000000; // j 0 (loop infinito)

        // Aguarda um ciclo e desativa reset
        #10;
        reset = 0;

        // Executa por tempo suficiente para verificar todas as instruções
        #200;

        // Testa se os valores esperados estão corretos
        if (uut.reg_file[9] !== 5) 
            $display("Erro: $t1 deveria ser 5, mas é %d", uut.reg_file[9]);
        if (uut.reg_file[10] !== 10) 
            $display("Erro: $t2 deveria ser 10, mas é %d", uut.reg_file[10]);
        if (uut.reg_file[8] !== (uut.reg_file[9] + uut.reg_file[10])) 
            $display("Erro: $t0 deveria ser %d, mas é %d", uut.reg_file[9] + uut.reg_file[10], uut.reg_file[8]);
        if (uut.memory[0] !== uut.reg_file[10]) 
            $display("Erro: Memória[0] deveria ser %d, mas é %d", uut.reg_file[10], uut.memory[0]);
        if (uut.reg_file[11] !== uut.memory[0]) 
            $display("Erro: $t3 deveria conter %d após lw, mas contém %d", uut.memory[0], uut.reg_file[11]);

        // Verifica o funcionamento do reset
        reset = 1;
        #10;
        reset = 0;
        if (uut.pc !== 0)
            $display("Erro: PC deveria ser 0 após reset, mas é %h", uut.pc);
        for (i = 0; i < 32; i = i + 1) begin
            if (uut.reg_file[i] !== 0)
                $display("Erro: Reg[%0d] deveria ser 0 após reset, mas é %h", i, uut.reg_file[i]);
        end

        // Fim do teste
        $display("Simulação concluída.");
        $stop;
    end

    // Monitoramento dos sinais a cada ciclo de clock
    always @(posedge clk) begin
        $display("--------------------------------------------------");
        $display("Ciclo de Clock: %0t", $time);
        $display("PC = %h", uut.pc);
        $display("Instrução = %h", uut.instruction);
        $display("Read Data 1 (Reg[rs]) = %h", uut.read_data_1);
        $display("Read Data 2 (Reg[rt]) = %h", uut.read_data_2);
        $display("Sign Extend = %h", uut.sign_extend);
        $display("ALU Input 2 = %h", uut.alu_input_2);
        $display("ALU Control = %b", uut.alu_control);
        $display("ALU Result = %h", uut.alu_result);
        $display("Zero Flag = %b", uut.zero);
        $display("Mem Read Data = %h", uut.mem_read_data);
        $display("Write Data (Reg[rd]/Reg[rt]) = %h", uut.write_data);
        $display("Reg[8] ($t0) = %h", uut.reg_file[8]);
        $display("Reg[9] ($t1) = %h", uut.reg_file[9]);
        $display("Reg[10] ($t2) = %h", uut.reg_file[10]);
        $display("Reg[11] ($t3) = %h", uut.reg_file[11]);
        $display("--------------------------------------------------");
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
    end
endmodule