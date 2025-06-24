`include "src/lvg.v"

module tb_lvg();

reg[31:0] l11, l12, l13, l14, l21, l22, l23, l24, l31, l32, l33, l34, l41, l42, l43, l44;
reg[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;
reg[31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44;
reg rst = 1'b1;
reg clk = 1'b1;
reg[15:0] instr;
always #5 clk = ~clk;

lvg _lvg(
    l11, l12, l13, l14, l21, l22, l23, l24, l31, l32, l33, l34, l41, l42, l43, l44,
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    instr,
    clk, rst
);

initial begin
    rst <= 1'b1;
    instr[7:0] <= 8'b0;

    @(posedge clk);
    rst <= 1'b0;
    instr[7:0] <= 8'd2;

    r11 <= 32'h3e9cdd17;
    r12 <= 32'h0;
    r13 <= 32'h0;
    r14 <= 32'h0;
    r21 <= 32'h3ee3e433;
    r22 <= 32'h0;
    r23 <= 32'h0;
    r24 <= 32'h0;
    r31 <= 32'h0;
    r32 <= 32'h0;
    r33 <= 32'h0;
    r34 <= 32'h0;
    r41 <= 32'h0;
    r42 <= 32'h0;
    r43 <= 32'h0;
    r44 <= 32'h0;

    @(posedge clk)
    instr[7:0] <= 8'd1;

    l11 <= 32'h3f800000;
    l12 <= 32'h3f800000;
    l13 <= 32'h0;
    l14 <= 32'h0;
    l21 <= 32'h0;
    l22 <= 32'h0;
    l23 <= 32'h0;
    l24 <= 32'h0;
    l31 <= 32'h0;
    l32 <= 32'h0;
    l33 <= 32'h0;
    l34 <= 32'h0;
    l41 <= 32'h0;
    l42 <= 32'h0;
    l43 <= 32'h0;
    l44 <= 32'h0;

    @(posedge clk);
    instr[7:0] <= 8'd3;

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
        _lvg.sysCount,
        _lvg.b11, _lvg.b12, _lvg.b13, _lvg.b14,
        _lvg.b21, _lvg.b22, _lvg.b23, _lvg.b24,
        _lvg.b31, _lvg.b32, _lvg.b33, _lvg.b34,
        _lvg.b41, _lvg.b42, _lvg.b43, _lvg.b44
    );

    $finish;
end

endmodule
