
module serializer_TB ();
	
	logic rst, clk, new_word_a, first_word_a, last_word_a, packet_in_progress;
	logic [2:0] num_values_a;
	logic [37:0] word_a;
	
	//outputs
	logic valid_out, first_value, last_value, new_word_s;
	logic [2:0] count_end, value_counter;
	logic [6:0] data_out;
	
	serializer DUT (.*);

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
			
			rst <= 1; new_word_a <= 0; first_word_a <= 0; last_word_a <= 0; 
					  num_values_a <= 7; word_a <= 'h11111111; @(posedge clk);
					  
			rst <= 0; 
			packet_in_progress <= 1; first_word_a <= 1; num_values_a <= 4; word_a <='hF00CC05A; new_word_a <= 1; @(posedge clk);
			first_word_a <= 0; num_values_a <= 0; word_a <='h11111111; new_word_a <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			num_values_a <= 5; word_a <= {2'b00, 32'h7D000007, 4'hF};  new_word_a <= 1; @(posedge clk);
			num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			num_values_a <= 4; word_a <= {5'd0, 32'h00000020, 1'b0};  new_word_a <= 1; @(posedge clk);
			num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			last_word_a <= 1'b1; num_values_a <= 5; word_a <= {1'd0, 32'hABCDEF98, 5'd0};  new_word_a <= 1; @(posedge clk);
			last_word_a <= 1'b0; num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			packet_in_progress <= 0; repeat(5) @(posedge clk);
			
			packet_in_progress <= 1; first_word_a <= 1; num_values_a <= 4; word_a <='hF00CC05A; new_word_a <= 1; @(posedge clk);
			first_word_a <= 0; num_values_a <= 0; word_a <='h11111111; new_word_a <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			num_values_a <= 5; word_a <= {2'b00, 32'h7D000007, 4'hF};  new_word_a <= 1; @(posedge clk);
			num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(3) @(posedge clk);
			num_values_a <= 4; word_a <= {5'd0, 32'h00000020, 1'b0};  new_word_a <= 1; @(posedge clk);
			num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(2) @(posedge clk);
			last_word_a <= 1'b1; num_values_a <= 5; word_a <= {1'd0, 32'hABCDEF98, 5'd0};  new_word_a <= 1; @(posedge clk);
			 last_word_a <= 1'b0; num_values_a <= 0; word_a <= 'h11111111;  new_word_a <= 0; @(posedge clk);
			repeat(5) @(posedge clk);
			packet_in_progress <= 0; repeat(5) @(posedge clk);
			
			$stop;
		end
		
endmodule