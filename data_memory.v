<<<<<<< HEAD
module data_memory(
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:256]; // Memória com 256 posições de 32 bits
    integer i;

    initial begin
        for(i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
    end

    assign read_data = mem_read ? memory[addr[7:0]] : 32'b0;

=======
module data_memory (
    input wire clk,
    input wire mem_write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);
    reg [31:0] memory [1023:0];

>>>>>>> parent of 3ffac98 (acho que fiz progresso)
    always @(posedge clk) begin
        if (mem_write)
            memory[address >> 2] <= write_data;
    end

    assign read_data = memory[address >> 2];
endmodule
