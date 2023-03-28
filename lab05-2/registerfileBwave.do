onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registerfileB/reset
add wave -noupdate /registerfileB/clk
add wave -noupdate -radix unsigned /registerfileB/memi
add wave -noupdate -radix unsigned /registerfileB/cpuinst/pc
add wave -noupdate -radix unsigned /registerfileB/cpuinst/STATE_AS_STR
add wave -noupdate -radix unsigned /registerfileB/cpuinst/opcode
add wave -noupdate -radix unsigned /registerfileB/cpuinst/operand1
add wave -noupdate -radix unsigned /registerfileB/cpuinst/operand2
add wave -noupdate -radix unsigned /registerfileB/cpuinst/operand3
add wave -noupdate -radix unsigned /registerfileB/cpuinst/regset_cmd
add wave -noupdate -radix unsigned /registerfileB/cpuinst/regset_wb
add wave -noupdate -radix unsigned /registerfileB/cpuinst/RegOp1
add wave -noupdate -radix unsigned /registerfileB/cpuinst/raminst/mem
add wave -noupdate -radix unsigned {/registerfileB/cpuinst/raminst/mem[100]}
add wave -noupdate -radix unsigned {/registerfileB/cpuinst/raminst/mem[101]}
add wave -noupdate -radix unsigned -childformat {{{/registerfileB/cpuinst/regfileinst/R[15]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[14]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[13]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[12]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[11]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[10]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[9]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[8]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[7]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[6]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[5]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[4]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[3]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[2]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[1]} -radix unsigned} {{/registerfileB/cpuinst/regfileinst/R[0]} -radix unsigned}} -subitemconfig {{/registerfileB/cpuinst/regfileinst/R[15]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[14]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[13]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[12]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[11]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[10]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[9]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[8]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[7]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[6]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[5]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[4]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[3]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[2]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[1]} {-radix unsigned} {/registerfileB/cpuinst/regfileinst/R[0]} {-radix unsigned}} /registerfileB/cpuinst/regfileinst/R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
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
