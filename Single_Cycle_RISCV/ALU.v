module ALU(
    input [31:0] src_A,
    input [31:0] src_B,
    input [3:0] ALU_control,
    output reg [31:0] ALU_result,
    output reg zero
);

always @(*)
begin
    if(ALU_result == 0)
        zero = 1;
    else
        zero = 0;
    case(ALU_control)
        4'b0000: ALU_result = src_A & src_B; // AND
        4'b0001: ALU_result = src_A | src_B; // OR
        4'b0010: ALU_result = src_A + src_B; // ADD
        4'b0110: ALU_result = src_A - src_B; // SUB
        4'b0111: ALU_result = (src_A < src_B) ? 1 : 0; // SLT
        4'b1100: ALU_result = ~(src_A | src_B); // NOR
        default: ALU_result = 32'b0; // Default case
    endcase
end

endmodule