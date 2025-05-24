module extend(
    input [31:7] immediate,
    input [1:0] Imm_src,
    output reg [31:0] Imm_extend
);

reg [31:0] aux_extend;

always @(*)
begin
    case(Imm_src)
        2'b00: begin // I-type
            aux_extend = immediate[31:20];
        end
        2'b01: begin // S-type
            aux_extend = {immediate[31:25], immediate[11:7]};
        end
        2'b10: begin // B-type
            aux_extend = {immediate[31], immediate[7], immediate[30:25], immediate[11:8]};
        end
        2'b11: begin // J-type
            aux_extend = {immediate[31], immediate[19:12], immediate[20], immediate[30:21]};
        end
    endcase

    Imm_extend = {{20{aux_extend[11]}}, aux_extend}; // Sign-extend the immediate value
end

endmodule