module debouncer2
(
	input wire SwOut, Clk1ms,
	output reg SwOutDB2 
);
reg [2:0] flip;


always @(posedge Clk1ms) //shift register
begin
	flip[2:0] <= {flip[1:0], SwOutDB2};
end

always @(posedge Clk1ms) //debouncer 2 
begin
	SwOutDB2 <= (&{flip[2:0], (~SwOut)})?(1'b0):(((~(|flip[2:0])) & (SwOut == 1'b1))?(1'b1):(SwOutDB2));
/*	if((&flip[2:0]) & (SwOut == 1'b0))
		SwOutDB2 <= 1'b0;
	else 
	begin
		if ((~(|flip[2:0])) & (SwOut == 1'b1))
			SwOutDB2 <= 1'b1;
		else
			SwOutDB2 <= SwOutDB2;
	end	
	*/
end

endmodule 