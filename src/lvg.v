`include "src/dispatcher.v"
`include "src/activation/relu.v"
`include "src/aggregator.v"
`include "src/sysarr.v"
`include "src/dripper.v"

module lvg(
    input wire[31:0] m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44,
    input wire[31:0] n11, n12, n13, n14, n21, n22, n23, n24, n31, n32, n33, n34, n41, n42, n43, n44,
    input wire clk, rst, load
);

reg[31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44;
reg shouldAdd = 1'b0;
wire[31:0] l1, l2, l3, l4;
wire[31:0] u1, u2, u3, u4;
wire[31:0] d1, d2, d3, d4;
wire[31:0] p1, p2, p3, p4;
wire[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;
wire[31:0] t11, t12, t13, t14, t21, t22, t23, t24, t31, t32, t33, t34, t41, t42, t43, t44;
reg[5:0] count;

dripper dup(
    m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44,
    count, load, clk,
    u1, u2, u3, u4
);
dripper dlef(
    n11, n12, n13, n14, n21, n22, n23, n24, n31, n32, n33, n34, n41, n42, n43, n44,
    count, load, clk,
    l1, l2, l3, l4
);
sysarr sarr(
    l1, l2, l3, l4, u1, u2, u3, u4,
    clk, rst,
    t11, t12, t13, t14, t21, t22, t23, t24, t31, t32, t33, t34, t41, t42, t43, t44
);
dispatcher dis(
    t11, t12, t13, t14, t21, t22, t23, t24, t31, t32, t33, t34, t41, t42, t43, t44,
    a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    count, clk, shouldAdd,
    d1, d2, d3, d4
);
relu rel1(d1, clk, p1);
relu rel2(d2, clk, p2);
relu rel3(d3, clk, p3);
relu rel4(d4, clk, p4);
aggregator agg(
    p1, p2, p3, p4,
    count, clk,
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44
);

always @(posedge clk) begin
    if(rst) begin
        count <= 5'd0;
    end else begin
        count <= count + 1;
    end
end

endmodule
