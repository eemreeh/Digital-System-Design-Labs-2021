module and_xor
(
  input wire op1, op2, sel,
  output wire fout
);
  
  assign fout = (sel == 1'b0)?(op1 & op2):(op1 ^ op2);
  
endmodule