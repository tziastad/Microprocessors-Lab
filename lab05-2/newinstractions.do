onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /newinstractionstb/reset
add wave -noupdate /newinstractionstb/clk
add wave -noupdate /newinstractionstb/cpuinst/opcode
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/pc
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/STATE_AS_STR
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/operand1
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/operand2
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/operand3
add wave -noupdate /newinstractionstb/cpuinst/regset_cmd
add wave -noupdate /newinstractionstb/cpuinst/regset_wb
add wave -noupdate -radix unsigned /newinstractionstb/cpuinst/RegOp1
add wave -noupdate /newinstractionstb/memi
add wave -noupdate /newinstractionstb/cpuinst/regfileinst/R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {123 ps} 0}
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
WaveRestoreZoom {75 ps} {139 ps}
