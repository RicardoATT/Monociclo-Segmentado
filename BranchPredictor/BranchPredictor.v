module BranchPredictor#(
	parameter					depth = 5
)
(
	input							clk_i,
	input				[31:0]	pc_i,
	input				[4:0]		opcode_i,
	input				[31:0]	pc_alu_i,
	input							branch_i,
	input							branch2_i,
	input				[31:0]	pc_target_i,
	input							branch_pre_i,
	output	reg				pc_control_o,
	output	reg				flush_control_o,
	output	reg	[31:0]	pc_address_o
);

	reg				[24:0]	instr_pc[(2**depth)-1:0];
	reg				[1:0]		pht[(2**depth)-1:0];
	reg				[31:0]	target_buffer[(2**depth)-1:0];
	
	always @(posedge clk_i)
		begin
		if (branch_i)
			begin
			target_buffer[(pc_alu_i[6:2])] <= pc_target_i;
			if (!branch2_i)
				begin
				case (pht[(pc_alu_i[6:2])])
					//Strongly Not Taken
					2'b00:
						begin
						if (branch_pre_i)
							begin
							flush_control_o		= 1'h1;
							pc_control_o 			= 1'h1;
							pc_address_o 			= pc_target_i;
							pht[(pc_alu_i[6:2])] <= 2'b01;
							end
						else
							begin
							flush_control_o 		= 1'h0;
							pc_control_o 		   = 1'h0;
							end
						end
					//Doubtfully Not Taken
					2'b01:
						begin
						if (branch_pre_i)
							begin
							flush_control_o 		= 1'h1;
							pc_control_o 			= 1'h1;
							pc_address_o 			= pc_target_i;
							pht[(pc_alu_i[6:2])] <= 2'b10;
							end
						else
							begin
							flush_control_o 		= 1'h0;
							pc_control_o 			= 1'h0;
							pht[(pc_alu_i[6:2])] <= 2'b00;
							end
						end
					//Doubtfully Taken
					2'b10:
						begin
						if (branch_pre_i)
							begin
							flush_control_o 		= 1'h0;
							pc_control_o 			= 1'h1;
							pc_address_o 			= target_buffer[(pc_alu_i[6:2])];
							pht[(pc_alu_i[6:2])]	<= 2'b11;
							end
						else
							begin
							flush_control_o 		= 1'h1;
							pc_control_o 			= 1'h1;
							pc_address_o 			= pc_alu_i + 32'h4;
							pht[(pc_alu_i[6:2])] <= 2'b01;
							end
						end
					//Strongly Taken
					2'b11:
						begin
						if (branch_pre_i)
							begin
							flush_control_o 		= 1'h0;
							pc_control_o 			= 1'h1;
							pc_address_o 			= target_buffer[(pc_alu_i[6:2])];
							end
						else
							begin
							flush_control_o 		= 1'h1;
							pc_control_o 			= 1'h1;
							pc_address_o 			= pc_alu_i + 32'h4;
							pht[(pc_alu_i[6:2])] <= 2'b10;
							end
						end
					default
						begin
						flush_control_o = 1'h0;
						pc_control_o	 = 1'h0;
						pc_address_o	 = 32'h0;
						end
				endcase
				end
			end
		else if (opcode_i == 5'b11000)
			begin
			if (instr_pc[(pc_i[6:2])] == 25'h0)
				begin
				if (pht[(pc_i[6:2])] == 2'b00 || pht[(pc_i[6:2])] == 2'b01)
					pc_control_o = 1'h0;
				else
					begin
					pc_address_o = target_buffer[(pc_i[6:2])];
					pc_control_o = 1'h1;
					end
				end
			else
				begin
				instr_pc[(pc_i[6:2])] <= pc_i[31:7];
				pht[(pc_i[6:2])] <= 2'b00;
				end
			end
		else
			begin
			flush_control_o = 1'h0;
			pc_control_o	 = 1'h0;
			pc_address_o	 = 32'h0;
			end
		end
	
endmodule	