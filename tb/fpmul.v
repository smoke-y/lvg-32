`include "src/fpmul.v"

module tb_fpmul();
    reg [31:0] a, b;
    wire [31:0] result;
    reg [31:0] exp;
    
    fpmul uut (a,b,result);
    
    initial begin
        
        a = 32'h3f115b57;
        b = 32'h3fab851f;
        exp = 32'h3f42c732;
        #10;
        stat();

        a = 32'h00000000;
        b = 32'h3fab851f;
        exp = 32'h00000000;
        #10;
        stat();

        a = 32'h3aa137f4;
        b = 32'h3c4985f0;
        exp = 32'h377dd28f;
        #10;
        stat();

        a = 32'h00000000;
        b = 32'h00000000;
        exp = 32'h00000000;
        #10;
        stat();

        a = 32'h3f800000;
        b = 32'h3f800000;
        exp = 32'h3f800000;
        #10;
        stat();
        $finish;
    end

    task stat;
        begin
            if(result == exp) $display("[+] PASS");
            else $display("[-] FAILED");
            $display("\t%h * %h = %h[%h]", a, b, exp, result);
    end
    endtask

endmodule
