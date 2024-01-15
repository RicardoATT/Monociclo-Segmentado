module Hazard (
	input				[4:0]		rs1_rr,		
	input				[4:0]		rs2_rr,		
	input				[4:0]		rd_ex,		
	input				[4:0]		rd_mem,
	input				[4:0]		rd_wb,
	input							ctrl_r,
	input							ctrl_l_ex,
	input							ctrl_l_mem,
	output	reg				h_lock
);

	always @(*)
	begin
		if (ctrl_l_ex || ctrl_l_mem)
			begin
			if (ctrl_r)
				begin
				if ((rs1_rr == rd_ex || rs1_rr == rd_mem) && ~(rs1_rr == rd_wb))
					h_lock		= 1'b1;
				else if ((rs2_rr == rd_ex || rs2_rr == rd_mem) && ~(rs2_rr == rd_wb))
					h_lock		= 1'b1;
				else
					h_lock		= 1'b0;
				end
			else
				begin
				if ((rs1_rr == rd_ex || rs1_rr == rd_mem) && ~(rs1_rr == rd_wb))
					h_lock		= 1'b1;
				else
					h_lock		= 1'b0;
				end
			end
		else
			h_lock		= 1'b0;
	end
endmodule 