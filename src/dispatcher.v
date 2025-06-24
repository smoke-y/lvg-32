`ifndef FPADD 
`define FPADD
`include "src/fpadd.v"
`endif

module dispatcher(
    input wire [31:0] r11, r12, r13, r14, r21, r22, r23, r24, r31, r32, r33, r34, r41, r42, r43, r44,
    input wire [31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    input wire [5:0] count,
    input wire clk, shouldAdd,
    output reg [31:0] d1, d2, d3, d4
);

wire [31:0] add_a1, add_a2, add_a3, add_a4;
wire [31:0] add_b1, add_b2, add_b3, add_b4;
wire [31:0] add_out1, add_out2, add_out3, add_out4;

fpadd adder1(add_a1, add_b1, add_out1);
fpadd adder2(add_a2, add_b2, add_out2);
fpadd adder3(add_a3, add_b3, add_out3);
fpadd adder4(add_a4, add_b4, add_out4);

assign add_a1 = (count == 5'd1)? r11 :
                (count == 5'd2)? r12 :
                (count == 5'd3)? r13 :
                (count == 5'd4)? r14 :
                (count == 5'd5)? r24 :
                (count == 5'd6)? r34 :
                (count == 5'd7)? r44 : 32'b0;
assign add_b1 = (count == 5'd1)? a11 :
                (count == 5'd2)? a12 :
                (count == 5'd3)? a13 :
                (count == 5'd4)? a14 :
                (count == 5'd5)? a24 :
                (count == 5'd6)? a34 :
                (count == 5'd7)? a44 : 32'b0;

assign add_a2 = (count == 5'd2)? r21 :
                (count == 5'd3)? r22 :
                (count == 5'd4)? r23 :
                (count == 5'd5)? r33 :
                (count == 5'd6)? r43 : 32'b0;
assign add_b2 = (count == 5'd2)? a21 :
                (count == 5'd3)? a22 :
                (count == 5'd4)? a23 :
                (count == 5'd5)? a33 :
                (count == 5'd6)? a43 : 32'b0;

assign add_a3 = (count == 5'd3)? r31 :
                (count == 5'd4)? r32 :
                (count == 5'd5)? r42 : 32'b0;
assign add_b3 = (count == 5'd3)? a31 :
                (count == 5'd4)? a32 :
                (count == 5'd5)? a42 : 32'b0;

assign add_a4 = (count == 5'd4)? r41 : 32'b0;
assign add_b4 = (count == 5'd4)? a41 : 32'b0;

always @(posedge clk) begin
    if(shouldAdd) begin
        case(count)
            5'd1: begin
                d1 <= add_out1;
            end
            5'd2: begin
                d1 <= add_out1;
                d2 <= add_out2;
            end
            5'd3: begin
                d1 <= add_out1;
                d2 <= add_out2;
                d3 <= add_out3;
            end
            5'd4: begin
                d1 <= add_out1;
                d2 <= add_out2;
                d3 <= add_out3;
                d4 <= add_out4;
            end
            5'd5: begin
                d1 <= add_out1;
                d2 <= add_out2;
                d3 <= add_out3;
            end
            5'd6: begin
                d1 <= add_out1;
                d2 <= add_out2;
            end
            5'd7: begin
                d1 <= add_out1;
            end
        endcase
    end else begin
        case(count)
            5'd1: begin
                d1 <= r11;
            end
            5'd2: begin
                d1 <= r12;
                d2 <= r21;
            end
            5'd3: begin
                d1 <= r13;
                d2 <= r22;
                d3 <= r31;
            end
            5'd4: begin
                d1 <= r14;
                d2 <= r23;
                d3 <= r32;
                d4 <= r41;
            end
            5'd5: begin
                d1 <= r24;
                d2 <= r33;
                d3 <= r42;
            end
            5'd6: begin
                d1 <= r34;
                d2 <= r43;
            end
            5'd7: begin
                d1 <= r44;
            end
        endcase
    end
end

endmodule
