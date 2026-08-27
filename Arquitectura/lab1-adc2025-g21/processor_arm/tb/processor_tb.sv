// Testbench ProcessorPatterson
// Top-level Entity: processor_arm

module processor_tb();

	logic [15:0] i_sw;
	logic i_mclk;
	logic i_reset, dump;
	logic [15:0] o_led;

  	processor_arm  dut ( .i_sw(i_sw),
  	                     .i_mclk(i_mclk),
  	                     .i_reset(i_reset),
  	                     .dump(dump),
  	                     .o_led(o_led) );

  	// generate clock
  	always
    	begin
      		#10 i_mclk = ~i_mclk;
    	end

    initial
        begin
            dump = 0;
            i_mclk = 0; i_reset = 1; i_sw = 1;
            #20; i_reset = 0;
			#7900 dump = 1;	// dump mem values on file mem.dump
			#20; $stop;
		end
endmodule 
