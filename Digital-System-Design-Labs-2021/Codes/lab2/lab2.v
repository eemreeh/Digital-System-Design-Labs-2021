module lab2
(
	input wire nReset, Clock, Enable,
	output wire [3:0] Co1, Co10, Co100
);	
	wire temp1, temp2, temp3;
	
	
	counter c1(.nRst(nReset), .Clk(Clock), .CntEn(Enable), .Cout(Co1), .NextEn(temp1));
	counter c2(.nRst(nReset), .Clk(Clock), .CntEn(temp1), .Cout(Co10), .NextEn(temp2));
	counter c3(.nRst(nReset), .Clk(Clock), .CntEn(temp2), .Cout(Co100), .NextEn(temp3));
	
	
endmodule 