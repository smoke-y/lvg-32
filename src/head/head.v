`include "src/head/memory.v"
`include "src/head/instr_mem.v"
`include "src/lvg/lvg.v"

module head(
    input wire clk, rst
);

reg[7:0] instrAddr = 8'b0;
wire[15:0] instr1;
reg[7:0] instr2;
instr_mem instrMem(clk, instrAddr, instr1);

wire[31:0] i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44;
wire[31:0] o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44;
reg readWeight, writeWeight;
reg [7:0] weightAddr;
memory weightMem(
    i11, i21, i13, i14, i12, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    //i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44,
    readWeight, writeWeight, clk,
    weightAddr,
    o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44
);

//reg[31:0] a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44;
lvg _lvg(
    o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44,
    o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44,
    o11, o12, o13, o14, o21, o22, o23, o24, o31, o32, o33, o34, o41, o42, o43, o44,
    //a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
    instr2,
    clk, rst,
    i11, i12, i13, i14, i21, i22, i23, i24, i31, i32, i33, i34, i41, i42, i43, i44
);

reg count;
always @(posedge clk) begin
    readWeight <= 1'b0;
    writeWeight <= 1'b0;
    if(rst) begin
        count <= 1'b0;
        instrAddr <= 8'b0;
        instr2 <= 8'd0;
    end else begin
        case(count)
            1'b0: begin
                case(instr2)
                    8'd3: begin
                        readWeight <= 1'b1;
                        move();
                    end
                    8'd5, 8'd6: begin
                        if(_lvg.sysCount == 5'd13) move();
                    end
                8'd7, 8'd8: begin
                    if(_lvg.sysCount == 5'd14) move();
                end
            default: move();
        endcase
    end
    1'b1: begin
        count <= 1'b0;
        instr2 <= instr1[7:0];
        weightAddr <= instr1[15:8];
        case(instr1[7:0])
            8'd1, 8'd2: readWeight <= 1'b1;
            8'd4: writeWeight <= 1'b1;
        endcase
    end
endcase
end
end

task move(); begin
    count <= 1'd1;
    instrAddr <= instrAddr + 1;
end
endtask

endmodule
