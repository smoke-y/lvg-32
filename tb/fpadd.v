`include "src/fpadd.v"

module tb_fpadd();
    reg [31:0] a, b;
    wire [31:0] result;
    reg [31:0] exp;
    
    fpadd uut (a,b,result);
    
    initial begin
        
        a = 32'h3f115b57;
        b = 32'h3fab851f;
        exp = 32'h3ff432ca;
        #10;
        stat(a,b,exp);

        a = 32'h00000000;
        b = 32'h3fab851f;
        exp = 32'h3fab851f;
        #10;
        stat(a,b,exp);

        a = 32'h3aa137f4;
        b = 32'h3c4985f0;
        exp = 32'h3c5dacef;
        #10;
        stat(a,b,exp);

        a = 32'h00000000;
        b = 32'h00000000;
        exp = 32'h00000000;
        #10;
        stat(a,b,exp);

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
