`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 04:56:11 PM
// Design Name: 
// Module Name: imem
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


module imem #(parameter N = 32)(
    input [5:0] addr,
    output [N-1:0] q
    );
    
    logic [N-1:0] ROM [0:63];
    initial begin 
        ROM [0:12] ='{32'h8b0b03e2,
        32'h8b1f03e4,
        32'h8b1f03e5,
        32'hcb040043,
        32'hb40000e3,
        32'hf8001004,
        32'hf8400006,
        32'h8b0600a5,
        32'h8b080000,
        32'h8b010084,
        32'hb4ffff3f,
        32'hf8000005,
        32'hb400001f};
        for (int i = 63; i > 12; i--) begin
            ROM[i] = 32'b0; 
        end
    end

assign q = ROM[addr];

endmodule
