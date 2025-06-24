`include "src/activation/relu.v"

module tb_relu();

reg[31:0] x;
reg clk = 1'b1;
always #5 clk = ~clk;
wire[31:0] out;

relu unit(x, clk, 1'b1, out);

initial begin
    x <= 0;

    @(posedge clk)
    @(posedge clk)
    stat();
    x <= 32'hbf800000;

    @(posedge clk)
    @(posedge clk)
    stat();
    x <= 32'h3f800000;

    @(posedge clk)
    @(posedge clk)
    stat();

    $finish;
end

task stat();
    $display("relu(%h) = %h", x, out);
endtask

endmodule
