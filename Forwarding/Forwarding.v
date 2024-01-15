module Forwarding (
	input				[4:0]		rs1_ex,
	input				[4:0]		rs2_ex,
	input				[4:0]		rs1_rr,
	input				[4:0]		rs2_rr,
	input				[4:0]		rd_mem,
	input				[4:0]		rd_wb,
	input							ctrl_r_ex,
	input							ctrl_r_rr,
	input							branch_i,
	output	reg	[1:0]		mux_src1,
	output	reg	[1:0]		mux_src2,
	output	reg				mux_rr_src1,
	output	reg				mux_rr_src2
);

	always @(*)
	begin
		if ((rs1_ex == rd_mem) && ~(rs1_ex == rd_wb))
			mux_src1 = 2'b01;	
		else if (rs1_ex == rd_wb)
			mux_src1 = 2'b10;
		else
			mux_src1 = 2'b00;
		if (rs1_rr == rd_wb)
			mux_rr_src1 = 1'b1;
		else
			mux_rr_src1 = 1'b0;
		if (ctrl_r_rr)
			begin
			if (rs2_rr == rd_wb)
				mux_rr_src2 = 1'b1;
			else
				mux_rr_src2 = 1'b0;
			end
		else
			mux_rr_src2 = 1'b0;
		if (ctrl_r_ex || branch_i)
			begin
			if (rs2_ex == rd_mem && ~(rs2_ex == rd_wb))
				mux_src2 = 2'b01;	
			else if (rs2_ex == rd_wb)
				mux_src2 = 2'b10;
			else
				mux_src2 = 2'b00;
			end
		else
			mux_src2 = 2'b00;
	end
endmodule 