module Latch_RR_EX (
	input							clk_i,
	input							rst_ni,
	input							rr_ex_lock,
	input							rr_ex_flush,
	input				[31:0]	pc_i,
	input				[63:0]	rr_data1_i,
	input				[63:0]	rr_data2_i,
	input				[63:0]	se_immed_i,
	input				[4:0]		rd_i,
	input				[4:0]		rs1_i,
	input				[4:0]		rs2_i,
	input							regwrite_i,
	input							memread_i, 
	input							memwrite_i,
	input							memtoreg_i,
	input							alusrc_i,
	input							branch_i,  
	input							jump_i,
	input				[3:0]		alu_control_i,
	input							ctrl_r_i,
	output	reg	[31:0]	pc_o,
	output	reg	[63:0]	rr_data1_o,
	output	reg	[63:0]	rr_data2_o,
	output	reg	[63:0]	se_immed_o,
	output	reg	[4:0]		rd_o,
	output	reg	[4:0]		rs1_o,
	output	reg	[4:0]		rs2_o,
	output 	reg				regwrite_o,
	output 	reg				memread_o, 
	output 	reg				memwrite_o,
	output 	reg				memtoreg_o,
	output	reg				alusrc_o,
	output 	reg				branch_o,  
	output 	reg				jump_o,
	output	reg	[3:0]		alu_control_o,
	output	reg				ctrl_r_o
);
	always @(posedge clk_i, negedge rst_ni)
		begin
		if (!rst_ni)
			begin
				pc_o 				<= 32'h0;
				rr_data1_o 		<= 64'h0;
				rr_data2_o 		<= 64'h0;
				se_immed_o 		<= 64'h0;
				rd_o				<= 5'h0;
				rs1_o				<= 5'h0;
				rs2_o				<= 5'h0;
				regwrite_o 		<= 1'h0;
				memread_o  		<= 1'h0;
				memwrite_o 		<= 1'h0;
				memtoreg_o 		<= 1'h0;
				alusrc_o			<= 1'h0;
				branch_o	  		<= 1'h0;
				jump_o     		<= 1'h0;
				alu_control_o	<= 4'h0;
				ctrl_r_o			<= 1'h0;
			end
		else if (rr_ex_flush)
			begin
				pc_o 				<= 32'h0;
				rr_data1_o 		<= 64'h0;
				rr_data2_o 		<= 64'h0;
				se_immed_o 		<= 64'h0;
				rd_o				<= 5'h0;
				rs1_o				<= 5'h0;
				rs2_o				<= 5'h0;
				regwrite_o 		<= 1'h0;
				memread_o  		<= 1'h0;
				memwrite_o 		<= 1'h0;
				memtoreg_o 		<= 1'h0;
				alusrc_o			<= 1'h0;
				branch_o	  		<= 1'h0;
				jump_o     		<= 1'h0;
				alu_control_o	<= 4'h0;
				ctrl_r_o			<= 1'h0;
			end
		else if (!rr_ex_lock)
			begin
				pc_o 				<= pc_i;
				rr_data1_o 		<= rr_data1_i;
				rr_data2_o 		<= rr_data2_i;
				se_immed_o 		<= se_immed_i;
				rd_o				<= rd_i;
				rs1_o				<= rs1_i;
				rs2_o				<= rs2_i;
				regwrite_o 		<= regwrite_i;
				memread_o  		<= memread_i;
				memwrite_o 		<= memwrite_i;
				memtoreg_o 		<= memtoreg_i;
				alusrc_o			<= alusrc_i;
				branch_o	  		<= branch_i;	 
				jump_o     		<= jump_i;
				alu_control_o	<= alu_control_i;
				ctrl_r_o			<= ctrl_r_i;
			end
		end
endmodule 