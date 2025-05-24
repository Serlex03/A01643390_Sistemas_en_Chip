module control_unit(
    input [6:0] op,
    input [14:12] funct3,
    input [31:0] funct7b5,
    input zero,
    output PCSrc,
    output ResultSrc,
    output MemWrite,
    output [2:0] ALUControl,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite
);

    wire [1:0] ALUOp;
    wire branch;

    main_decoder md(
        .op(op),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp)
    );

    ALU_decoder ad(
        .op5(op[5]),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    assign PCSrc = (Branch & zero) | Jump;

endmodule