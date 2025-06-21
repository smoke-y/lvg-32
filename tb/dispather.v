`include "src/dispatcher.v"

module tb_dispatcher();

reg [31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;
reg [31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44;
reg [4:0] count;
reg shouldAdd;
wire [31:0] d1, d2, d3, d4;
reg clk = 1'b1;
always #5 clk = ~clk;

dispatcher dis(
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    count, clk, shouldAdd,
    d1, d2, d3, d4);

initial begin
    count <= 0;
    shouldAdd <= 0;

    @(posedge clk);
    count <= 5;
    r11 <= 32'h00000000;
    r12 <= 32'h00000001;
    r13 <= 32'h00000002;
    r14 <= 32'h00000003;
    r21 <= 32'h00000004;
    r22 <= 32'h00000005;
    r23 <= 32'h00000006;
    r24 <= 32'h00000007;
    r31 <= 32'h00000008;
    r32 <= 32'h00000009;
    r33 <= 32'h0000000A;
    r34 <= 32'h0000000B;
    r41 <= 32'h0000000C;
    r42 <= 32'h0000000D;
    r43 <= 32'h0000000E;
    r44 <= 32'h0000000F;

    @(posedge clk);

    print_rmat();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();

    count <= 5;
    shouldAdd <= 1;

    r11 <= 32'h00000000;
    r12 <= 32'h3f800000;
    r13 <= 32'h40000000;
    r14 <= 32'h40400000;
    r21 <= 32'h40800000;
    r22 <= 32'h40a00000;
    r23 <= 32'h40c00000;
    r24 <= 32'h40e00000;
    r31 <= 32'h41000000;
    r32 <= 32'h41100000;
    r33 <= 32'h41200000;
    r34 <= 32'h41300000;
    r41 <= 32'h41400000;
    r42 <= 32'h41500000;
    r43 <= 32'h41600000;
    r44 <= 32'h41700000;

    a11 <= 32'h00000000;
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

    @(posedge clk);

    print_rmat();
    $display("");
    print_amat();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();
    tick();

    $finish;
end

task print_rmat(); begin
    $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        r11, r12, r13, r14,
        r21, r22, r23, r24,
        r31, r32, r33, r34,
        r41, r42, r43, r44
    );
end
endtask

task print_amat(); begin
    $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        a11, a12, a13, a14,
        a21, a22, a23, a24,
        a31, a32, a33, a34,
        a41, a42, a43, a44
    );
end
endtask

task tick(); begin
    @(posedge clk);
    $display("count: %d\nd1: %h\td2: %h\t d3: %h\td4: %h",
        count,
        d1, d2, d3, d4
    );
    count <= count + 1;
end
endtask

endmodule
