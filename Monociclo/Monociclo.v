/*
Proyecto: 		Monociclo segmentado
Archivo:			Monociclo.v
Organización:	Instituto Politecnico Nacional
Autor:			Ing. Ricardo Aldair Tirado Torres
E-mail:			rtiradot2023@cic.ipn.mx
Referencias:	Libro Lagarto I, Capítulo 1
					Libro Lagarto I, Capítulo 2
*/

module Monociclo (
	input						clk_i,
	input						rst_ni,
	output		[63:0]	wb_data_o
	);
	
/*
El monociclo se puede dividir generalmente en 5 etapas:
	-IF: 		Búsqueda de instrucciones
	-ID/RF: 	Decodificación de instrucciones y búsqueda de operandos
	-EX/AG: 	Ejecución/Cálculo de la dirección de memoria
	-MEM: 	Búsqueda de los operandos en memoria
	-WB: 		Almacenamiento/Escritura de retorno del resultado
*/	

///////////////////////// DEFINICIÓN DE SEÑALES /////////////////////////
	
// FETCH
	reg			[31:0]	pc;
	wire			[31:0]	pc_next4;
	wire			[31:0]	pc_next_bj;
	wire			[63:0]	pc_next_ext;
	wire			[31:0]	if_instr_o;
	wire						pc_branch;
	wire						pc_branch2;
	wire						pc_control;
	wire			[31:0]	pc_id;
	wire			[31:0]	pc_rr;
	wire			[31:0]	pc_ex;
	wire 			[31:0]	if_instr_if;
	wire 			[31:0]	if_instr_id;
	wire			[31:0]	pc_next_bj_latch;
	wire			[31:0]	pc_next4_id;
	wire			[31:0]	pc_next4_rr;
	wire			[31:0]	pc_next4_ex;
	wire			[31:0]	pc_next4_mem;
	wire			[31:0]	pc_next4_wb;

// INSTRUCTION DECODE
	wire 						id_regwrite_o;
	wire 						id_memread_o;
	wire 						id_memwrite_o;
	wire 						id_memtoreg_o;
	wire 						id_alusrc_o; 
	wire 			[2:0]		id_aluop_o;  
	wire 						id_branch_o; 
	wire 						id_jump_o;   
	wire 			[3:0]		alu_control_o;
	wire 						id_regwrite_id;
	wire 						id_memread_id;
	wire 						id_memwrite_id;
	wire 						id_memtoreg_id;
	wire 						id_alusrc_id; 
	wire 						id_branch_id; 
	wire 						id_jump_id;
	wire						id_ctrl_r_id;
	wire 			[3:0]		alu_control_id;
	wire 						id_regwrite_rr;
	wire 						id_memread_rr;
	wire 						id_memwrite_rr;
	wire 						id_memtoreg_rr;
	wire						id_alusrc_rr;
	wire 						id_branch_rr; 
	wire 						id_jump_rr;    
	wire						id_ctrl_r_rr;
	wire 			[3:0]		alu_control_rr;
	wire 						id_regwrite_ex;
	wire 						id_memread_ex;
	wire 						id_memwrite_ex;
	wire 						id_memtoreg_ex;
	wire						id_ctrl_r_ex;
	wire 						id_regwrite_mem;
	wire 						id_memtoreg_mem;
	wire						id_branch_mem;
	wire						id_jump_mem;
	wire						id_jump_wb;

// REGISTER READ
	wire			[63:0]	rr_data1_o;
	wire			[63:0]	rr_data2_o;
	wire			[63:0]	mux_wb_o;
	wire			[63:0]	rr_data1_latch;
	wire			[63:0]	rr_data2_latch;
	wire			[4:0]		addr_rd_ex;
	wire			[4:0]		addr_rs1_ex;
	wire			[4:0]		addr_rs2_ex;
	wire			[63:0]	data_rs1_ex;
	wire			[63:0]	data_rs2_ex;

