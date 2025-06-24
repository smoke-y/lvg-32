`include "src/lvg/dripper.v"

module tb_dripper();

reg[5:0] count = 5'b0;
reg clk = 1'b1;
reg [31:0] i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44;
reg load = 1'b0;
wire[31:0] p1, p2, p3, p4;

dripper drip(
    i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    count, load, clk,
    p1, p2, p3, p4
);

always #5 clk = ~clk;

initial begin
    @(posedge clk)
    load <= 1'b1;
    i11 <= 32'hffff;
    i12 <= 32'h0;
    i13 <= 32'h0;
    i14 <= 32'h0;
    i21 <= 32'h0;
    i22 <= 32'hffff;
    i23 <= 32'h0;
    i24 <= 32'h0;
    i31 <= 32'h0;
    i32 <= 32'h0;
    i33 <= 32'hffff;
    i34 <= 32'h0;
    i41 <= 32'h0;
    i42 <= 32'h0;
    i43 <= 32'h0;
    i44 <= 32'hffff;

    @(posedge clk)
    load <= 1'b0;
    count <= 5'd1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    count <= count + 1;
    stat();
    @(posedge clk);
    stat();
    $finish;
end

task stat(); begin
    $display("[%d] %h %h %h %h", count, p1, p2, p3, p4);
end
endtask
endmodule
