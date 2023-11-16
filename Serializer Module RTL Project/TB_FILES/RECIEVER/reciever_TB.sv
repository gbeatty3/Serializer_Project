

module reciever_TB ();

	//inputs
	logic clk, rst, valid_in, sop_in, eop_in, ready_out;
	logic [31:0] data_in;
	
	//outputs
	logic first_word_r, last_word_r, new_word_r;
	logic [31:0] word_r;


	reciever DUT (.*);
	
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
		 
		 
		rst <= 1; valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; 
											  eop_in <= 0; ready_out <= 0; @(posedge clk);
																 rst <= 0; @(posedge clk);
														   ready_out <= 1; @(posedge clk);
		valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; 				   @(posedge clk);
														   ready_out <= 0; @(posedge clk);
		valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; 				   @(posedge clk);
		ready_out <= 1; @(posedge clk);
		valid_in <= 1; data_in <= 'h7D000007; 			   ready_out <= 1; @(posedge clk);
														   ready_out <= 0; @(posedge clk);
		valid_in <= 0; data_in <= 'h11111111; 			 				   @(posedge clk);
		ready_out <= 1; @(posedge clk);
		valid_in <= 1; data_in <= 'h00000020; 			   ready_out <= 1; @(posedge clk);
														   ready_out <= 0; @(posedge clk);
		valid_in <= 0; data_in <= 'h11111111; 			 				   @(posedge clk);
		ready_out <= 1; @(posedge clk);
		valid_in <= 1; data_in <= 'hFE000000; eop_in <= 1; ready_out <= 1; @(posedge clk);
														   ready_out <= 0; @(posedge clk);
		valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; 				   @(posedge clk);
															 repeat (15)   @(posedge clk);
	
		$stop;
	end
	
endmodule
	