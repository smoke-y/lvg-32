`include "src/lvg/lvg.v"

module tb_lvg();

wire[31:0] b11, b12, b13, b14, b21, b22, b23, b24, b31, b32, b33, b34, b41, b42, b43, b44;
reg[31:0] l11, l12, l13, l14, l21, l22, l23, l24, l31, l32, l33, l34, l41, l42, l43, l44;
reg[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;
reg[31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44;
reg rst = 1'b1;
reg clk = 1'b1;
reg[7:0] instr;
always #5 clk = ~clk;

lvg _lvg(
    l11, l12, l13, l14, l21, l22, l23, l24, l31, l32, l33, l34, l41, l42, l43, l44,
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    instr,
    clk, rst,
    b11, b12, b13, b14, b21, b22, b23, b24, b31, b32, b33, b34, b41, b42, b43, b44
);

initial begin
    rst <= 1'b1;
    instr <= 8'b0;

    @(posedge clk);
    rst <= 1'b0;
    instr <= 8'd2;

    r11 <= 32'h3f800000;
    r12 <= 32'h3f800000;
    r13 <= 32'h3f800000;
    r14 <= 32'h3f800000;
    r21 <= 32'h3f800000;
    r22 <= 32'h3f800000;
    r23 <= 32'h3f800000;
    r24 <= 32'h3f800000;
    r31 <= 32'h3f800000;
    r32 <= 32'h3f800000;
    r33 <= 32'h3f800000;
    r34 <= 32'h3f800000;
    r41 <= 32'h3f800000;
    r42 <= 32'h3f800000;
    r43 <= 32'h3f800000;
    r44 <= 32'h3f800000;

    @(posedge clk)
    instr <= 8'd1;

    l11 <= 32'h3f800000;
    l12 <= 32'h3f800000;
    l13 <= 32'h3f800000;
    l14 <= 32'h3f800000;
    l21 <= 32'h3f800000;
    l22 <= 32'h3f800000;
    l23 <= 32'h3f800000;
    l24 <= 32'h3f800000;
    l31 <= 32'h3f800000;
    l32 <= 32'h3f800000;
    l33 <= 32'h3f800000;
    l34 <= 32'h3f800000;
    l41 <= 32'h3f800000;
    l42 <= 32'h3f800000;
    l43 <= 32'h3f800000;
    l44 <= 32'h3f800000;
    l11 <= 32'h3f800000;
    l12 <= 32'h3f800000;

    @(posedge clk);
    instr <= 8'd4;
    waitAndDisplay();

    a11 <= 32'h3f800000;
    a12 <= 32'h3f800000;
    a13 <= 32'h3f800000;
    a14 <= 32'h3f800000;
    a21 <= 32'h3f800000;
    a22 <= 32'h3f800000;
    a23 <= 32'h3f800000;
    a24 <= 32'h3f800000;
    a31 <= 32'h3f800000;
    a32 <= 32'h3f800000;
    a33 <= 32'h3f800000;
    a34 <= 32'h3f800000;
    a41 <= 32'h3f800000;
    a42 <= 32'h3f800000;
    a43 <= 32'h3f800000;
    a44 <= 32'h3f800000;
    instr <= 8'd5;
    waitAndDisplay();

    instr <= 8'd6;
    waitAndDisplay();

    instr <= 8'd7;
    waitAndDisplay();

    $finish;
end

task waitAndDisplay(); begin
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
    $display("\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _lvg.b11, _lvg.b12, _lvg.b13, _lvg.b14,
        _lvg.b21, _lvg.b22, _lvg.b23, _lvg.b24,
        _lvg.b31, _lvg.b32, _lvg.b33, _lvg.b34,
        _lvg.b41, _lvg.b42, _lvg.b43, _lvg.b44
    );
end
endtask

endmodule
