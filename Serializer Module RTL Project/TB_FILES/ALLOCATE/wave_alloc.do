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
add wave -noupdate /allocate_TB/DUT/clk
add wave -noupdate /allocate_TB/DUT/rst
add wave -noupdate /allocate_TB/DUT/sop_in
add wave -noupdate /allocate_TB/DUT/first_word_r
add wave -noupdate /allocate_TB/DUT/last_word_r
add wave -noupdate /allocate_TB/DUT/new_word_r
add wave -noupdate /allocate_TB/DUT/word_r
add wave -noupdate /allocate_TB/DUT/first_word_a
add wave -noupdate /allocate_TB/DUT/last_word_a
add wave -noupdate /allocate_TB/DUT/new_word_a
add wave -noupdate /allocate_TB/DUT/word_a
add wave -noupdate /allocate_TB/DUT/num_values_a
add wave -noupdate /allocate_TB/DUT/packet_in_progress
add wave -noupdate /allocate_TB/DUT/extended_word
add wave -noupdate /allocate_TB/DUT/num_carry_bits
add wave -noupdate /allocate_TB/DUT/carry_bits
add wave -noupdate /allocate_TB/DUT/packet_recieved
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {859 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 146
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {1933 fs}
