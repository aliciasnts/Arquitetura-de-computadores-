//`include "03_mips/MIPS.v"
//`include "SEG7_LUT_8.v"
module cascaA(
    input [3:0] KEY,
    input CLOCK_50,
    input [4:0] SW,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,
    output [6:0] HEX6,
    output [6:0] HEX7,
    output [17:0] LEDR,  
    output [7:0] LEDG
);
    wire [31:0] instrucaoAtual;
    logic [31:0] valores;
    wire [31:0] registradores [31:0];
    
    MIPS processador(
        .clk(~KEY[2]),
        .reset(~KEY[1]),
        .inst(instrucaoAtual),
        .ProgramCounter(LEDG),
        .dump_registradores(registradores)
    );
    
    SEG7_LUT_8 s8(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, valores);
    
    always@(*) begin
        if (SW == 5'b00000) valores <= instrucaoAtual;
        else valores <= registradores[SW];
    end
    
    assign LEDR = valores[17:0];
    
endmodule
