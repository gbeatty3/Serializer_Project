onerror {resume}
radix define FSM {
    "3'd0" "WAIT" -color "white",
    "3'd1" "ZERO" -color "white",
    "3'd3" "FOUR" -color "white",
    "3'd2" "ONE" -color "white",
    "3'd6" "FIVE" -color "white",
    "3'd7" "TWO" -color "white",
    "3'd5" "SIX" -color "white",
    "3'd4" "THREE" -color "white",
    -default binary
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_unpack_TB/DUT/clk
add wave -noupdate /data_unpack_TB/DUT/rst
add wave -noupdate /data_unpack_TB/DUT/ready_out
add wave -noupdate /data_unpack_TB/DUT/valid_in
add wave -noupdate /data_unpack_TB/DUT/data_in
add wave -noupdate /data_unpack_TB/DUT/sop_in
add wave -noupdate /data_unpack_TB/DUT/eop_in
add wave -noupdate /data_unpack_TB/DUT/valid_out
add wave -noupdate /data_unpack_TB/DUT/data_out
add wave -noupdate /data_unpack_TB/DUT/sop_out
add wave -noupdate /data_unpack_TB/DUT/eop_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1400 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 108
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {6300 fs}
