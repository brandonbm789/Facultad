`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 06:01:53 PM
// Design Name: 
// Module Name: imem_tb
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


module imem_tb();
    logic [6:0] addr;
    logic [31:0] q;

    imem dut(.addr(addr), .q(q));
    
    initial begin
        for (int i = 0; i < 51; i++) begin
            addr = i; #10;
        end

        $finish;
    end 
endmodule
