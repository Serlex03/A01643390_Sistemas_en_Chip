module Single_Cycle_RISCV(
    input clk
);

wire [31:0] PCTarget;
wire [31:0] PCPlus4;
wire PCSrc;
wire [31:0] Imm_extend;

wire [31:0] PCNext=PCSrc? PCTarget:PCPlus4;
wire [31:0] Inst;
reg [31:0] PC;

assign PCTarget = PC + Imm_extend;
assign PCPlus4 = PC + 4;

always @(posedge clk) begin
    PC <= PCNext;
end

instruction_memory IM(
    .address(PC),
    .read_data(Inst)
);

wire [31:0] result;
wire RegWrite;
wire [31:0] SrcA;
wire [31:0] read_data2;

register_file RF(
    .clk(clk),
    .A1(Inst[19:15]),
    .A2(Inst[24:20]),
    .A3(Inst[11:7]),
    .write_enable3(RegWrite),
    .write_data3(result),
    .read_data1(SrcA),
    .read_data2(read_data2)
);

wire ALUSrc;
wire [31:0] SrcB=ALUSrc? Imm_extend:read_data2;
wire [1:0] ImmSrc;

extend EXT(
    .immediate(Inst[31:7]),
    .Imm_src(ImmSrc),
    .Imm_extend(Imm_extend)
);

wire [2:0] ALUControl;
wire [3:0] ALUResult;
wire zero;

ALU ALU(
    .src_A(SrcA),
    .src_B(SrcB),
    .ALU_control(ALUControl),
    .ALU_result(ALUResult),
    .zero(zero)
);

wire MemWrite;
wire [31:0] read_data;
wire ResultSrc;

data_memory DM(
    .clk(clk),
    .write_enable(MemWrite),
    .address(ALUResult),
    .write_data(read_data2),
    .read_data(read_data)
);

assign result = ResultSrc ? read_data : ALUResult;

control_unit CU(
    .op(Inst[6:0]),
    .funct3(Inst[14:12]),
    .funct7b5(Inst[30]),
    .zero(zero),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc)
);

endmodule