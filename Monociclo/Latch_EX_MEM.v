module Latch_EX_MEM (
	input							clk_i,		
	input							rst_ni,		 
	input							ex_mem_flush,
	input				[31:0]	pc_next4_i,
	input				[63:0]	ex_res_i,		
	input				[63:0]	rr_data2_i,
	input				[4:0]		rd_i,
	input							regwrite_i,		
	input							memread_i,		
	input							memwrite_i,		
	input							memtoreg_i,
	input							branch_i,
	input							branch_pre_i,
	input							jump_i,
	output	reg	[31:0]	pc_next4_o,
	output	reg	[63:0]	ex_res_o,		
	output	reg	[63:0]	rr_data2_o,
	output	reg	[4:0]		rd_o,
	output	reg				regwrite_o,		
	output	reg				memread_o,		
	output	reg				memwrite_o,		
	output	reg				memtoreg_o,
	output	reg				branch_o,
	output	reg				branch_pre_o,
	output 	reg				jump_o

);
	always @(posedge clk_i, negedge rst_ni)
		begin
		if(!rst_ni)
			begin
				pc_next4_o		<= 32'h0;
				ex_res_o			<= 64'h0;
				rr_data2_o		<= 64'h0;
				rd_o				<= 5'h0;
				regwrite_o		<= 1'h0;
				memread_o		<= 1'h0;
				memwrite_o		<= 1'h0;
				memtoreg_o		<= 1'h0;
				branch_o			<= 1'h0;
				branch_pre_o	<= 1'h0;
				jump_o     		<= 1'h0;
			end
		else if (ex_mem_flush)
			begin
				pc_next4_o		<= 32'h0;
				ex_res_o			<= 64'h0;
				rr_data2_o		<= 64'h0;
				rd_o				<= 5'h0;
				regwrite_o		<= 1'h0;
				memread_o		<= 1'h0;
				memwrite_o		<= 1'h0;
				memtoreg_o		<= 1'h0;
				branch_o			<= 1'h0;
				branch_pre_o	<= 1'h0;
				jump_o     		<= 1'h0;
			end
		else
			begin
				pc_next4_o		<= pc_next4_i;
				ex_res_o			<= ex_res_i;
				rr_data2_o		<= rr_data2_i;
				rd_o				<= rd_i;
				regwrite_o		<= regwrite_i;	
				memread_o		<= memread_i;
				memwrite_o		<= memwrite_i;	
				memtoreg_o		<= memtoreg_i;
				branch_o			<= branch_i;
				branch_pre_o	<= branch_pre_i;
				jump_o     		<= jump_i;
			end
		end
endmodule 