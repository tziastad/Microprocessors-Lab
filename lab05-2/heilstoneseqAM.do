onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /heilstoneseqAM/cpuinst/STATE_AS_STR
add wave -noupdate /heilstoneseqAM/cpuinst/pc
add wave -noupdate /heilstoneseqAM/cpuinst/opcode
add wave -noupdate /heilstoneseqAM/cpuinst/operand1
add wave -noupdate /heilstoneseqAM/cpuinst/operand2
add wave -noupdate /heilstoneseqAM/cpuinst/operand3
add wave -noupdate /heilstoneseqAM/cpuinst/regset_cmd
add wave -noupdate /heilstoneseqAM/cpuinst/regset_wb
add wave -noupdate /heilstoneseqAM/cpuinst/regdatatoload
add wave -noupdate /heilstoneseqAM/cpuinst/RegOp1
add wave -noupdate /heilstoneseqAM/cpuinst/regfileinst/R
add wave -noupdate /heilstoneseqAM/cpuinst/raminst/mem
add wave -noupdate {/heilstoneseqAM/cpuinst/raminst/mem[40]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
