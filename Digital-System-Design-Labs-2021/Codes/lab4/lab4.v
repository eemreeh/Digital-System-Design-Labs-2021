module lab4
(
	input wire Clk, Send,
	input wire [7:0] PDin,
	output wire [7:0] PDout, 
	output wire PDready, SoClk, SDout
);


STransmitter STr(.Clk(Clk), .Send(Send), .PDin(PDin), .SCout(SoClk), .SDout(SDout));
SReceiver SRc(.SCin(SoClk), .SDin(SDout), .PDout(PDout), .PDready(PDready));

endmodule 