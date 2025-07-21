`include "src/head/head.v"

module tb_head();

reg rst = 1'b1;
reg clk = 1'b1;
always #5 clk = ~clk;

head _head(clk, rst);


initial begin
    rst <= 1'b1;
    
    _head.instrMem.mem[0] <= 16'h0001;
    _head.instrMem.mem[1] <= 16'h0002;
    _head.instrMem.mem[2] <= 16'h0003;
    _head.instrMem.mem[3] <= 16'h0008;
    _head.instrMem.mem[4] <= 16'h0204;

    _head.weightMem.mem[0] <= 32'h3f800000;
    _head.weightMem.mem[1] <= 32'h3f800000;
    _head.weightMem.mem[2] <= 32'h3f800000;
    _head.weightMem.mem[3] <= 32'h3f800000;
    _head.weightMem.mem[4] <= 32'h3f800000;
    _head.weightMem.mem[5] <= 32'h3f800000;
    _head.weightMem.mem[6] <= 32'h3f800000;
    _head.weightMem.mem[7] <= 32'h3f800000;
    _head.weightMem.mem[8] <= 32'h3f800000;
    _head.weightMem.mem[9] <= 32'h3f800000;
    _head.weightMem.mem[10] <= 32'h3f800000;
    _head.weightMem.mem[11] <= 32'h3f800000;
    _head.weightMem.mem[12] <= 32'h3f800000;
    _head.weightMem.mem[13] <= 32'h3f800000;
    _head.weightMem.mem[14] <= 32'h3f800000;
    _head.weightMem.mem[15] <= 32'h3f800000;

    @(posedge clk);
    rst <= 1'b0;
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
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    dump();

    $finish;
end

task dump(); begin
    $display("\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _head.weightMem.mem[0], 
        _head.weightMem.mem[1], 
        _head.weightMem.mem[2], 
        _head.weightMem.mem[3], 
        _head.weightMem.mem[4], 
        _head.weightMem.mem[5], 
        _head.weightMem.mem[6], 
        _head.weightMem.mem[7], 
        _head.weightMem.mem[8], 
        _head.weightMem.mem[9], 
        _head.weightMem.mem[10],
        _head.weightMem.mem[11],
        _head.weightMem.mem[12],
        _head.weightMem.mem[13],
        _head.weightMem.mem[14],
        _head.weightMem.mem[15]
    );
end
endtask

endmodule
