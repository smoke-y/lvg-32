`include "src/sysblock.v"

module sysarr(
    input wire [31:0] l11, l21, l31, l41,
    u11, u12, u13, u14,
    input wire clk, rst,
    output wire[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44
);

wire [31:0] u21, u31, u41, u22, u32, u42, u23, u33, u43, u24, u34, u44;
wire [31:0] l12, l13, l14, l22, l23, l24, l32, l33, l34, l42, l43, l44;
wire [31:0] _l1, _l2, _l3, _l4;
wire [31:0] _u1, _u2, _u3, _u4;

sysblock p11(u11, l11, clk, rst, u21, l12, r11);
sysblock p12(u12, l12, clk, rst, u22, l13, r12);
sysblock p13(u13, l13, clk, rst, u23, l14, r13);
sysblock p14(u14, l14, clk, rst, u24, _l1, r14);

sysblock p21(u21, l21, clk, rst, u31, l22, r21);
sysblock p22(u22, l22, clk, rst, u32, l23, r22);
sysblock p23(u23, l23, clk, rst, u33, l24, r23);
sysblock p24(u24, l24, clk, rst, u34, _l2, r24);

sysblock p31(u31, l31, clk, rst, u41, l32, r31);
sysblock p32(u32, l32, clk, rst, u42, l33, r32);
sysblock p33(u33, l33, clk, rst, u43, l34, r33);
sysblock p34(u34, l34, clk, rst, u44, _l3, r34);

sysblock p41(u41, l41, clk, rst, _u1, l42, r41);
sysblock p42(u42, l42, clk, rst, _u2, l43, r42);
sysblock p43(u43, l43, clk, rst, _u3, l44, r43);
sysblock p44(u44, l44, clk, rst, _u4, _l4, r44);

endmodule;
