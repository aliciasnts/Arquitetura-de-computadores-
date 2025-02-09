module sign_extension (
    input wire [15:0] immediate,
    output wire [31:0] sign_extend
);
    assign sign_extend = {{16{immediate[15]}}, immediate};
endmodule