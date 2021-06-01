module Accumulator(Clk, Sel, RnW, Dio);
input Clk; 
input Sel; 
input RnW; 

inout [7:0] Dio; 

reg [7:0] FF;
reg zero;

always @(posedge Clk)
begin
	if (Sel == 1'b1) 
	begin
		if(RnW == 1'b1) //If read
		begin
			zero <= 1'b1;
		end
		else if((RnW == 1'b0) && (zero == 1'b1))//If write and FF = 0
		begin
			FF[7:0] <= Dio[7:0];
			zero <= 1'b0;
		end
		else if (zero == 1'b1)
		begin
			FF[7:0] <= 8'b0;
			zero <= 1'b0;
		end
		else //If write
		begin
			FF[7:0] <= FF[7:0] + Dio[7:0];
			zero <= 1'b0;
		end
	end
	else 
	begin
		FF[7:0] <= FF[7:0]; //Idle
		zero <= 1'b0;
	end
end

assign Dio[7:0] = ((RnW == 1'b1)&(Sel == 1'b1))?(FF[7:0]):(8'bZ);

endmodule 
