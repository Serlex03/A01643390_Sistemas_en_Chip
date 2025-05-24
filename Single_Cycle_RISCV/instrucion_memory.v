module instruction_memory(
    input [31:0] address,
    output [31:0] read_data
);
    reg [31:0] instr_mem [0:10000];

    initial
    begin
        $readmemh("instructions.txt", instr_mem);
    end

    assign read_data = instr_mem[address[31:2]]; // Assuming address is word-aligned

endmodule
