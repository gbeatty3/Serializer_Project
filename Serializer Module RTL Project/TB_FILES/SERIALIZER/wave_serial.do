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
add wave -noupdate /serializer_TB/DUT/clk
add wave -noupdate /serializer_TB/DUT/rst
add wave -noupdate /serializer_TB/DUT/new_word_a
add wave -noupdate /serializer_TB/DUT/new_word_s
add wave -noupdate /serializer_TB/DUT/accept_word
add wave -noupdate /serializer_TB/DUT/first_word_a
add wave -noupdate /serializer_TB/DUT/first_value_flag
add wave -noupdate /serializer_TB/DUT/last_word_a
add wave -noupdate /serializer_TB/DUT/last_value_flag
add wave -noupdate -radix unsigned /serializer_TB/DUT/num_values_a
add wave -noupdate -radix hexadecimal /serializer_TB/DUT/word_a
add wave -noupdate /serializer_TB/DUT/packet_in_progress
add wave -noupdate /serializer_TB/DUT/valid_out
add wave -noupdate -radix hexadecimal /serializer_TB/DUT/temp_word
add wave -noupdate -radix hexadecimal /serializer_TB/DUT/data_out
add wave -noupdate /serializer_TB/DUT/first_value
add wave -noupdate /serializer_TB/DUT/last_value
add wave -noupdate -radix unsigned /serializer_TB/DUT/value_counter
add wave -noupdate -radix unsigned /serializer_TB/DUT/count_end
add wave -noupdate /serializer_TB/DUT/new_word_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1562 fs} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {5355 fs}
