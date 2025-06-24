module aggregator(
    input wire[31:0] d1, d2, d3, d4,
    input wire[5:0] count,
    input wire clk,
    output reg[31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44
);

always @(posedge clk) begin
    case(count)
        5'd1: begin
            r11 <= d1;
        end
        5'd2: begin
            r12 <= d1;
            r21 <= d2;
        end
        5'd3: begin
            r13 <= d1;
            r22 <= d2;
            r31 <= d3;
        end
        5'd4: begin
            r14 <= d1;
            r23 <= d2;
            r32 <= d3;
            r41 <= d4;
        end
        5'd5: begin
            r24 <= d1;
            r33 <= d2;
            r42 <= d3;
        end
        5'd6: begin
            r34 <= d1;
            r43 <= d2;
        end
        5'd7: begin
            r44 <= d1;
        end
    endcase
end

endmodule
