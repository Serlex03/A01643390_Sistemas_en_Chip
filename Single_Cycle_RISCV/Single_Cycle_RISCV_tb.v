module Single_Cycle_RISCV_tb;

reg clk = 0;

Single_Cycle_RISCV DUT(
    .clk(clk)
);

always #5 clk = ~clk;

initial 
begin
    clk = 0;
    #100;
    $stop;
end

endmodule