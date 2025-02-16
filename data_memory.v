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

    always @(posedge clk) begin
        if (mem_write) memory[addr[7:0]] <= write_data;
    end
endmodule