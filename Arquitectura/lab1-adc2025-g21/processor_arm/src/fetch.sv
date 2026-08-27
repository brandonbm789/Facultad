`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 03:04:35 PM
// Design Name: 
// Module Name: fetch
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


module fetch #(parameter N = 64)(
    input logic PCSrc_F,
    input logic clk,
    input logic reset,
    input logic en,
    input logic [63:0] PCBranch_F,
    output logic [63:0] imem_addr_F
);
    logic [N-1:0] four = 64'd4;
    logic [N-1:0] pc_plus_4;    // PC + 4
    logic [N-1:0] next_pc;      // Próximo valor de PC
    
    // Instancias de los módulos
    adder add (
        .in1(imem_addr_F),
        .in2(four),
        .out(pc_plus_4)
    );
    
    mux2 mux (
        .d0(pc_plus_4),
        .d1(PCBranch_F),
        .s(PCSrc_F),
        .y(next_pc)
    );
    
    flopre #(64) pc_reg (
        .clk(clk),
        .reset(reset),
        .en(en),
        .d(next_pc),
        .q(imem_addr_F)
    );
endmodule
