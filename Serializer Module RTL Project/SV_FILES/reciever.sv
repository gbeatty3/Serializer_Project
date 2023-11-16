

// reciever.sv

// Handles the ready/valid interface with the initiating module
module reciever 
	#(
	WORD_WIDTH = 32 
	) 
	(
	input wire clk,
	input wire rst,

	input wire valid_in,  		// high when data_in is valid
	input wire [(WORD_WIDTH - 1):0] data_in,  // input data
	input wire sop_in, 			// high when data_in is the first word in a packet
	input wire eop_in, 			// high when data_in is the last word in a packet
	input logic ready_out, 		// Used to backpressue the initiating module

	output logic first_word_r,	// high when a valid word is accepted and its the first in the packet
	output logic last_word_r,   // high when a valid word is accepted and its the last in the packet
	output logic [(WORD_WIDTH - 1):0] word_r, // input data passed on to allocate.sv, valid when new_word_r is high
	output logic new_word_r     // high when valid_in and ready_out are high, word_r is valid
	);

//========================================
//SIGNAL DECLARATIONS
//========================================

	logic new_word;
	
//========================================
//BEGIN
//========================================	

	assign new_word	= (valid_in && ready_out);
	

	
	always_ff @(posedge clk) begin

		first_word_r <= sop_in && new_word;
		last_word_r <= eop_in && new_word;
		
	end 
	
	
	always_ff @(posedge clk) begin
		if (rst) begin
			word_r <= '0;
			new_word_r <= 1'b0;
		end
		
		else if (new_word) begin
			word_r <= data_in;
		end
		
		new_word_r <= new_word;

	end
	
//========================================
//END
//========================================

endmodule