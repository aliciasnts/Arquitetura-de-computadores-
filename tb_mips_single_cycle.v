`timescale 1ns/1ps

module tb_mips_single_cycle;
    reg clk;
    reg reset;

    // Instância do processador
    mips_single_cycle uut (
        .clk(clk),
        .reset(reset)
    );

    // Geração do clock
    always #5 clk = ~clk;

    // Inicialização
    initial begin
        clk = 0;
        reset = 1;
        #10;
        reset = 0;

        // Aguarda a execução do programa
        #200;

        // Finaliza a simulação
        $stop;
    end
endmodule