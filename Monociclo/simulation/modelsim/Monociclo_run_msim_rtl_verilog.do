transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/BranchPredictor {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/BranchPredictor/BranchPredictor.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/mux_3_to_1 {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/mux_3_to_1/mux_3_to_1.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Forwarding {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Forwarding/Forwarding.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Hazard {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Hazard/Hazard.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/SignExtendPC {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/SignExtendPC/SignExtendPC.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/BJcontrol {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/BJcontrol/BJcontrol.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/DecodeALU {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/DecodeALU/DecodeALU.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/FullAdderN {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/FullAdderN/FullAdderN.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/FullAdder {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/FullAdder/FullAdder.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/SignExtend {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/SignExtend/SignExtend.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/RegisterFile {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/RegisterFile/RegisterFile.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/ALU {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Decode {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Decode/Decode.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Monociclo.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Latch_IF_ID.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Latch_EX_MEM.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Latch_MEM_WB.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Latch_RR_EX.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Monociclo/Latch_ID_RR.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/IMemory {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/IMemory/IMemory.v}
vlog -vlog01compat -work work +incdir+/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Memory {/home/rick/Escritorio/Examen_Monociclo_Segmentado-20230614T194855Z-001/Examen_Monociclo_Segmentado/Memory/Memory.v}

