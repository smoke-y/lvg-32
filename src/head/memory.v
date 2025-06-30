module memory(
    input wire[31:0] i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    input wire read, write, clk,
    input wire[7:0] addr,
    output reg[31:0] o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44
);

reg[31:0] mem[100:0];

always @(posedge clk) begin
    if(read) begin
        o11 <= mem[addr];
        o12 <= mem[addr+1];
        o13 <= mem[addr+2];
        o14 <= mem[addr+3];
        o21 <= mem[addr+4];
        o22 <= mem[addr+5];
        o23 <= mem[addr+6];
        o24 <= mem[addr+7];
        o31 <= mem[addr+8];
        o32 <= mem[addr+9];
        o33 <= mem[addr+10];
        o34 <= mem[addr+11];
        o41 <= mem[addr+12];
        o42 <= mem[addr+13];
        o43 <= mem[addr+14];
        o44 <= mem[addr+15];
    end else if(write) begin
        mem[addr] <= i11;
        mem[addr+1]  <= i12;
        mem[addr+2]  <= i13;
        mem[addr+3]  <= i14;
        mem[addr+4]  <= i21;
        mem[addr+5]  <= i22;
        mem[addr+6]  <= i23;
        mem[addr+7]  <= i24;
        mem[addr+8]  <= i31;
        mem[addr+9]  <= i32;
        mem[addr+10] <= i33;
        mem[addr+11] <= i34;
        mem[addr+12] <= i41;
        mem[addr+13] <= i42;
        mem[addr+14] <= i43;
        mem[addr+15] <= i44;
    end
end

endmodule
