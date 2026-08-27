// 3:1 MULTIPLEXER

module mux3 #(parameter N = 64)
				(input logic [N-1:0] d0, d1, d2,
				input logic [1:0] s,
				output logic [N-1:0] y);
	always_comb begin
		case (s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			default: y = 'x; // no importa el 4to caso
		endcase
	end
endmodule