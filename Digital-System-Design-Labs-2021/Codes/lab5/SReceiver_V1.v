module SReceiver_V1
(
	input wire SCin, SDin,
	output wire [7:0] PDout,
	output reg PDready, ParErr
);
reg [3:0] Cntr;
reg CntrStart;	
reg [8:0] SR;
	
always @(posedge SCin)
begin
//counter and shift register
	if (CntrStart == 1'b0) begin
		Cntr[3:0] <= 3'b0;
	end
	else begin
		Cntr[3:0] <= Cntr[3:0] + 4'b1;
		SR[8:0] <= {SR[7:0], SDin}; //Shift Register
	end
	
//PBready set/reset	
	if (Cntr[3:0] == 4'd8) begin
		PDready <= 1'b1;
	end
	else begin
		PDready <= 1'b0;
	end
	
//ParErr	
	if ((Cntr[3:0] == 4'd8) && (^PDout[7:1] == SR[0])) begin
		ParErr <= 1'b1; 	//Intentionally wrong, it is supposed to be 1'b0
	end else if (Cntr[3:0] == 4'd1) begin
		ParErr <= 1'b0;		//Intentionally wrong, it is supposed to be 1'b1
	end
end
	
	
always @(posedge SCin) //Counter starter
begin
	if (SDin && Cntr[3:0] != 4'd8) begin
		CntrStart <= 1'b1;
	end
	else begin	
		if (Cntr[3:0] == 4'd8) begin
			CntrStart <= 1'b0;
		end
		else begin
			CntrStart <= CntrStart;
		end
	end
end

assign PDout[7:0] = SR[8:1];

endmodule 


