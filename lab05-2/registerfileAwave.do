onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registerfileA/reset
add wave -noupdate /registerfileA/clk
add wave -noupdate /registerfileA/cpuinst/pc
add wave -noupdate /registerfileA/cpuinst/opcode
add wave -noupdate -radix ascii /registerfileA/cpuinst/STATE_AS_STR
add wave -noupdate -radix unsigned /registerfileA/cpuinst/operand1
add wave -noupdate -radix unsigned /registerfileA/cpuinst/operand2
add wave -noupdate -radix unsigned /registerfileA/cpuinst/operand3
add wave -noupdate -radix unsigned /registerfileA/cpuinst/regset_cmd
add wave -noupdate /registerfileA/cpuinst/regset_wb
add wave -noupdate -radix unsigned /registerfileA/cpuinst/RegOp1
add wave -noupdate /registerfileA/memi
add wave -noupdate /registerfileA/cpuinst/raminst/mem
add wave -noupdate {/registerfileA/cpuinst/raminst/mem[20]}
add wave -noupdate /registerfileA/cpuinst/regfileinst/R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {63 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {943 ps} {1003 ps}
