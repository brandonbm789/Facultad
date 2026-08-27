`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 04:34:38 PM
// Design Name: 
// Module Name: alu
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


module alu #(parameter N = 64) (
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic [3:0] ALUControl,
    input logic [5:0] shamt,
    output logic [N-1:0] result,
    output logic zero
    );
    
    always_comb begin 
        case (ALUControl)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b; 
            4'b0111: result = b;
            4'b1000: result = a << shamt;   //LSL
            4'b1001: result = a >> shamt;   //LSR
            default: result = N-1'b0;
        endcase
    end
    
    assign zero = (result == 0);
 
endmodule
