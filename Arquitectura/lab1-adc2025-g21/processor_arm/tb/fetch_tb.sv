`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 03:59:40 PM
// Design Name: 
// Module Name: fetch_tb
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


module fetch_tb();
    logic clk, PCSrc_F, reset;
    logic [63:0] PCBranch_F, imem_addr_F;
    
    fetch dut (
        .PCSrc_F(PCSrc_F),
        .clk(clk),
        .reset(reset),
        .PCBranch_F(PCBranch_F),
        .imem_addr_F(imem_addr_F)
    );
    
    always begin
        clk = 0; #5; clk = 1; #5;
    end

    initial begin
     
        PCSrc_F = 0;
        reset = 1;
        PCBranch_F = 64'h0000_0000_0000_0100; 
        imem_addr_F = 0;
        #50;
        reset = 0;
        #100;
        PCSrc_F = 1;
        #10;
        #40;
        $finish;
    end
  
endmodule