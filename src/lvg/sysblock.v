`include "src/lvg/fp/fpmul.v"
`ifndef FPADD 
`define FPADD
`include "src/lvg/fp/fpadd.v"
`endif

module sysblock(
    input wire [31:0] up, left,
    input wire clk,
    input wire rst,
    output reg [31:0] down, right,
    output reg [31:0] res
);

wire [31:0] mul_res, res_next;

fpmul fmul(.a(up), .b(left), .s(mul_res));
fpadd fadd(.a(res), .b(mul_res), .s(res_next));

always @(posedge clk or posedge rst) begin
    if(rst) begin
        down <= 0;
        right <= 0;
        res <= 0;
    end
    else begin
        down <= up;
        right <= left;
        res <= res_next;
    end
end

endmodule
