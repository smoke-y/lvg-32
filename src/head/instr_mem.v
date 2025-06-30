module instr_mem(
    input wire clk,
    input wire[7:0] addr,
    output reg[15:0] instr
);

reg[15:0] mem[100:0];

always @(posedge clk) begin
    instr <= mem[addr];
end

endmodule
