module alu (
    input wire [31:0] input_1,
    input wire [31:0] input_2,
    input wire [3:0] alu_control,
    output reg [31:0] result,
    output reg zero
);
    always @(*) begin
        case (alu_control)
            4'b0000: result = input_1 + input_2; // add
            4'b0001: result = input_1 - input_2; // sub
            4'b0010: result = input_1 & input_2; // and
            4'b0011: result = input_1 | input_2; // or
            4'b0100: result = (input_1 < input_2) ? 1 : 0; // slt
            default: result = 0;
        endcase
        zero = (result == 0);
    end
endmodule