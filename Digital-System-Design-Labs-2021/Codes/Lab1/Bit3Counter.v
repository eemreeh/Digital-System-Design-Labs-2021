module Bit3Counter 
(
  input wire clk, nrst,
  output reg [2:0] ctrO
);
	
    always @ (posedge clk or negedge nrst)
		if (nrst == 1'b1) begin
			ctrO[2:0] <= ctrO[2:0] + 3'b1;
		end  
		else begin
			ctrO[2:0] <= ctrO[2:0];
		end 
		
endmodule 