module Reg8bit(Clk, Sel, RnW, Dio);
input Clk; 
input Sel; 
input RnW; 

inout [7:0] Dio; 

reg [7:0] FF;

always @(posedge Clk)
begin
	if (Sel == 1'b1) 
	begin
		if(RnW == 1'b1) //If read 
		begin
			FF[7:0] <= FF[7:0];
		end
		else //If write
		begin
			FF[7:0] <= Dio[7:0]; 
		end
	end
	else 
	begin
		FF[7:0] <= FF[7:0]; //Idle
	end
end

assign Dio[7:0] = ((RnW == 1'b1)&(Sel == 1'b1))?(FF[7:0]):(8'bZ);

endmodule 
