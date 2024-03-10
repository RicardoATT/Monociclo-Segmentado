transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/BranchPredictor {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/BranchPredictor/BranchPredictor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/mux_3_to_1 {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/mux_3_to_1/mux_3_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Forwarding {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Forwarding/Forwarding.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Hazard {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Hazard/Hazard.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/SignExtendPC {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/SignExtendPC/SignExtendPC.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/BJcontrol {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/BJcontrol/BJcontrol.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/DecodeALU {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/DecodeALU/DecodeALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/FullAdderN {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/FullAdderN/FullAdderN.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/FullAdder {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/FullAdder/FullAdder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/SignExtend {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/SignExtend/SignExtend.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/RegisterFile {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/RegisterFile/RegisterFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/ALU {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Decode {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Decode/Decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Monociclo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Latch_IF_ID.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Latch_EX_MEM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Latch_MEM_WB.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Latch_RR_EX.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/Latch_ID_RR.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/IMemory {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/IMemory/IMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Memory {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Memory/Memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/Ricardo\ Aldair\ TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/simulation/modelsim {C:/Users/Ricardo Aldair TT/Documents/RATT_repos/Procesador_segmentado/Monociclo/simulation/modelsim/Monociclo.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Monociclo_vlg_tst

add wave *
view structure
view signals
run 100 ns
