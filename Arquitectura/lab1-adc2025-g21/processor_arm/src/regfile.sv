`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 06:39:13 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input logic clk,
    input logic we3,
    input logic [4:0] ra1,
    input logic [4:0] ra2,
    input logic [4:0] wa3,
    input logic [63:0] wd3,
    output logic [63:0] rd1,
    output logic [63:0] rd2
    );

    // Registro[31] es el XZR entonces es todo cero's
    logic [63:0] registers[31:0];
    initial begin
        for (int i = 0 ; i<31 ; i=i+1)begin
        registers[i] = i;
        end
        registers[31] = 64'b0;
    end

    // Se escribe el registro con lo que viene del WB
    always_ff @(posedge clk)
        if(we3 && (wa3 != 5'b11111)) registers[wa3] <= wd3;

    always_comb  begin
        // caso rd1: ra1 == wa3 y se debe escribir
        if ((ra1 == wa3) && we3 && (ra1 != 5'b11111)) begin
            rd1 = wd3;
        end else begin
            rd1 = (ra1 == 5'b11111) ? 64'b0 : registers[ra1];
        end

        // caso rd2: ra2 == wa3 y se debe escribir
        if ((ra2 == wa3) && we3 && (ra2 != 5'b11111)) begin
            rd2 = wd3;
        end else begin
            rd2 = (ra2 == 5'b11111) ? 64'b0 : registers[ra2];
        end
    end
endmodule
