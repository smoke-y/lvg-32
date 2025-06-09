module mulf(
    output reg [31:0] s,
    input [31:0] a, 
    input [31:0] b
);

    wire ssign = a[31] ^ b[31];
    
    reg [7:0] aexp, bexp;
    reg [8:0] exp_sum; // Need extra bit for carry
    
    reg [23:0] amant, bmant; // 24 bits (1 hidden + 23 fraction)
    reg [47:0] mant_product;
    
    reg [7:0] final_exp;
    reg [22:0] final_frac;
    
    always @(*) begin
        if (a[30:0] == 31'b0 || b[30:0] == 31'b0) begin
            s = {ssign, 31'b0};
        end
        else begin

            aexp = a[30:23];
            bexp = b[30:23];
            amant = {1'b1, a[22:0]}; // Add implicit leading 1
            bmant = {1'b1, b[22:0]}; // Add implicit leading 1
            // Calculate exponent (Ea + Eb - 127)
            exp_sum = {1'b0, aexp} + {1'b0, bexp} - 9'd127;

            // Multiply mantissas (24x24 = 48 bits)
            mant_product = amant * bmant;

            // Normalize result
            if (mant_product[47]) begin
                // Case 1: Product overflowed (1x.xxxx or 11.xxxx)
                final_exp = exp_sum + 1;
                final_frac = mant_product[46:24]; // Take bits [46:24]
            end
            else begin
                // Case 2: Product is 01.xxxx (normalized)
                final_exp = exp_sum;
                final_frac = mant_product[45:23]; // Take bits [45:23]
            end

            // Handle exponent overflow (saturate to infinity)
            if (exp_sum[8] || (&final_exp)) begin
                final_exp = 8'hFF;
                final_frac = 23'h0;
            end

            s = {ssign, final_exp, final_frac};
        end
    end
endmodule
