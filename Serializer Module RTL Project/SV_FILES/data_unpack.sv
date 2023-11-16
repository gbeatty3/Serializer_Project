

// RTL Design Project

//
// Input interface:
// ================
// ready_out Output; Set ready_out to true when there is room to accept a new word, else false.
// valid_in Input; When true AND ready_out is true, a word is deemed received by this module
// data_in[31:0] Input; LSB-aligned 32-bit data word
// sop_in Input; True when this is the first data word for a packet
// eop_in Input; True when this is the last data word for a packet
//
// Output interface:
// =================
// valid_out Output; True for each cycle where a value is presented
// data_out Output; Output value, only valid when valid_out == 1
// sop_out Output; Present along with the first valid value for a packet
// eop_out Output; Present along with the last valid value for a packet
//
// Requirements:
// =============
// 1) Values extracted from data_in are LSB-first.
// 2) Valid Packets start with start of packet (sop_in) flag and end with an end of packet flag (eop_in).
// Values received after an eop_in but before sop_in should be discarded.
// 3) When eop_in is received, residual state should be cleared after the last output value is presented
// so the next packet can be processed cleanly.
// 4) The general use case would be expected to have a packet length which is a multiple of 7-bit output
// words. The upper bits of the last sample should be zeroed out if the packet is not a multiple of
// 7-bit words.
// 5) If valid data is ready at the input there must be a continuous stream of output values (no gaps).
// Some latency between the first word in and the first value out is to be expected.
// 6) If the Input stream is sending data, minimize the # of dead cycles (ideally 0) between packets
// on the output.
//
// Example:
// ========
//   sop_in  eop_in 	    		 value_in 						 	  data_out 	 sop_out eop_out
// 0:  1       0      32'b1111_0000_0000_1100_1100_0000_0101_1010
// 																		7'b101_1010 	1 		0
// 																		7'b000_0000     0 		0
//																		7'b011_0011 	0 		0
//																		7'b000_0000 	0 		0
// 1:  0       0      32'b0111_1101_0000_0000_0000_0000_0000_0111
//																		7'b111_1111 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b111_1101 	0 		0
// 2:  0       0      32'b0000_0000_0000_0000_0000_0000_0010_0000
//																		7'b100_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
// ..... ..... ..... ..... ..... ..... ..... ..... .....
// 6:  0       1     32'b1111_1110_0000_0000_0000_0000_0000_0000
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b000_0000 	0 		0
//																		7'b111_1111 	0 		1
//


// Top Level Module

// 32-bit to 7-bit serializer, requirements stated above 
module data_unpack
	#(
	WORD_WIDTH = 32, 
	DATA_WIDTH = 7
	) 
	(
	 input wire clk,
	 input wire rst,

	 output logic ready_out, 		// Used to backpressue the initiating module
	 input wire valid_in, 		    // high when data_in is valid
	 input wire [31:0] data_in, 	// input data
	 input wire sop_in, 			// high when data_in is the first word in a packet
	 input wire eop_in, 			// high when data_in is the last word in a packet

	 output logic valid_out,		// high when data_out is valid 
	 output logic [6:0] data_out,	// serialized output data 
	 output logic sop_out,			// high when data_out is the first value in a packet 
	 output logic eop_out			// high when data_out is the last value in a packet 
	);
	
	

//========================================
//SIGNAL DECLARATIONS
//========================================


	//// DATA_UNPACK ////
	logic counter_stall;
	
	//// RECIEVER ////
	logic stall_input;
	logic first_word_r, last_word_r, new_word_r;
	logic [(WORD_WIDTH - 1):0] word_r;
	

	
	//// ALLOCATE ////
	logic first_word_a, last_word_a, new_word_a;
	logic [(WORD_WIDTH + DATA_WIDTH - 2):0] word_a;
	logic[5:0]  num_values_a;
	logic [5:0] carry_bits_a;
	logic packet_in_progress;
	
	
	//// SERIALIZER ////
	logic first_value, last_value, new_word_s;
	logic [5:0] value_counter, count_end;
	
	//// STALL LOGIC ////
	integer min_num_values, max_num_values;
	
//========================================
//MODULE INSTANTIATIONS
//========================================	
	
	// RECIEVER.SV: Manages the ready-then-valid interface

	//output first_word_r : high when word_r is the first word in a packet 
	//output last_word_r : high when word_r is the last word in a packet 
	//output [31:0] word_r
	//output new_word_r : high when word_r has been accepted as an input
	
	reciever #(.WORD_WIDTH(WORD_WIDTH)) 
				recieve_inputs (.clk, .rst, .valid_in, .data_in, .sop_in, .eop_in, .ready_out,
								.first_word_r, .last_word_r, .word_r, .new_word_r);
	
	
	// ALLOCATE.SV : Determines the number of values in a packet, saves
	//				 carry-over bits for the next word. 
	
	//output first_word_a : high when word_a is the first word in a packet 
	//output last_word_a : high when word_a is the last word in a packet 
	//output new_word_a : high when word_a has been accepted as an input
	//output [37:0] word_a
	//output [2:0] num_values_a : the number of values in word_a
	//output packet_in_progress : high when a packet is being processed
	
	allocate #(.WORD_WIDTH(WORD_WIDTH), .DATA_WIDTH(DATA_WIDTH)) 
				assign_word_type (.clk, .rst, .first_word_r, .last_word_r, .word_r, .new_word_r, .sop_in,
							      .first_word_a, .last_word_a, .new_word_a, .word_a, .num_values_a, .packet_in_progress);
	
	
	
	// SERIALIZER.SV : serializes word_a into 7-bit values, sets output flags
	//				   high the first and last value are output.
	
	//output logic valid_out : high when data_out is valid
	//output logic [6:0] data_out : serialized output data
	//output logic first_value : high when data_out is the first value output 
	//							 in a packet
	//output logic last_value : high when data_out is the last value output 
	//							in a packet
	//output logic [2:0] value_counter : count of the number of values read
	//									 from the current word
	//output logic [2:0] count_end : the number of values in the current word,
	//								 marks the end of the counter
	//output logic new_word_s : high for the first cycle of the counter when
	//							the current word is a valid input.
	
	serializer #(.WORD_WIDTH(WORD_WIDTH), .DATA_WIDTH(DATA_WIDTH)) 
					serialize_output (.clk, .rst, .new_word_a, .first_word_a, .last_word_a, .num_values_a, .word_a, .packet_in_progress,
									  .valid_out, .data_out, .first_value, .last_value, .value_counter, .count_end, .new_word_s);
	
//========================================
//BEGIN
//========================================


	// first/last_value are output from serializer.sv and diresctly assigned to sop/eop_out
	assign sop_out = first_value;
	assign eop_out = last_value;


	assign min_num_values = WORD_WIDTH / DATA_WIDTH;
	assign max_num_values = min_num_values + 1;


	// Input stall logic. Based on if a word is in the pipeline (new_word_r, 
	// new_word_a, new_word_s) and extends the stall by one cycle if the word
	// has 5 values.
	assign counter_stall = (count_end == min_num_values) ? (1'b0) : (value_counter < (max_num_values - 3));
	assign stall_input = (new_word_r || new_word_a || new_word_s || counter_stall);
	assign ready_out = !stall_input;



//========================================
//END
//========================================


endmodule

