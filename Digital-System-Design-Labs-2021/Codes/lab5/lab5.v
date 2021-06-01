module lab5
(
	input wire Clk, Send,
	input wire [7:0] PDin,
	output wire [7:0] PDout, 
	output wire PDready, SoClk, SDout, ParErr
);

//waveform lab5
//STransmitter_V1 STrv1(.Clk(Clk), .Send(Send), .PDin(PDin), .SCout(SoClk), .SDout(SDout));
//SReceiver_V1 SRcv1_1(.SCin(SoClk), .SDin(SDout), .PDout(PDout), .PDready(PDready), .ParErr(ParErr));


//waveform lab5part2
STransmitter_V2 STrv2(.Clk(Clk), .Send(Send), .PDin(PDin), .SCout(SoClk), .SDout(SDout));
SReceiver_V1 SRcv1_1(.SCin(SoClk), .SDin(SDout), .PDout(PDout), .PDready(PDready), .ParErr(ParErr));



endmodule 