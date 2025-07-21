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

    r11 <= 32'h3fce5aee;
    r12 <= 32'hbf962806;
    r13 <= 32'hbe8b70d6;
    r14 <= 32'hbfa34577;
    r21 <= 32'h3fcef750;
    r22 <= 32'hbf849a19;
    r23 <= 32'h3e422aab;
    r24 <= 32'h3efac258;
    r31 <= 32'h00000000;
    r32 <= 32'h00000000;
    r33 <= 32'h00000000;
    r34 <= 32'h00000000;
    r41 <= 32'h00000000;
    r42 <= 32'h00000000;
    r43 <= 32'h00000000;
    r44 <= 32'h00000000;
    @(posedge clk);
    instr <= 8'd3;

    a11 <= 32'hbfd2cfe4;
    a12 <= 32'h3f67aa55;
    a13 <= 32'hbe5ad35d;
    a14 <= 32'hbec98ed1;
    a21 <= 32'h00000000;
    a22 <= 32'h00000000;
    a23 <= 32'h00000000;
    a24 <= 32'h00000000;
    a31 <= 32'h00000000;
    a32 <= 32'h00000000;
    a33 <= 32'h00000000;
    a34 <= 32'h00000000;
    a41 <= 32'h00000000;
    a42 <= 32'h00000000;
    a43 <= 32'h00000000;
    a44 <= 32'h00000000;

    @(posedge clk)
    instr <= 8'd1;

    l11 <= 32'h00000000;
    l12 <= 32'h00000000;
    l13 <= 32'h00000000;
    l14 <= 32'h00000000;
    l21 <= 32'h00000000;
    l22 <= 32'h00000000;
    l23 <= 32'h00000000;
    l24 <= 32'h00000000;
    l31 <= 32'h00000000;
    l32 <= 32'h00000000;
    l33 <= 32'h00000000;
    l34 <= 32'h00000000;
    l41 <= 32'h00000000;
    l42 <= 32'h00000000;
    l43 <= 32'h00000000;
    l44 <= 32'h00000000;

    @(posedge clk)
    instr <= 8'd8;

    waitAndDisplay();

    instr <= 8'd1;

    l11 <= b11;
    l12 <= b21;
    l13 <= b13;
    l14 <= b14;
    l21 <= b12;
    l22 <= b22;
    l23 <= b23;
    l24 <= b23;
    l31 <= b31;
    l32 <= b32;
    l33 <= b33;
    l34 <= b33;
    l41 <= b41;
    l42 <= b42;
    l43 <= b43;
    l44 <= b44;

    @(posedge clk)

    instr <= 8'd2;
    r11 <= 32'hbf20dcca;
    r12 <= 32'h00000000;
    r13 <= 32'h00000000;
    r14 <= 32'h00000000;
    r21 <= 32'hbf8c8ef8;
    r22 <= 32'h00000000;
    r23 <= 32'h00000000;
    r24 <= 32'h00000000;
    r31 <= 32'hbe530ee8;
    r32 <= 32'h00000000;
    r33 <= 32'h00000000;
    r34 <= 32'h00000000;
    r41 <= 32'h3d67d8d0;
    r42 <= 32'h00000000;
    r43 <= 32'h00000000;
    r44 <= 32'h00000000;

    @(posedge clk);
    instr <= 8'd3;

    a11 <= 32'h3f7f823a;
    a12 <= 32'h00000000;
    a13 <= 32'h00000000;
    a14 <= 32'h00000000;
    a21 <= 32'h00000000;
    a22 <= 32'h00000000;
    a23 <= 32'h00000000;
    a24 <= 32'h00000000;
    a31 <= 32'h00000000;
    a32 <= 32'h00000000;
    a33 <= 32'h00000000;
    a34 <= 32'h00000000;
    a41 <= 32'h00000000;
    a42 <= 32'h00000000;
    a43 <= 32'h00000000;
    a44 <= 32'h00000000;

    @(posedge clk)
    instr <= 8'd6;

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
    @(posedge clk)
    $display("lef\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _lvg.dlef.r11, 
        _lvg.dlef.r21, 
        _lvg.dlef.r31, 
        _lvg.dlef.r41, 
        _lvg.dlef.r12, 
        _lvg.dlef.r22, 
        _lvg.dlef.r32, 
        _lvg.dlef.r42, 
        _lvg.dlef.r13, 
        _lvg.dlef.r23, 
        _lvg.dlef.r33,
        _lvg.dlef.r43,
        _lvg.dlef.r14,
        _lvg.dlef.r24,
        _lvg.dlef.r34,
        _lvg.dlef.r44
    );
    $display("rig\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _lvg.drig.r11, 
        _lvg.drig.r12, 
        _lvg.drig.r13, 
        _lvg.drig.r14, 
        _lvg.drig.r21, 
        _lvg.drig.r22, 
        _lvg.drig.r23, 
        _lvg.drig.r24, 
        _lvg.drig.r31, 
        _lvg.drig.r32, 
        _lvg.drig.r33,
        _lvg.drig.r34,
        _lvg.drig.r41,
        _lvg.drig.r42,
        _lvg.drig.r43,
        _lvg.drig.r44
    );
    $display("\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _lvg.b11, _lvg.b12, _lvg.b13, _lvg.b14,
        _lvg.b21, _lvg.b22, _lvg.b23, _lvg.b24,
        _lvg.b31, _lvg.b32, _lvg.b33, _lvg.b34,
        _lvg.b41, _lvg.b42, _lvg.b43, _lvg.b44
    );
end
endtask

endmodule
