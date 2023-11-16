
module data_unpack_TB ();

	//inputs 
	logic clk, rst, valid_in, sop_in, eop_in;
	logic [31:0] data_in;
	
	//outputs
	logic ready_out, valid_out, sop_out, eop_out;
	logic [6:0] data_out;
	
	data_unpack DUT(.*);
	
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
			rst <= 1; valid_in <= 0; sop_in <= 0; eop_in <= 0; data_in <= 'h11111111; @(posedge clk);
			
			
		//CHECK THAT MODULE IS STABLE WITH NO INPUTS
			// rst <= 0; repeat(10) @(posedge clk);
			rst <= 0;
			repeat (6) @(posedge clk);
			
		/*
		// TWO 3-WORD PACKETS, NO DELAYED INPUT, SLOW
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			
			
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 0; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			
			
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 0; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			repeat(10) @(posedge clk);
		
			*/
			
			
			
			
			
		
		// TWO 3-WORD PACKETS, NO DELAYED INPUT, FAST
													 repeat(5) @(posedge clk);
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; @(posedge clk);
													 repeat(3) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
												  eop_in <= 0; @(posedge clk);
												  	
			
			
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
													 repeat(2) @(posedge clk);
												  sop_in <= 0; @(posedge clk);

			
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 0; @(posedge clk);
													 repeat(4) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
								   valid_in <= 0; eop_in <= 0; @(posedge clk);
													repeat(20) @(posedge clk);
													
			
			
			
			
			
		/*
		// EXAMPLE OF WEIRD SOP_IN BEHAVIOR
													 repeat(5) @(posedge clk);
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 1; @(posedge clk);
													 repeat(3) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; sop_in <= 0; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
												  eop_in <= 0; @(posedge clk);
												  	
			
			
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
													 repeat(2) @(posedge clk);
												  sop_in <= 0; @(posedge clk);

			
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 0; @(posedge clk);
													 repeat(4) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
								   valid_in <= 0; eop_in <= 0; @(posedge clk);
													repeat(20) @(posedge clk);
													
			
			*/
			
			
			
			
			/*
			// EXAMPLE OF WEIRD EOP_IN BEHAVIOR
													 repeat(5) @(posedge clk);
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; eop_in <= 1; @(posedge clk);
													 repeat(3) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
												  eop_in <= 0; @(posedge clk);
												  	
			
			
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
													 repeat(2) @(posedge clk);
												  sop_in <= 0; @(posedge clk);

			
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 0; @(posedge clk);
													 repeat(4) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'h00000020; eop_in <= 1; @(posedge clk);
													 repeat(4) @(posedge clk);
								   valid_in <= 0; eop_in <= 0; @(posedge clk);
													repeat(20) @(posedge clk);
													
			*/
			
			
			
			
			
			
			//TWO 14-WORD PACKETS, UNDELAYED INPUTS, FAST
			/*
			repeat(5) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);

			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h00000020; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hABCDEF98; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h0004000; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h1796697C; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hFE000000; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 1; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hF00CC05A; eop_in <= 0; sop_in <= 1; @(posedge clk);
			repeat(4)@(posedge clk);

			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h00000020; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hABCDEF98; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h0004000; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h1796697C; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hFE000000; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 0; @(posedge clk);
			repeat(4) @(posedge clk);

			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 1; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; eop_in <= 0; @(posedge clk);
			repeat(15) @(posedge clk);
			*/
			
			
			
			
			
			/*
			//TWO 14-WORD PACKETS, DELAYED INPUTS, FAST
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//@(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h00000020; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);

			
			valid_in <= 1; data_in <= 'hABCDEF98; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h0004000; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h1796697C; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hFE000000; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(2) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 1; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			//repeat(15) @(posedge clk);
			
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 1; @(posedge clk);
			repeat(3)@(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//@(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(2) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h00000020; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hABCDEF98; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(2) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h0004000; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h1796697C; sop_in <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(2) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hFE000000; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(2) @(posedge clk);
			
			valid_in <= 1; data_in <= 'hF00CC05A; sop_in <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; sop_in <= 0; @(posedge clk);
			//repeat(1) @(posedge clk);
			
			valid_in <= 1; data_in <= 'h7D000007; eop_in <= 1; @(posedge clk);
			repeat(2) @(posedge clk);
			valid_in <= 0; data_in <= 'h11111111; eop_in <= 0; @(posedge clk);
			repeat(15) @(posedge clk);
			*/
			
			$stop;
		end

endmodule