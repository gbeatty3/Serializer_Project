vlib work

# ALL files relevant to the testbench should be listed here. 
vlog -logfile SER.txt -work work ../../SV_FILES/serializer.sv
vlog -logfile SER_TB.txt -work work ./serializer_TB.sv

# Note that the name of the testbench module is in this statement. If you're running a testbench with a different name CHANGE IT
vsim -t 1fs -novopt serializer_TB

# This is the wave file which stores all signals you're looking at along with their radix and other settings. If you use this feature make sure the name matches
# the saved file, otherwise ignore this.
do wave_serial.do

view signals
view wave

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

run -all