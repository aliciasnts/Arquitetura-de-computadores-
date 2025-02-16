module pc(
    input clk,
    input reset,
    input [31:0] pc_next,
    output reg [31:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0; // Reinicializa o PC se o reset estiver ativo
        else
            pc <= pc_next; // Atualiza o PC com o próximo valor
    end
endmodule