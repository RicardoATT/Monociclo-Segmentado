module Latch_MEM_WB (
	input							clk_i,		
	input							rst_ni,
	input				[31:0]	pc_next4_i,	
	input				[63:0]	mem_data_i,	
	input				[63:0]	ex_res_i,	
	input				[4:0]		rd_i,
	input							regwrite_i,
	input							memtoreg_i,
	input							jump_i,
	output	reg	[31:0]	pc_next4_o,
	output	reg	[63:0]	mem_data_o,	
	output	reg	[63:0]	ex_res_o,	
	output	reg	[4:0]		rd_o,
	output	reg				regwrite_o,
	output	reg				memtoreg_o,
	output 	reg				jump_o
);
	always @(posedge clk_i, negedge rst_ni)
		begin
		if(!rst_ni)
			begin
				pc_next4_o	<= 32'h0;
				mem_data_o	<= 64'h0;
				ex_res_o 	<= 64'h0;
				rd_o			<= 5'h0;
				regwrite_o	<=	1'h0;
				memtoreg_o	<= 1'h0;
				jump_o     	<= 1'h0;
			end
		else
			begin
				pc_next4_o	<= pc_next4_i;
				mem_data_o 	<= mem_data_i;
				ex_res_o 	<= ex_res_i;
				rd_o			<= rd_i;
				regwrite_o	<=	regwrite_i;
				memtoreg_o	<= memtoreg_i;
				jump_o     	<= jump_i;
			end
		end
endmodule 