// SIGN EXTENSION
	wire			[63:0]	se_immed_o;
	wire			[63:0]	mux_alusrc_o;
	wire			[63:0]	se_shift_o;
	wire			[63:0]	se_immed_latch;

// EXECUTION
	wire			[63:0]	ex_res_o;
	wire						b_flag_o;
	wire			[63:0]	ex_res_latch;
	wire						b_flag_latch;
	wire			[63:0]	data_wr_o;
	wire			[63:0]	ex_data_o;
	wire			[4:0]		addr_rd_mem;
	wire			[1:0]		mux_src1;
	wire			[1:0]		mux_src2;
	wire						mux_rr1;
	wire						mux_rr2;
	wire			[63:0]	rr_data1_rr;
	wire			[63:0]	rr_data2_rr;

// MEMORY ACCESS
	wire			[63:0]	mem_data_o;
	wire			[63:0]	mem_data_latch;
	wire			[4:0]		addr_rd_wb;
	
// HAZARD
	wire						h_lock;

// BRANCH_PREDICTOR
	wire						latch_flush;
	wire						if_id_flush;
	wire						ifidflush;

/////////////////////////	ETAPA FETCH - BÚSQUEDA DE INSTRUCCIONES /////////////////////////
	
	always @(posedge clk_i, negedge rst_ni)
	begin
		if (!rst_ni)
			pc <= 32'b0;
		else if (pc_control)
			pc <= pc_next_bj;
		else if (!h_lock)
			pc <= pc_next4;		//(pc_control) ? pc_next_bj : pc_next4;
	end

