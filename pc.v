<<<<<<< HEAD
module pc(
    input clk,
    input reset,
    input [31:0] pc_next,
=======
module pc (
    input wire clk,
    input wire reset,
    input wire [31:0] pc_next,
>>>>>>> parent of 3ffac98 (acho que fiz progresso)
    output reg [31:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;  // Reinicia o PC para 0 no reset
        else
            pc <= pc_next;
    end
endmodule