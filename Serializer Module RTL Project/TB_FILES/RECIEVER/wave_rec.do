onerror {resume}
radix define FSM {
    "3'd7" "WAIT" -color "white",
    "3'd4" "FOUR" -color "white",
    "3'd1" "ONE" -color "white",
    "3'd5" "FIVE" -color "white",
    "3'd2" "TWO" -color "white",
    "3'd6" "SIX" -color "white",
    "3'd3" "THREE" -color "white",
    "3'd0" "ZERO" -color "white",
    -default binary
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Cyan -radix binary /reciever_TB/DUT/clk
add wave -noupdate -color Cyan -radix binary /reciever_TB/DUT/valid_in
add wave -noupdate -color Cyan -radix binary /reciever_TB/DUT/ready_out
add wave -noupdate -color Cyan -radix hexadecimal /reciever_TB/DUT/data_in
add wave -noupdate /reciever_TB/DUT/new_word
add wave -noupdate -color Gold /reciever_TB/DUT/new_word_r
add wave -noupdate -color Gold -radix hexadecimal /reciever_TB/DUT/word_r
add wave -noupdate -color Cyan -radix binary /reciever_TB/DUT/sop_in
add wave -noupdate -color Gold /reciever_TB/DUT/first_word_r
add wave -noupdate -color Cyan -radix binary /reciever_TB/DUT/eop_in
add wave -noupdate -color Gold /reciever_TB/DUT/last_word_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 110
configure wave -valuecolwidth 60
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
WaveRestoreZoom {0 fs} {3465 fs}
