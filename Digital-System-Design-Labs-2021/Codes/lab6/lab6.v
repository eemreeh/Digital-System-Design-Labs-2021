module lab6 (
	input wire Clk, nRst, 
	input wire [1:0] D1_2,
	output wire [2:0] outputState1,
	output wire [3:0] counter1
);


//FSM FSM1(.Clk(Clk), .nRst(nRst), .D1_2(D1_2), .outputState(outputState1), .counter(counter1));
FSM_Mod FSM2(.Clk(Clk), .nRst(nRst), .D1_2(D1_2), .outputState(outputState1), .counter(counter1));


endmodule 










