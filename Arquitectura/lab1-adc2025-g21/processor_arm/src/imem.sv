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
    input [7:0] addr,   // 2^8 = 256
    output [N-1:0] q
    );
    
    logic [N-1:0] ROM [0:255];  // original de 64b, extension a 256b
    initial begin 
    ROM [0:36] ='{32'hd37f3c3d,
32'h8b0803bc,
32'h8b1f003b,
32'hf840039e,
32'h8a1b03cb,
32'hd37f077b,
32'hcb010165,
32'hb4000105,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4ffff1f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f01fa,
32'hf80003ba,
32'hd37f135a,
32'hf80003ba,
32'hd37f135a,
32'hf80003ba,
32'hd37f135a,
32'hf80003ba,
32'hd35f135a,
32'hf80003ba,
32'hd35f135a,
32'hf80003ba,
32'hd35f135a,
32'hf80003ba,
32'hb4fff97f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff};

        for (int i = 255; i > 36; i--) begin
            ROM[i] = 32'b0; 
        end
    end

assign q = ROM[addr];

endmodule
