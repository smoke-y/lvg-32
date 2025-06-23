module relu(
    input wire[31:0] x,
    input wire clk,
    output reg[31:0] out
);

always @(posedge clk) begin
    if(x[31] == 0) begin
        out <= x;
    end else begin
        out <= 32'h0;
    end
end

endmodule
