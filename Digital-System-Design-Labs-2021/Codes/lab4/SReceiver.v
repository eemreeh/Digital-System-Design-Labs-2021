module SReceiver
(
	input wire SCin, SDin,
	output wire [7:0] PDout,
	output reg PDready
);
reg [2:0] Cntr;
reg CntrStart;	
reg [7:0] SR;
	
always @(posedge SCin)
begin
//counter and shift register
	if (CntrStart == 1'b0) begin
		Cntr[2:0] <= 3'b0;
	end
	else begin
		Cntr[2:0] <= Cntr[2:0] + 3'b1;
		SR[7:0] <= {SR[6:0], SDin};
	end
	
//PBready set/reset	
	if (Cntr[2:0] == 3'd7) begin
		PDready <= 1'b1;
	end
	else begin
		PDready <= 1'b0;
	end
end
	
	
always @(posedge SCin) //Counter starter
begin
	if (SDin && Cntr[2:0] != 3'd7) begin
		CntrStart <= 1'b1;
	end
	else begin	
		if (Cntr[2:0] == 3'd7) begin
			CntrStart <= 1'b0;
		end
		else begin
			CntrStart <= CntrStart;
		end
	end
end

assign PDout[7:0] = SR[7:0];

endmodule 