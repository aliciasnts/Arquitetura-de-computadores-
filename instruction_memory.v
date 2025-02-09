module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instruction
);
    reg [31:0] memory [1023:0];
    assign instruction = memory[pc >> 2];
endmodule