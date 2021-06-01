module STransmitter
(
	input wire Clk, Send,
	input wire [7:0] PDin,
	output wire SCout, SDout
);
reg [7:0] SR;


always @(posedge Clk)
begin
	if (Send == 1'b1) begin
		SR[7:0] <= PDin[7:0];
	end
	else begin
		SR[7:1] <= SR[6:0];
		SR[0] <= 1'b0;
	end
end
assign SDout = (SR[7] | Send);
assign SCout = Clk;

endmodule 