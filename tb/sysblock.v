`include "src/sysblock.v"

module tb_sysblock();
    reg [31:0] up, left;
    wire [31:0] down, right, res;  // Changed to wires for module outputs
    reg [31:0] exp;

    reg rst = 1'b0;
    reg clk = 1'b1;
    always #5 clk = ~clk;

    sysblock uut(
        .up(up),
        .left(left),
        .clk(clk),
        .rst(rst),
        .down(down),
        .right(right),
        .res(res)
    );
    
    initial begin

        rst = 1'b1;
        @(posedge clk);
        rst <= 1'b0;
        up <= 32'h3d3f4880;
        left <= 32'h3d4779a7;
        @(posedge clk);
        up <= 32'h3f000000;
        left <= 32'hbe6f9db2;
        @(posedge clk);
        exp = 32'h3b150c41;
        stat();
        @(posedge clk);
        exp = 32'hbdeaf550;
        stat();
        rst = 1'b1;

        @(posedge clk);
        rst <= 1'b0;
        up <= 32'h00000000;
        left <= 32'h00000000;
        @(posedge clk);
        up <= 32'h00000000;
        left <= 32'h00000000;
        @(posedge clk);
        exp = 32'h00000000;
        stat();
        rst = 1'b1;

        @(posedge clk);
        rst <= 1'b0;
        up <= 32'h3f800000;
        left <= 32'h3f800000;
        @(posedge clk);
        up <= 32'h3f800000;
        left <= 32'h3f800000;
        @(posedge clk);
        exp = 32'h40000000;
        stat();
        $finish;
    end

    task stat;
        begin
            if(res == exp) $display("[+] PASS");
            else $display("[-] FAILED");
            $display("\t%h # %h = %h[%h]", up, left, exp, res);
        end
    endtask

endmodule
