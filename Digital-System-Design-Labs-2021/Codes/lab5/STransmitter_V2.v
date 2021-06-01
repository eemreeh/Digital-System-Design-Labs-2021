module STransmitter_V2
(
	input wire Clk, Send,
	input wire [7:0] PDin,
	output wire SCout, SDout
);
reg [8:0] SR;
reg delayedSend;
reg longSend;


always @(posedge Send)
begin
	longSend <= ~longSend; 
end

always @(posedge Clk)
begin
	delayedSend <= longSend;


	if (longSend ^ delayedSend) begin
		SR[8:1] <= PDin[7:0];
		SR[0] <= ^PDin[7:0];
	end
	else begin
		SR[8:1] <= SR[7:0];
		SR[0] <= 1'b0;
	end
end

assign SDout = (SR[8] | (longSend ^ delayedSend));
assign SCout = Clk;

endmodule 