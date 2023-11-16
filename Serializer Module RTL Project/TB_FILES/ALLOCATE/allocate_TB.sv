

module allocate_TB ();
	// inputs
	logic clk, rst, first_word_r, last_word_r, new_word_r, sop_in;
	logic [31:0] word_r;
	
	//outputs
	logic first_word_a, last_word_a, new_word_a, packet_in_progress; 
	logic [37:0] word_a;
	logic [5:0] num_values_a;


	allocate DUT (.clk, .rst, .first_word_r, .last_word_r, .new_word_r,
				  .word_r, .sop_in, .first_word_a, .last_word_a, 
				  .new_word_a, .word_a, .num_values_a, .packet_in_progress);
	
	parameter CLOCK_PERIOD =100;
	initial clk = 1;
	
	always begin 
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	
	initial begin
		/* 
		$readmemh("DP.tv", testvectors);
		
		for(int i = 0; i < 20; i++) begin
			{rst, read_word, last_word, num_carry_bits, num_values, word} = testvectors[i]; @(posedge clk);
		
		end
		*/
		
		// Tests two four-word packets being processed by allocate.sv
		
		rst <= 1; word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
		rst <= 0; sop_in <= 1; @(posedge clk);
		sop_in <= 0; word_r <= 'hF00CC05A; first_word_r <= 1; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
		          word_r <= 'h7D000007; first_word_r <= 0; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
				  word_r <= 'h00000020; first_word_r <= 0; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
				  word_r <= 'hFE000000; first_word_r <= 0; last_word_r <= 1; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
																					repeat(1) @(posedge clk);
																					
		sop_in <= 1; @(posedge clk);
		sop_in <= 0; word_r <= 'hF00CC05A; first_word_r <= 1; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
		          word_r <= 'h7D000007; first_word_r <= 0; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
				  word_r <= 'h00000020; first_word_r <= 0; last_word_r <= 0; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
				  word_r <= 'hFE000000; first_word_r <= 0; last_word_r <= 1; new_word_r <= 1; @(posedge clk);
				  word_r <= 'h11111111; first_word_r <= 0; last_word_r <= 0; new_word_r <= 0; @(posedge clk);
																					repeat(1) @(posedge clk);
		
		$stop;
	end
	
endmodule