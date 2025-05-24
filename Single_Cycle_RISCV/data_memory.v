module data_memory(
    input clk,
    input write_enable,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);
    reg [31:0] data_mem [10000:0];

    always @(posedge clk)
    begin
        if (write_enable)
            data_mem[address] <= write_data;
        else
            read_data <= data_mem[address];
    end
endmodule