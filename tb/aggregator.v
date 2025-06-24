`include "src/aggregator.v"

module tb_aggregator();

wire [31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;
reg [31:0] d1, d2, d3, d4;
reg [5:0] count;
reg clk = 1'b1;
always #5 clk = ~clk;

aggregator agg(
    d1, d2, d3, d4,
    count, clk,
    r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44
);

initial begin
    count <= 5'd0;

    @(posedge clk);
    tick();
    d1 <= 32'h0;

    @(posedge clk);
    tick();
    d1 <= 32'h1;
    d2 <= 32'h4;

    @(posedge clk);
    tick();
    d1 <= 32'h2;
    d2 <= 32'h5;
    d3 <= 32'h8;

    @(posedge clk);
    tick();
    d1 <= 32'h3;
    d2 <= 32'h6;
    d3 <= 32'h9;
    d4 <= 32'hc;

    @(posedge clk);
    tick();
    d1 <= 32'h7;
    d2 <= 32'ha;
    d3 <= 32'hd;

    @(posedge clk);
    tick();
    d1 <= 32'hb;
    d2 <= 32'he;

    @(posedge clk);
    tick();
    d1 <= 32'hf;

    @(posedge clk);
    tick();

    @(posedge clk);
    tick();

    $finish;
end

task tick(); begin
    $display("count: %d\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        count,
        r11, r12, r13, r14,
        r21, r22, r23, r24,
        r31, r32, r33, r34,
        r41, r42, r43, r44
    );
    count <= count + 1;
end
endtask

endmodule
