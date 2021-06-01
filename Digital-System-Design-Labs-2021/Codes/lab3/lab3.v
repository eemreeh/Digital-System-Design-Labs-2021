module lab3 
(
	input wire Clk,SwOut,
	output wire SwOutDB1, SwOutDB2
);

	debouncer1 db1(SwOut,Clk,SwOutDB1);
	debouncer2 db2(SwOut,Clk,SwOutDB2);

endmodule 