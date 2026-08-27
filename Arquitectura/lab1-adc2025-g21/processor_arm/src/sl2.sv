// SHIFT LEFT 2

module sl2 #(parameter N = 64)
				(input logic [N-1:0] a,					
				output logic [N-1:0] y);

	always_comb begin
	   y = a << 2;
	end
	
endmodule