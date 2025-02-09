module register_file (
    input wire clk,
    input wire reset,
    input wire reg_write,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);
    reg [31:0] reg_file [31:0];
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 0;
        end
        else if (reg_write)
            reg_file[write_reg] <= write_data;
    end

    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];
endmodule