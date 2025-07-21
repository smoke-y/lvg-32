`include "src/head/head.v"

module tb_head();

reg rst = 1'b1;
reg clk = 1'b1;
always #5 clk = ~clk;

head _head(clk, rst);

initial begin
    rst <= 1'b1;

    @(posedge clk);

    $readmemh("data/irisMem.hex", _head.weightMem.mem, 0, 79);

    _head.instrMem.mem[0] <= 16'h0001;
    _head.instrMem.mem[1] <= 16'h1002;
    _head.instrMem.mem[2] <= 16'h2003;
    _head.instrMem.mem[3] <= 16'h0008;
    _head.instrMem.mem[4] <= 16'h0004;
    _head.instrMem.mem[5] <= 16'h0001;
    _head.instrMem.mem[6] <= 16'h3002;
    _head.instrMem.mem[7] <= 16'h4003;
    _head.instrMem.mem[8] <= 16'h0006;
    @(posedge clk);
    rst <= 1'b0;
    repeat (23*10) @(posedge clk);
    dump();

    $finish;
end

task dump(); begin
    $display("lef\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _head._lvg.dlef.r11, 
        _head._lvg.dlef.r21, 
        _head._lvg.dlef.r31, 
        _head._lvg.dlef.r41, 
        _head._lvg.dlef.r12, 
        _head._lvg.dlef.r22, 
        _head._lvg.dlef.r32, 
        _head._lvg.dlef.r42, 
        _head._lvg.dlef.r13, 
        _head._lvg.dlef.r23, 
        _head._lvg.dlef.r33,
        _head._lvg.dlef.r43,
        _head._lvg.dlef.r14,
        _head._lvg.dlef.r24,
        _head._lvg.dlef.r34,
        _head._lvg.dlef.r44
    );
    $display("rig\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _head._lvg.drig.r11, 
        _head._lvg.drig.r12, 
        _head._lvg.drig.r13, 
        _head._lvg.drig.r14, 
        _head._lvg.drig.r21, 
        _head._lvg.drig.r22, 
        _head._lvg.drig.r23, 
        _head._lvg.drig.r24, 
        _head._lvg.drig.r31, 
        _head._lvg.drig.r32, 
        _head._lvg.drig.r33,
        _head._lvg.drig.r34,
        _head._lvg.drig.r41,
        _head._lvg.drig.r42,
        _head._lvg.drig.r43,
        _head._lvg.drig.r44
    );
    $display("i\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
        _head.i11, 
        _head.i12, 
        _head.i13, 
        _head.i14, 
        _head.i21, 
        _head.i22, 
        _head.i23, 
        _head.i24, 
        _head.i31, 
        _head.i32, 
        _head.i33,
        _head.i34,
        _head.i41,
        _head.i42,
        _head.i43,
        _head.i44
    );
    $display("mem\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
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
