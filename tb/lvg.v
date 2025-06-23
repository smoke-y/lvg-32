`include "src/lvg.v"

module tb_lvg();

reg[31:0] m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44;
reg[31:0] n11, n12, n13, n14, n21, n22, n23, n24, n31, n32, n33, n34, n41, n42, n43, n44;
reg rst = 1'b1;
reg clk = 1'b1;
reg load = 1'b1;
always #5 clk = ~clk;

lvg _lvg(
    m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44,
    n11, n12, n13, n14, n21, n22, n23, n24, n31, n32, n33, n34, n41, n42, n43, n44,
    clk, rst, load
);

initial begin
    @(posedge clk);
    rst <= 1'b1;
    load <= 1'b1;
    m11 <= 32'h3e9cdd17;
    m12 <= 32'h0;
    m13 <= 32'h0;
    m14 <= 32'h0;
    m21 <= 32'h3ee3e433;
    m22 <= 32'h0;
    m23 <= 32'h0;
    m24 <= 32'h0;
    m31 <= 32'h0;
    m32 <= 32'h0;
    m33 <= 32'h0;
    m34 <= 32'h0;
    m41 <= 32'h0;
    m42 <= 32'h0;
    m43 <= 32'h0;
    m44 <= 32'h0;

    n11 <= 32'h3f800000;
    n12 <= 32'h0;
    n13 <= 32'h0;
    n14 <= 32'h0;
    n21 <= 32'h3f800000;
    n22 <= 32'h0;
    n23 <= 32'h0;
    n24 <= 32'h0;
    n31 <= 32'h0;
    n32 <= 32'h0;
    n33 <= 32'h0;
    n34 <= 32'h0;
    n41 <= 32'h0;
    n42 <= 32'h0;
    n43 <= 32'h0;
    n44 <= 32'h0;

    @(posedge clk)
    rst <= 1'b0;
    load <= 1'b0;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    $display("count: %d\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _lvg.count,
        _lvg.r11, _lvg.r12, _lvg.r13, _lvg.r14,
        _lvg.r21, _lvg.r22, _lvg.r23, _lvg.r24,
        _lvg.r31, _lvg.r32, _lvg.r33, _lvg.r34,
        _lvg.r41, _lvg.r42, _lvg.r43, _lvg.r44
    );

    $finish;
end

endmodule
