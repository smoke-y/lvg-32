`include "src/lvg/dispatcher.v"
`include "src/lvg/activation/relu.v"
`include "src/lvg/aggregator.v"
`include "src/lvg/sysarr.v"
`include "src/lvg/dripper.v"

module lvg(
    input wire[31:0] l11, l12, l13, l14, l21, l22, l23, l24, l31, l32, l33, l34, l41, l42, l43, l44,
    input wire[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    input wire[31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    input wire[15:0] instr,
    input wire clk, rst
);

wire[31:0] l1, l2, l3, l4;
wire[31:0] r1, r2, r3, r4;
wire[31:0] d1, d2, d3, d4;
wire[31:0] g1, g2, g3, g4;
wire[31:0] s11, s12, s13, s14, s21, s22, s23, s24, s31, s32, s33, s34, s41, s42, s43, s44;
wire[31:0] b11, b12, b13, b14, b21, b22, b23, b24, b31, b32, b33, b34, b41, b42, b43, b44;
reg[5:0] sysCount, disCount, aggCount, aggActCount;
reg shouldAdd, shouldAct, shouldLoadL, shouldLoadR, srst;
reg [7:0] execInstr, execAddr;

dripper dlef(
    l11, l21, l31, l41, l12, l22, l32, l42, l13, l23, l33, l43, l14, l24, l24, l44,
    sysCount, shouldLoadL, clk,
    l1, l2, l3, l4
);
dripper drig(
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    sysCount, shouldLoadR, clk,
    r1, r2, r3, r4
);
sysarr sarr(
    l1, l2, l3, l4, r1, r2, r3, r4,
    clk, srst,
    s11, s12, s13, s14, s21, s22, s23, s24, s31, s32, s33, s34, s41, s42, s43, s44
);
dispatcher dis(
    s11, s12, s13, s14, s21, s22, s23, s24, s31, s32, s33, s34, s41, s42, s43, s44,
    a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    disCount, clk, shouldAdd,
    d1, d2, d3, d4
);
relu rel1(d1, clk, shouldAct, g1);
relu rel2(d2, clk, shouldAct, g2);
relu rel3(d3, clk, shouldAct, g3);
relu rel4(d4, clk, shouldAct, g4);
aggregator agg(
    (aggActCount ? g1 : d1), 
    (aggActCount ? g2 : d2),
    (aggActCount ? g3 : d3),
    (aggActCount ? g4 : d4),
    (aggActCount ? aggActCount : aggCount),
    clk,
    b11, b12, b13, b14, b21, b22, b23, b24, b31, b32, b33, b34, b41, b42, b43, b44
);

always @(posedge clk) begin
    shouldAct <= 1'b0;
    shouldLoadL <= 1'b0;
    shouldLoadR <= 1'b0;
    if(rst) begin
        sysCount <= 5'd0;
        disCount <= 5'd0;
        aggCount <= 5'd0;
        aggActCount <= 5'd0;
        execInstr <= 8'b0;
        srst <= 1'b0;
    end else begin
        execInstr <= instr[7:0];
        execAddr <= instr[15:8];

        case(instr[7:0])
            8'd1: begin
                shouldLoadL <= 1'b1;
            end
            8'd2: begin
                shouldLoadR <= 1'b1;
            end
            8'd3: begin
                if(execInstr != 8'd3) begin
                    srst <= 1'b1;
                    sysCount <= 5'b1;
                end
            end
        endcase

        case(execInstr)
            8'd3: begin
                if(srst == 1'b1 && sysCount == 5'b1) begin
                    srst <= 1'b0;
                end
                sysCount <= sysCount + 1;
                if(sysCount == 5'd5) begin
                    disCount <= 1;
                end else if(sysCount > 5'd5) begin
                    disCount <= disCount + 1;
                    if(sysCount == 5'd6) begin
                        aggCount <= 1;
                    end else if(sysCount > 5'd6) begin
                        aggCount <= aggCount + 1;
                    end
                end
            end
        endcase
    end
end

endmodule
