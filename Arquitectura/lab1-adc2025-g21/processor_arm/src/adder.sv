// ADDER

module adder #(parameter N = 64)
					(input logic [N-1:0] in1, in2,
					output logic [N-1:0] out);
					
	assign out = in1 + in2;
	
endmodule
