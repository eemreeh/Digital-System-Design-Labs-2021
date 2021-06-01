module STransmitter_V3
(
	input wire Clk, Send,
	input wire [7:0] PDin,
	output wire SCout, SDout
);
reg [8:0] SR;
reg delayedSend;
reg clockedSend;

assign clockedSend = (Send && (SR == 8'b0))?(1'b1):(1'b0);

always @(posedge Clk)
begin
	delayedSend = clockedSend;

	if (clockedSend & ~delayedSend) begin
		SR[8:1] <= PDin[7:0];
		SR[0] <= ^PDin[7:0];
	end
	else begin
		SR[8:1] <= SR[7:0];
		SR[0] <= 1'b0;
	end
end

assign SDout = (SR[7] | (clockedSend & ~delayedSend));
assign SCout = Clk;

endmodule 