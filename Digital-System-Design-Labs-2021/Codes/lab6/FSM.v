module FSM (
	input wire Clk, nRst, 
	input wire [1:0] D1_2,
	output reg [2:0] outputState,
	output reg [3:0] counter
);

reg updown;
reg [2:0] State;

parameter idle = 1'b0, up = 1'b1;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @(State)
begin
	case(State)
		S0:
			outputState = S0;
		S1:
			outputState = S1;
		S2:
			outputState = S2;
		S3:
			outputState = S3;
		S4:
			outputState = S4;
		default:	
			outputState = S0;
	endcase
end


always @(posedge Clk, negedge nRst)
begin
	if(nRst == 1'b0)
	begin
		State <=  S0;
	end
	else
	begin
		case (State)
			S0:
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b10)
					State <= S1;
				else 
					State <= S0;
				updown <= idle;
			end
			S1:
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b11)
					State <= S2;
				else if (D1_2 == 2'b10)
					State <= S1;
				else 
					State <= S0;
				updown <= idle;
			end	
			S2:
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b01)
					State <= S3;
				else if (D1_2 == 2'b11)
					State <= S2;
				else
					State <= S1;
				updown <= idle;
			end
			S3:
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b00) 
					State <= S4;
				else if (D1_2 == 2'b01) 
					State <= S3;
				else	
					State <= S2;
				updown <= idle;
			end
			S4:
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else 
					State <= S0;
				updown <= up;
			end
			default:
			begin
				State <= S0;
				updown <= idle;
			end
		endcase		
	end
end



always @(posedge Clk, negedge nRst)
begin
	if(nRst == 1'b0)
	begin
		counter[3:0] <= 4'b0;
	end
	else if(updown == up) 
	begin
		counter[3:0] <= counter[3:0] + 4'b1;
	end
	else
		counter[3:0] <= counter[3:0];
end


endmodule 