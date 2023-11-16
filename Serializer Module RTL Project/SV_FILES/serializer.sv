

// serializer.sv

// Takes the word created by allocate.sv (word_a) and serializes it, outputing
// 7 bits every clock cycle while setting valid_out high. Sets the first_value 
// and last_value flag to signal the first/last value in a packet. Also,
// outputs the current count (value_counter), counter end condition (count_end), and
// declares when a valid word has arrived (new_word_s) for the input stall in data_unpack.sv
 
module serializer 
	#(
	WORD_WIDTH = 32, 
	DATA_WIDTH = 7
	) 
	(
	input wire clk,
	input wire rst,
	
	input logic new_word_a, 		// high when word_a is a valid input
	input logic first_word_a, 		// high when word_a is a valid input and its the first in the packet
	input logic last_word_a, 		// high when word_a is a valid input and its the last in the packet
	input logic [5:0] num_values_a, // the number of values in word_a 
	input logic [(WORD_WIDTH + DATA_WIDTH - 2):0] word_a,  	// data input, valid when new_word_a is high
	input logic packet_in_progress, // high when when a packet is being processed by the state machine in allocate.sv
	
	output logic valid_out,				// high when data_out is valid 
	output logic [(DATA_WIDTH - 1):0] data_out,		// output data, serialized version of word_a 
	output logic first_value,			// high when data_out is the first in a packet 
	output logic last_value,			// high when data_out is the last in a packet
	output logic [5:0] value_counter,	// the counter tracking the number of values read from an accepted word
	output logic [5:0] count_end,		// the ctop condition of the counter, either 4 or 5 depending on 
										// the FSM in allocate.sv
	output logic new_word_s				// high when a valid wowrd has reached serializer.sv, used in 
										// the input stall in data_unpack.sv 
	);


//========================================
//SIGNAL DECLARATIONS
//========================================

	logic [(WORD_WIDTH + DATA_WIDTH - 2):0] temp_word;
	logic accept_word;
	
	// first/last value flags are set high when the 
	// current word holds the first/last value in a packet
	logic last_value_flag, first_value_flag;
	
//========================================
//BEGIN
//========================================
	
	
	assign accept_word = (new_word_a && packet_in_progress);
	
	
	// new_word_s is used to stall ready_out, preventing 
	// data loss
	always_ff @(posedge clk) begin
		if (rst) new_word_s <= 1'b0;
		else new_word_s <= new_word_a;
	end
	

	//
	always_ff @(posedge clk) begin
	
		if (rst) begin
			value_counter <= 5'b11111;
			count_end <= 5'b0;
			temp_word <= '0;
			valid_out <= 1'b0;
			first_value_flag <= 1'b0;
			last_value_flag <= 1'b0;
		end
		
		
		// If the word is accepted, the counter is reset and 
		// word_a is stored in temp_word. first/last_value_flag
		// is set high when the accepted word is the first/last 
		// in the packet
		else if (accept_word) begin
			count_end <= num_values_a;
			value_counter <= 5'b0;
			temp_word <= word_a;
			valid_out <= 1'b1;
			
			last_value_flag <= last_word_a;
			first_value_flag <= first_word_a;

		end
		
		
		// While the value_counter is less than count_end, temp_word
		// is right shifted by 7-bits, and the count is incremented. 
		// data_out is continuously assigned to temp_word[6:0]. 
		else if (value_counter < count_end) begin
	
			if (value_counter == (count_end - 1)) begin
				valid_out <= 1'b0;
				last_value_flag <= 1'b0;
				first_value_flag <= 1'b0;
			end
			
			else begin
				valid_out <= valid_out;
				last_value_flag <= last_value_flag;
				first_value_flag <= first_value_flag;
			end
			
			
			temp_word <= (temp_word >> DATA_WIDTH);
			value_counter++;
			
		end
		
		else begin
			value_counter <= value_counter;
			count_end <= count_end;
			temp_word <= temp_word;
			valid_out <= valid_out;
			first_value_flag <= first_value_flag;
			last_value_flag <= last_value_flag;
		
		end
		
	end
	
	
	assign data_out = temp_word[(DATA_WIDTH - 1):0];
	
	// last_value is set high when the word has the last_value and the 
	// value counter is one cycle away from completion
	assign last_value = (last_value_flag) && (value_counter == (count_end - 1));
	
	// first_value is set high when the word has the first_value and the 
	// value counter is zero
	assign first_value = (first_value_flag) && (value_counter == '0);
	

//========================================
//END
//========================================
endmodule
