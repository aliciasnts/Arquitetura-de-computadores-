<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
module pc(
    input clk,
    input reset,
    input [31:0] pc_next,
=======
=======
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
module pc (
    input wire clk,
    input wire reset,
    input wire [31:0] pc_next,
<<<<<<< HEAD
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
    output reg [31:0] pc
=======
// Program Counter (PC)
module pc(
    input clk,                   // Sinal de clock
    input reset,                 // Sinal de reset
    input [31:0] pc_next,        // Próximo valor do PC
    output reg [31:0] pc         // Valor atual do PC
>>>>>>> parent of 5ff6c89 (desisto)
=======
    output reg [31:0] pc
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;  // Reinicia o PC para 0 no reset
        else
            pc <= pc_next;
    end
endmodule