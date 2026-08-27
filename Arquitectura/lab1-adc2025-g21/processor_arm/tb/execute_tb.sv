`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 03:08:11 PM
// Design Name: 
// Module Name: execute_tb
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


module execute_tb();
    logic AluSrc;
    logic [3:0] AluControl;
    logic [63:0] PC_E;
    logic [5:0] shamt;
    logic [63:0] signImm_E;
    logic [63:0] readData1_E;
    logic [63:0] readData2_E;
    logic [63:0] PCBranch_E;
    logic [63:0] aluResult_E;
    logic [63:0] writeData_E;
    logic zero_E;

    execute dut (
        .AluSrc(AluSrc),
        .shamt(shamt),
        .AluControl(AluControl),
        .PC_E(PC_E),
        .signImm_E(signImm_E),
        .readData1_E(readData1_E),
        .readData2_E(readData2_E),
        .PCBranch_E(PCBranch_E),
        .aluResult_E(aluResult_E),
        .writeData_E(writeData_E),
        .zero_E(zero_E)
    );

    initial begin
        AluControl = 4'b1000;
        shamt = 6'b000010;
        PC_E = 64'h0000000000001000;
        signImm_E = 64'h0000000000000004;
        readData1_E = 64'h00000000000000FF;  
        readData2_E = 64'h0000000000000000;
        AluSrc = 0;
        #10;
        
        shamt = 6'b000100;
        AluControl = 4'b1000;
        #10;
        shamt = 6'b001000;
        AluControl = 4'b1000;
        #10;
        shamt = 6'b000100;
        AluControl = 4'b1001;  
        #10;
        $finish;
    end     
endmodule
