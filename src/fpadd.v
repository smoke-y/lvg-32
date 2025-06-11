module fpadd(a, b, s);

output reg [31:0] s;
input [31:0] a, b;

assign asign = a[31];
assign bsign = b[31];
reg ssign;
reg [7:0]  aexp; 
reg [7:0]  bexp;
reg [23:0] amant;
reg [23:0] bmant;
reg [24:0] smant;
reg [7:0]  sexp;

integer i;
reg d;
always @* begin
	//extracting exponent and mantissa
	aexp = a[30:23];
	bexp = b[30:23];
	amant[22:0] = a[22:0];
	bmant[22:0] = b[22:0];
	sexp = aexp;

	//apending implicit 1
	amant[23] = 1;
	bmant[23] = 1;
	//aligning exponents
	if (aexp < bexp) begin
		amant = amant >> (bexp-aexp);
		sexp = bexp;
	end
	else if (bexp < aexp) begin
		bmant = bmant >> (aexp-bexp);
		sexp = aexp;
	end
	
	//check if zero and sign to decide add/sub
    if(amant[22:0] == 0 && bmant[22:0] == 0) begin
        ssign = 0;
        smant = 0;
    end
	else if(asign == bsign) begin
		ssign = asign;
		smant = amant + bmant;
	end
	else if(amant > bmant) begin
		ssign = asign;
		smant = amant - bmant;
	end
	else if(bmant > amant) begin
		ssign = bsign;
		smant = bmant - amant;
	end
	else begin
		//same number but different signs. Therefore, the answer is
		smant = 0;
		ssign = 0;
		sexp  = 0;
	end
	//normalizing
	if(smant[24] == 1) begin
		/*
			the part before decimal can be: 1, 10, 11
			if 10,11 then the answer is not normalized.
			we increment the exponent by 1, and shift left,
			considering the msb 1 in 10,11 as implicit 1.
		*/
		sexp = sexp + 1;
	end else if(smant != 0) begin
		//remove leading 0
        for(i=23; smant[i] == 0; i=i-1);
		//shift till we get 1 at msb(shifting the decimal: step 1)
		smant = smant << (23 - i);
		//reduce exponent by the same amount(shifting the decimal: step 2)
		sexp = sexp - (23 - i);
		//drop the implicit 1
		smant = smant << 1;
	end
	s = {ssign, sexp, smant[23:1]};  //consider only 23 bits
end;

endmodule
