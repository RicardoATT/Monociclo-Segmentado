module mux_3_to_1 (
	input				[63:0]	a,
	input				[63:0]	b,
	input				[63:0]	c,
	input				[1:0]		sel,
	output	reg	[63:0]	out
);
	always @(*)
	begin
		case (sel)
		2'b00:
			out = a;
		2'b01:
			out = b;
		2'b10:
			out = c;
		default:
			out = 64'h0;
		endcase
	end
endmodule 