module debouncer1
(
	input wire SwOut, Clk1ms,
	output reg SwOutDB1
);
reg [3:0] flip;


always @(posedge Clk1ms) //shift register
begin
	flip[3:0] <= {flip[2:0], SwOut};
end

always @(posedge Clk1ms) //debouncer 1 
begin
	SwOutDB1 <= (&flip[3:0])?(1'b1):((~(|flip[3:0]))?(1'b0):(SwOutDB1));
/*	if(&flip[3:0])
		SwOutDB1 <= 1'b1;
	else 
	begin
		if (~(|flip[3:0]))
			SwOutDB1 <= 1'b0;
		else
			SwOutDB1 <= SwOutDB1;
	end	*/
end


endmodule 