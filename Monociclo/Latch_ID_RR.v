module Latch_ID_RR (
	input							clk_i,
	input							rst_ni,
	input							id_rr_lock,
	input							id_rr_flush,
	input				[31:0]	if_instr_i,
	input				[31:0]	pc_i,
	input							regwrite_i,
	input							memread_i, 
	input							memwrite_i,
	input							memtoreg_i,
	input							alusrc_i,  
	input							branch_i,  
	input							jump_i,     
	input				[3:0]		alu_control_i,
	input							ctrl_r_i,
	output	reg	[31:0]	if_instr_o,
	output	reg	[31:0]	pc_o,
	output 	reg				regwrite_o,
	output 	reg				memread_o, 
	output 	reg				memwrite_o,
	output 	reg				memtoreg_o,
	output 	reg				alusrc_o,  
	output 	reg				branch_o,  
	output 	reg				jump_o,
	output	reg	[3:0]		alu_control_o,
	output	reg				ctrl_r_o
);
	always @(posedge clk_i, negedge rst_ni)
		begin
		if (!rst_ni)
			begin
				if_instr_o		<= 32'h0;
				pc_o 				<= 32'h0;
				regwrite_o 		<= 1'h0;
				memread_o  		<= 1'h0;
				memwrite_o 		<= 1'h0;
				memtoreg_o 		<= 1'h0;
				alusrc_o	  		<= 1'h0;
				branch_o	  		<= 1'h0;
				jump_o     		<= 1'h0;
				alu_control_o	<= 4'h0;
				ctrl_r_o			<= 1'h0;
			end
		else if (id_rr_flush)
			begin
				if_instr_o		<= 32'h0;
				pc_o 				<= 32'h0;
				regwrite_o 		<= 1'h0;
				memread_o  		<= 1'h0;
				memwrite_o 		<= 1'h0;
				memtoreg_o 		<= 1'h0;
				alusrc_o	  		<= 1'h0;
				branch_o	  		<= 1'h0;
				jump_o     		<= 1'h0;
				alu_control_o	<= 4'h0;
				ctrl_r_o			<= 1'h0;
			end
		else if (!id_rr_lock)
			begin
				if_instr_o		<= if_instr_i;
				pc_o 				<= pc_i;
				regwrite_o 		<= regwrite_i;
				memread_o  		<= memread_i;
				memwrite_o 		<= memwrite_i;
				memtoreg_o 		<= memtoreg_i;
				alusrc_o	  		<= alusrc_i;  
				branch_o	  		<= branch_i;   
				jump_o     		<= jump_i;  	 
				alu_control_o	<= alu_control_i;
				ctrl_r_o			<= ctrl_r_i;
			end
		end
endmodule 