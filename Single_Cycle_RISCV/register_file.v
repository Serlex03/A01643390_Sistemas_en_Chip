module register_file(
    input clk,
    input write_enable3,
    input [4:0] A1, A2, A3,
    input [31:0] write_data3,
    output reg [31:0] read_data1, read_data2
);

reg [31:0] registers [0:31];

always @(*) 
begin
    read_data1 = registers[A1];
    read_data2 = registers[A2];
end

endmodule