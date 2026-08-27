`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 10:17:25 AM
// Design Name: 
// Module Name: flopr
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

module flopre #(parameter N = 64)  (
    input logic clk,
    input logic reset,
    input logic [N-1:0] d,
    input logic en,
    output logic [N-1:0] q
    );
    
	always_ff @(posedge clk, posedge reset)
	   if (reset) q <= '0; //{bus{1'b0}}
	   else if (en) q <= d;

endmodule
