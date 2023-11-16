
// allocate.sv

// Determines the number of packets in word_r, and 
// appends carry-over bits from the previous word based
// on the state of the FSM
module allocate 
	#(
	WORD_WIDTH = 32, 
	DATA_WIDTH = 7
	) 
	(
	input wire clk,
	input wire rst,
	
	input logic first_word_r,  // high when word_r is a valid word and its the first in the packet
	input logic last_word_r,   // high when word_r is a valid word and its the last in the packet
	input logic [(WORD_WIDTH - 1):0] word_r, // data input, valid when new_word_r is high
	input logic new_word_r,    // high when word_r is a valid input
	input logic sop_in,		   // top level input, high when the next valid word will be the first in a packet
	
	output logic first_word_a,       // high when word_a is a valid word and its the first in the packet
	output logic last_word_a,        // high when word_a is a valid word and its the last in the packet
	output logic new_word_a,         // high when word_a is a valid output
	output logic [(WORD_WIDTH + DATA_WIDTH - 2):0] word_a,      // data output, valid when new_word_a is high, has carry-over bits appended
	output logic [5:0] num_values_a, // the number of values in word_a 
	output logic packet_in_progress  // high when sop_in has gone high, but eop_in has not. when a packet is being
									 // processed by data_unpack
	);
	
//========================================
//SIGNAL DECLARATIONS
//========================================
	
	logic [(WORD_WIDTH + DATA_WIDTH) - 2 : 0] extended_word;
	logic [5:0] num_carry_bits;
	logic [(DATA_WIDTH - 2) : 0] carry_bits;
	integer count;
	
	typedef enum logic {STANDBY = 1'b0, SERIAL = 1'b1} state;
	
	state packet_recieved;
		
//========================================
//BEGIN
//========================================

 
	// Pipeline Register, stores outputs in registers
	// to pass to serializer.sv
	always_ff @(posedge clk) begin
	
		if(rst) begin
			first_word_a <= 1'b0;
			last_word_a <= 1'b0;
			new_word_a <= 1'b0;
			word_a <= 0;
			carry_bits <= 0;
		end
		
		else if (new_word_r) begin
			word_a <= extended_word;			
			carry_bits <= word_r[(WORD_WIDTH - 1): (WORD_WIDTH - DATA_WIDTH + 1)];
		end
		
		first_word_a <= first_word_r;
		last_word_a <= last_word_r;
		new_word_a <= new_word_r;

	end
	
	
	
	always_comb begin
	   if (num_carry_bits == 0) begin
	       extended_word = {'0, word_r};
	   end
	   
	   else begin
	       extended_word = {word_r, carry_bits} >> (DATA_WIDTH - num_carry_bits - 1);
	   end
	end
	   
	   
	   
	always_ff @(posedge clk) begin
		if (rst | last_word_a) begin
			num_carry_bits <= 0;
			num_values_a <= WORD_WIDTH / DATA_WIDTH;
			count <= WORD_WIDTH;
		end
		
		else if (new_word_r) begin
			num_carry_bits <= (count + num_carry_bits) % DATA_WIDTH;
			num_values_a <= (count + num_carry_bits) / DATA_WIDTH;
		end
		
	end
	

	// FSM that keeps track of the number of carry bits appended from the 
	// previous word, and the number of values in the word. 
	always_ff @(posedge clk) begin

		if (rst) begin
			packet_recieved <= STANDBY;
		end


		else begin
			case (packet_recieved)
			
				STANDBY : begin
					if (sop_in) packet_recieved <= SERIAL;
					else packet_recieved <= STANDBY;
				end
				
				SERIAL : begin
					if (last_word_a) packet_recieved <= STANDBY;
					else packet_recieved <= SERIAL;
				end
				
			endcase
		end
	
	end
	
	assign packet_in_progress = packet_recieved;
	
//========================================
//END
//========================================
endmodule