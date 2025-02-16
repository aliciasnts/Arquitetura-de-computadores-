module instruction_memory(
    input [31:0] addr,           // Input address
    output reg [31:0] instruction // Output instruction
);
    // Memory array - 256 words of 32 bits each
    reg [31:0] memory [0:255];   
    integer i;

    // Initialize memory with program instructions
    initial begin
        // First initialize all memory locations to 0
        for(i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'b0;
        end
        
        // Then load the program instructions
        memory[0] = 32'h20090005; // addi $t1, $zero, 5
        memory[1] = 32'h200A000A; // addi $t2, $zero, 10
        memory[2] = 32'h012A4020; // add $t0, $t1, $t2
        memory[3] = 32'h012A4022; // sub $t0, $t1, $t2
        memory[4] = 32'h012A4024; // and $t0, $t1, $t2
        memory[5] = 32'h012A4025; // or $t0, $t1, $t2
        memory[6] = 32'hAC0A0000; // sw $t2, 0($zero)
        memory[7] = 32'h8C0B0000; // lw $t3, 0($zero)
        memory[8] = 32'h11690002; // beq $t3, $t1, próximo
        memory[9] = 32'h08000000; // j 0
    end

    // Read instruction from memory
    // Note: addr[9:2] is used for word-aligned access (each instruction is 4 bytes)
    always @(*) begin
        instruction = memory[addr[9:2]];
    end

endmodule