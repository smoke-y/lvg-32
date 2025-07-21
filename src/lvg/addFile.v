module addFile(
    input wire [31:0] i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    input wire load, rst, clk,
    output reg [31:0] o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44
);

always @(posedge clk) begin
    if(load) begin
        o11 <= i11;
        o12 <= i12;
        o13 <= i13;
        o14 <= i14;
        o21 <= i21;
        o22 <= i22;
        o23 <= i23;
        o24 <= i24;
        o31 <= i31;
        o32 <= i32;
        o33 <= i33;
        o34 <= i34;
        o41 <= i41;
        o42 <= i42;
        o43 <= i43;
        o44 <= i44;
    end else if(rst) begin
        o11 <= 32'h0;
        o12 <= 32'h0;
        o13 <= 32'h0;
        o14 <= 32'h0;
        o21 <= 32'h0;
        o22 <= 32'h0;
        o23 <= 32'h0;
        o24 <= 32'h0;
        o31 <= 32'h0;
        o32 <= 32'h0;
        o33 <= 32'h0;
        o34 <= 32'h0;
        o41 <= 32'h0;
        o42 <= 32'h0;
        o43 <= 32'h0;
        o44 <= 32'h0;
    end
end
endmodule
