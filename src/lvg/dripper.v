module dripper(
    input wire [31:0] i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    input wire [5:0] count,
    input wire load, clk,
    output reg [31:0] p1, p2, p3, p4
);

reg [31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44;

always @(posedge clk) begin
    if(load) begin
        r11 <= i11;
        r12 <= i12;
        r13 <= i13;
        r14 <= i14;
        r21 <= i21;
        r22 <= i22;
        r23 <= i23;
        r24 <= i24;
        r31 <= i31;
        r32 <= i32;
        r33 <= i33;
        r34 <= i34;
        r41 <= i41;
        r42 <= i42;
        r43 <= i43;
        r44 <= i44;
    end else begin
        case(count)
            5'd1: begin
                p1 <= r41;
                p2 <= 32'h0;
                p3 <= 32'h0;
                p4 <= 32'h0;
            end
            5'd2: begin
                p1 <= r31;
                p2 <= r42;
                p3 <= 32'h0;
                p4 <= 32'h0;
            end
            5'd3: begin
                p1 <= r21;
                p2 <= r32;
                p3 <= r43;
                p4 <= 32'h0;
            end
            5'd4: begin
                p1 <= r11;
                p2 <= r22;
                p3 <= r33;
                p4 <= r44;
            end
            5'd5: begin
                p1 <= 32'h0;
                p2 <= r12;
                p3 <= r23;
                p4 <= r34;
            end
            5'd6: begin
                p1 <= 32'h0;
                p2 <= 32'h0;
                p3 <= r13;
                p4 <= r24;
            end
            5'd7: begin
                p1 <= 32'h0;
                p2 <= 32'h0;
                p3 <= 32'h0;
                p4 <= r14;
            end
            default: begin
                p1 <= 32'h0;
                p2 <= 32'h0;
                p3 <= 32'h0;
                p4 <= 32'h0;
            end
        endcase
    end
end

endmodule
