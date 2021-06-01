module counter 
(
	input wire nRst, Clk, CntEn,
	output reg [3:0] Cout,
	output NextEn
);
	assign NextEn = ((Cout[3:0] == 4'b1001) & (CntEn))?(1'b1):(1'b0);
	
	always @(posedge Clk, negedge nRst )
	begin
		if (nRst == 1'b0) 
		begin
			Cout[3:0] <= 4'b0;
		end 
		else 
		begin
			if (CntEn == 1'b1)
			begin
				if(Cout[3:0] != 4'b1001)
				begin
					Cout[3:0] <= Cout[3:0] + 4'b1;
				end
				else 
				begin
					Cout[3:0] <= 4'b0000;
				end
			end
			else 
				Cout[3:0] <= Cout[3:0];
		end
	end 
	
	
endmodule 