// Calculo del PC
	FullAdderN #( 
		.N				(32)
	)	
	Add4
	(
		.c_i			(1'b0),		//Warning por colocar al c_i a GND
		.a_i			(pc),
		.b_i			(32'h4),
		.s_o			(pc_next4)
		//.c_o			(c_o)
	);

// Instruction cache
	IMemory Instr_Mem (
		.clk_i			(clk_i),
		.rd_en_i			(1'b1),			//Enable Read		//Warning por conexion a VCC
		.addr_rd_i		(pc[6:2]),		//Address Read		//Warning por conexion a GND
		.data_rd_o		(if_instr_if)	//Data Read
	);

	BranchPredictor B_Predictor(
		.clk_i				(clk_i),
		.pc_i					(pc),
		.opcode_i			(if_instr_if[6:2]),
		.pc_alu_i			(pc_ex),
		.branch_i			(id_branch_o),
		.branch2_i			(id_branch_mem),
		.jump_i				(id_jump_o),
		.pc_target_i		(pc_next_bj_latch),
		.branch_pre_i		(pc_branch),
		.branch_pre2_i		(pc_branch2),
		.pc_control_o		(pc_control),
		.flush_control_o	(latch_flush),
		.if_id_flush_o		(if_id_flush),
		.pc_address_o		(pc_next_bj)
	);

//////////********** 	  Latch IF -> ID 		**********//////////
	
	assign ifidflush = latch_flush || if_id_flush;
	
	Latch_IF_ID Latch1(
		.clk_i			(clk_i),
		.rst_ni			(rst_ni),
		.if_id_lock		(h_lock),
		.if_id_flush	(ifidflush),
		.if_instr_i		(if_instr_if),
		.pc_i				(pc),
		.pc_next4_i		(pc_next4),
		.if_instr_o		(if_instr_id),
		.pc_o				(pc_id),
		.pc_next4_o		(pc_next4_id)
	);
	
///////////////////////// ETAPA DECODE - DECODIFICACIÓN /////////////////////////

	Decode Deco(
		.opcode_i		(if_instr_id[6:0]),
		.regwrite_o		(id_regwrite_id),
		.memread_o		(id_memread_id),
		.memwrite_o		(id_memwrite_id),
		.memtoreg_o		(id_memtoreg_id),
		.alusrc_o 		(id_alusrc_id),
		.aluop_o  		(id_aluop_o),
		.branch_o 		(id_branch_id),
		.jump_o			(id_jump_id),
		.ctrl_r_o		(id_ctrl_r_id)
	);
	
	DecodeALU DecoALU(
		.aluop_i			(id_aluop_o),
		.f7f3				({if_instr_id[30],if_instr_id[14:12]}),
		.alu_control_o	(alu_control_id)
	);

//////////********** 	  Latch ID -> EX 		**********//////////
	Latch_ID_RR Latch2(
		.clk_i			(clk_i),
		.rst_ni			(rst_ni),
		.id_rr_lock		(h_lock),
		.id_rr_flush	(latch_flush),
		.if_instr_i		(if_instr_id),
		.pc_i				(pc_id),
		.pc_next4_i		(pc_next4_id),
		.regwrite_i		(id_regwrite_id),
		.memread_i		(id_memread_id), 
		.memwrite_i		(id_memwrite_id),
		.memtoreg_i		(id_memtoreg_id),
		.alusrc_i		(id_alusrc_id),  
		.branch_i		(id_branch_id),  
		.jump_i			(id_jump_id),  
		.alu_control_i (alu_control_id),
		.ctrl_r_i		(id_ctrl_r_id),
		.if_instr_o		(if_instr_o),
		.pc_o				(pc_rr),
		.pc_next4_o		(pc_next4_rr),
		.regwrite_o		(id_regwrite_rr),
		.memread_o		(id_memread_rr), 
		.memwrite_o		(id_memwrite_rr),
		.memtoreg_o		(id_memtoreg_rr),
		.alusrc_o		(id_alusrc_rr),  
		.branch_o		(id_branch_rr),  
		.jump_o			(id_jump_rr),    
		.alu_control_o (alu_control_rr), 
		.ctrl_r_o		(id_ctrl_r_rr)
	);
	
///////////////////////// REGISTER READ - BÚSQUEDA DE OPERANDOS /////////////////////////
	
	SignExtendPC SignExtPC (
		.pc_return		(pc_next4_wb),			//PC retorno
		.se_pc_return	(pc_next_ext)		//PC retorno extendido
	);
	assign	mux_wb_o = (id_jump_wb) ? pc_next_ext : wb_data_o;
	
	RegisterFile #(
		.width 		(64),		//ancho
		.depth 		(5)		//profundidad
	)
	RegFile (
		.clk_i		(clk_i),
		.addr_a_i	(if_instr_o[19:15]),		//Address A
		.data_a_o	(rr_data1_rr),			//Data A
		.addr_b_i	(if_instr_o[24:20]),		//Address B
		.data_b_o	(rr_data2_rr),			//Data B
		.wr_en_i		(id_regwrite_o),			//Register write
		.addr_wr_i	(addr_rd_wb),				//Address destination
		.data_wr_i	(mux_wb_o)					//Data write back
	);
	assign rr_data1_latch = (mux_rr1) ? wb_data_o : rr_data1_rr;
	assign rr_data2_latch = (mux_rr2) ? wb_data_o : rr_data2_rr;

///////////////////////// SIGN EXTENSION - EXTENSION DE SIGNO /////////////////////////
	
	SignExtend SignExt (
		.if_instr_i	(if_instr_o),				//Instruccion
		.se_immed_o	(se_immed_latch)			//Inmediato con signo extendido
	);
	
//////////********** 	  Latch ID -> EX 		**********//////////
	Latch_RR_EX Latch3(
		.clk_i			(clk_i),
		.rst_ni			(rst_ni),
		.rr_ex_lock		(h_lock),
		.rr_ex_flush	(latch_flush),
		.pc_i				(pc_rr),
		.pc_next4_i		(pc_next4_rr),
		.rr_data1_i		(rr_data1_latch),
		.rr_data2_i		(rr_data2_latch),
		.se_immed_i		(se_immed_latch),
		.rd_i				(if_instr_o[11:7]),
		.rs1_i			(if_instr_o[19:15]),
		.rs2_i			(if_instr_o[24:20]),
		.regwrite_i		(id_regwrite_rr),
		.memread_i		(id_memread_rr),
		.memwrite_i		(id_memwrite_rr),
		.memtoreg_i		(id_memtoreg_rr),
		.alusrc_i		(id_alusrc_rr),
		.branch_i		(id_branch_rr),
		.jump_i			(id_jump_rr),
		.alu_control_i (alu_control_rr),
		.ctrl_r_i		(id_ctrl_r_rr),
		.pc_o				(pc_ex),
		.pc_next4_o		(pc_next4_ex),
		.rr_data1_o		(rr_data1_o),
		.rr_data2_o		(rr_data2_o),
		.se_immed_o		(se_immed_o),
		.rd_o				(addr_rd_ex),
		.rs1_o			(addr_rs1_ex),
		.rs2_o			(addr_rs2_ex),
		.regwrite_o		(id_regwrite_ex),
		.memread_o		(id_memread_ex),
		.memwrite_o		(id_memwrite_ex),
		.memtoreg_o		(id_memtoreg_ex),
		.alusrc_o		(id_alusrc_o),
		.branch_o		(id_branch_o),
		.jump_o			(id_jump_o),
		.alu_control_o (alu_control_o),
		.ctrl_r_o		(id_ctrl_r_ex)
	);
		
	assign	mux_alusrc_o = (id_alusrc_o) ? se_immed_o : rr_data2_o;
	assign	se_shift_o	 = se_immed_o << 1;
	
/////////////////////////	EXECUTION STAGE - EJECUCIÓN /////////////////////////
	Hazard hazard(
		.rs1_rr		(if_instr_o[19:15]),
		.rs2_rr		(if_instr_o[24:20]),
		.rd_ex		(addr_rd_ex),
		.rd_mem		(addr_rd_mem),
		.rd_wb		(addr_rd_wb),
		.ctrl_l_ex	(id_memread_ex),
		.ctrl_l_mem	(id_memread_o),
		.ctrl_r		(id_ctrl_r_rr),
		.h_lock		(h_lock)
	);

	
	Forwarding forward(
		.rs1_ex			(addr_rs1_ex),
		.rs2_ex			(addr_rs2_ex),
		.rs1_rr			(if_instr_o[19:15]),
		.rs2_rr			(if_instr_o[24:20]),
		.rd_mem			(addr_rd_mem),
		.rd_wb			(addr_rd_wb),
		.ctrl_r_ex		(id_ctrl_r_ex),
		.ctrl_r_rr		(id_ctrl_r_rr),
		.memwrite_i		(id_memwrite_o),
		.branch_i		(id_branch_o),
		.mux_src1		(mux_src1),
		.mux_src2		(mux_src2),
		.mux_rr_src1	(mux_rr1),
		.mux_rr_src2	(mux_rr2)
	);
	
	mux_3_to_1 mux_rs1 (
		.a		(rr_data1_o),
		.b		(ex_res_o),
		.c		(wb_data_o),
		.sel	(mux_src1),
		.out	(data_rs1_ex)
	);
	
	mux_3_to_1 mux_rs2 (
		.a		(mux_alusrc_o),
		.b		(ex_res_o),
		.c		(wb_data_o),
		.sel	(mux_src2),
		.out	(data_rs2_ex)
	);
	
	ALU Exe (
		.op1_i	(data_rs1_ex),				//Operador 1
		.op2_i	(data_rs2_ex),				//Operador 2
		.ope_i	(alu_control_o),			//Codigo de operacion de ALU
		.res_o	(ex_res_latch),			//Resultado ALU
		.b_flag	(b_flag_o)
	);
	
	FullAdderN #( 
		.N				(32)
	)	
	Addpc
	(
		.c_i			(1'b0),					//Warning por colocar al c_i a GND
		.a_i			(pc_ex),
		.b_i			(se_shift_o[31:0]),	//Warning debido a que por corrimiento a la izquierda, b_i[0] = 0
		.s_o			(pc_next_bj_latch)
		//.c_o			(c_o)
	);
	
	BJcontrol BJctrl(
		.branch_i		(id_branch_o),
		.jump_i			(id_jump_o),
		.b_flag_i		(b_flag_o),
		.pc_control_o	(pc_branch)
	);

//////////********** 	  Latch EX -> MEM 		**********//////////
	Latch_EX_MEM Latch4(
		.clk_i			(clk_i),
		.rst_ni			(rst_ni),
		.ex_mem_flush	(latch_flush),
		.pc_next4_i		(pc_next4_ex),
		.ex_res_i		(ex_res_latch),
		.rr_data2_i		(rr_data2_o),
		.rd_i				(addr_rd_ex),
		.regwrite_i		(id_regwrite_ex),
		.memread_i		(id_memread_ex),
		.memwrite_i		(id_memwrite_ex),
		.memtoreg_i		(id_memtoreg_ex),
		.branch_i		(id_branch_o),
		.branch_pre_i	(pc_branch),
		.jump_i			(id_jump_o),
		.pc_next4_o		(pc_next4_mem),
		.ex_res_o		(ex_res_o),
		.rr_data2_o		(data_wr_o),
		.rd_o				(addr_rd_mem),
		.regwrite_o		(id_regwrite_mem),
		.memread_o		(id_memread_o),
		.memwrite_o		(id_memwrite_o),
		.memtoreg_o		(id_memtoreg_mem),
		.branch_o		(id_branch_mem),
		.branch_pre_o	(pc_branch2),
		.jump_o			(id_jump_mem)
	);	
	
///////////////////////// DATA CACHE - ACCESO A MEMORIA /////////////////////////

	Memory DataMem (
		.clk_i			(clk_i),
		.rd_en_i			(id_memread_o),			//Read enable
		.addr_rd_i		(ex_res_o[6:3]),			//Address read - ex_res_o[12:3]
		.data_rd_o		(mem_data_latch),			//Data read
		.wr_en_i			(id_memwrite_o),			//Write enable
		.addr_wr_i		(ex_res_o[6:3]),			//Address write - ex_res_o[12:3]
		.data_wr_i		(data_wr_o)					//Data write
	);
	
//////////********** 	  Latch MEM -> WB		**********//////////
	Latch_MEM_WB Latch5(
		.clk_i			(clk_i),
		.rst_ni			(rst_ni),
		.pc_next4_i		(pc_next4_mem),
		.mem_data_i		(mem_data_latch),
		.ex_res_i		(ex_res_o),
		.rd_i				(addr_rd_mem),
		.regwrite_i		(id_regwrite_mem),
		.memtoreg_i		(id_memtoreg_mem),
		.jump_i			(id_jump_mem),
		.pc_next4_o		(pc_next4_wb),
		.mem_data_o		(mem_data_o),
		.ex_res_o		(ex_data_o),
		.rd_o				(addr_rd_wb),
		.regwrite_o		(id_regwrite_o),
		.memtoreg_o		(id_memtoreg_o),
		.jump_o			(id_jump_wb)
	);

/////////////////////////	ETAPA WRITE BACK - ESCRITURA DE RETORN DEL RESULTADO /////////////////////////

	assign wb_data_o = (id_memtoreg_o) ? mem_data_o : ex_data_o;
	
endmodule 


`timescale 1 ps/ 1 ps
module Monociclo_vlg_tst();
reg clk_i;
reg rst_ni;
// wires                                               
wire [63:0]  wb_data_o;
                       
Monociclo i1 (  
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.wb_data_o(wb_data_o)
);
initial                                                
begin
clk_i = 1;
rst_ni = 0;
#100
rst_ni = 1;                                               
$display("Running testbench");                       
end                                                    
always              
begin                                                  
#50 clk_i = ~clk_i;                      
end                                                    
endmodule 