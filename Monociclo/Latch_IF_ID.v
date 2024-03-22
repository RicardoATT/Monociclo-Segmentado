module Latch_IF_ID (
	input							clk_i,
	input							rst_ni,
	input							if_id_lock,
	input							if_id_flush,
	input				[31:0]	if_instr_i,
	input				[31:0]	pc_i,
	input				[31:0]	pc_next4_i,
	output	reg	[31:0]	if_instr_o,
	output	reg	[31:0]	pc_o,
	output	reg	[31:0]	pc_next4_o

);
	always @(posedge clk_i, negedge rst_ni)
		begin
		if (!rst_ni)
			begin
				if_instr_o 	<= 32'h0;
				pc_o 			<= 32'h0;
				pc_next4_o	<= 32'h0;
			end
		else if (if_id_flush)
			begin
				if_instr_o 	<= 32'h0;
				pc_o 			<= 32'h0;
				pc_next4_o	<= 32'h0;
			end
		else if (!if_id_lock)
			begin
				if_instr_o 	<= if_instr_i;
				pc_o 			<= pc_i;
				pc_next4_o	<= pc_next4_i;
			end
		end
endmodule 