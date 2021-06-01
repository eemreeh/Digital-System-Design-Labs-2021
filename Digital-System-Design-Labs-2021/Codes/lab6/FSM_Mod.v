module FSM_Mod (
	input wire Clk, nRst, 
	input wire [1:0] D1_2,
	output reg [2:0] outputState,
	output reg [3:0] counter
);

reg [1:0] updown;
//reg [2:0] currentState;
reg [2:0] State;


parameter idle = 2'b00, up = 2'b01, down = 2'b10;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;

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
			S0: // 00
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b10)
					State <= S1;
				else if(D1_2 == 2'b00)
					State <= S0;
				else 
					State <= S5;
				updown <= idle;
			end
			S1: // 10 forward
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
			S2: // 11 foward
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
			S3: // 01 forward
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b00) begin
					State <= S4;
				end		
				else if (D1_2 == 2'b01) begin
					State <= S3;
				end
				else begin
					State <= S2;
				end
				updown <= idle;
			end
			S4: // 00 car passed forward
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else 
					State <= S0;
				updown <= up;
			end
			S5: // 01 backward
			begin
				if(D1_2 == 2'b11) 
					State <= S6;	
				else if (D1_2 == 2'b01) 
					State <= S5;
				else 
					State <= S0;
				updown <= idle;
			end
			S6: // 11 backward
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b10) 
					State <= S7;	
				else if (D1_2 == 2'b11) 
					State <= S6;
				else 
					State <= S5;
				updown <= idle;
			end
			S7: // 10 backward
			begin
				if(nRst == 1'b0)
					State <=  S0;
				else if(D1_2 == 2'b00) begin
					State <= S0;
					updown <= down;	
				end
				else if (D1_2 == 2'b10) begin
					State <= S7;
					updown <= idle;
				end
				else begin 
					State <= S6;
					updown <= idle;
				end
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
	else if(updown == down)
	begin
		counter[3:0] <= counter[3:0] - 4'b1;
	end
	else
		counter[3:0] <= counter[3:0];
end


endmodule 