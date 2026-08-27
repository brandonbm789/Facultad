`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 10:35:42 AM
// Design Name: 
// Module Name: regfile_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile_tb();
    
    logic clk,we3;
    logic [4:0] ra1,ra2,wa3;
    logic [63:0] rd1,rd2,wd3;

    regfile dut(.clk(clk),.we3(we3),.ra1(ra1),.ra2(ra2),.wa3(wa3),.rd1(rd1),.rd2(rd2),.wd3(wd3));

    always begin
		clk = 1;#10; clk=0;#10;
    end

	initial begin
		// No se registro con lo del WB
		// we3 = 0;
		// ra1 = 0;
		// ra2 = 0;
		// wa3 = 0;
		// wd3 = 64'hCAFE_C0CA_CAFE_C0CA;
		// #25;
		// Si se escribe wd3 en el registro X5 con lo del WB
		// wa3 = 5;
		// wd3 = 64'hC0CA_CAFE_C0CA_CAFE;
		// we3 = 1;
		// #25;
		// Rapidin test de todas las guardas
		// we3 = 0;
		// wa3 = 1;
		// ra1 = 1;
		// #10;
		// we3 = 1;
		// #10;
		// we3 = 0;
		// wa3 = 2;
		// ra2 = 2;
		// #10;
		// we3 = 1;
		// #10;
		
		// Tira chiche
		// Test mas completo que el de arriba
		// Cuando j es par => wa3 = ra1. Si j es impar => wa3 = ra2. Y el we3 cambia solo cuando j es par.
		// En un principio we3 == 1 => entonces primer ciclo va a ser 0.
		we3 = 1;
		wd3 = 64'hC0CA_CAFE_C0CA_CAFE;

		for(int j=0; j<31; j=j+1) begin
			wa3 = j;
			if (j%2 == 0) begin
			    ra1 = j; 
                assign we3 = (~we3);
			end else begin
			    ra2 = j;
			end
			#10;
		end
		$finish;
	end
endmodule
