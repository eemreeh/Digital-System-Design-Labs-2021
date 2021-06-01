module Lab1
(
	input wire clk, rst, fsel,
	output wire fout
);
	wire [2:0] tempO;
	
	Bit3Counter b3c(clk, rst, tempO[2:0]);
	and_xor ax(tempO[0],tempO[2], fsel, fout);

endmodule 

