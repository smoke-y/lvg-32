module relu(
    input wire[31:0] x,
    input wire clk,
    output reg[31:0] out
);

always @(posedge clk) begin
    if(x[31] == 0) out <= x;
    else out <= 32'h0;
end

endmodule
