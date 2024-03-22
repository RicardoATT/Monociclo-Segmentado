module Memory #(
	parameter					width = 64,		//ancho de palabra
	parameter					depth = 4		//profundidad (2**n)
)
(
	input							clk_i,			//clock signal
	input							wr_en_i,			//Write enable
	input			[depth-1:0]	addr_wr_i,		//address write
	input			[width-1:0]	data_wr_i,		//Data write
	input							rd_en_i,			//Read enable
	input			[depth-1:0]	addr_rd_i,		//address read
	output		[width-1:0]	data_rd_o		//Data read
);
	//Definición de la memoria
	reg			[width-1:0]	mem[(2**depth)-1:0];
	//Inicializacion de memoria de instrucciones
	initial
		begin
			$readmemh("Data_Mem.hex", mem);
		end
	//Escritura
	always @(posedge clk_i)
	begin
		if (wr_en_i)
			mem[addr_wr_i] <= data_wr_i;
	end
	//Lectura
	assign data_rd_o = (rd_en_i) ? mem[addr_rd_i] : {width{1'b0}};
	
endmodule 