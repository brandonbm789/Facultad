`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 05:15:58 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    logic [63:0] a;
    logic [63:0] b;
    logic [5:0] shamt;
    logic [3:0] ALUControl;
    logic [63:0] result;
    logic zero;
    
    alu dut(.a(a), .b(b), .shamt(shamt), .ALUControl(ALUControl), .result(result), .zero(zero));
    
    initial begin   // Dos Pos, Neg y Pos, Pos y Neg, Neg y Neg
        // AND
        a = 'b10101;            b = 'b11000;            ALUControl = 4'b0000;   #10;    //result = 10000 BIN
        a = 'hFFFFFFFFFFFFFFFD; b = 'h1;                ALUControl = 4'b0000;   #10;    //result = 1 HEX
        a = 'h3;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0000;   #10;    //result = 3 HEX
        a = 'hFFFFFFFFFFFFFFFD; b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0000;   #10;    //result = F..FD HEX
        // OR
        a = 'b10101;            b = 'b11000;            ALUControl = 4'b0001;   #10;    //result = 11101 BIN
        a = 'hFFFFFFFFFFFFFFFE; b = 'h1;                ALUControl = 4'b0001;   #10;    //result = F..F HEX
        a = 'h2;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0001;   #10;    //result = F..F HEX
        a = 'hFFFFFFFFFFFFFFFE; b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0001;   #10;    //result = F..F HEX
        // add(a+b)
        a = 'h123;              b = 'h987;              ALUControl = 4'b0010;   #10;    //result = AAA HEX
        a = 'hFFFFFFFFFFFFFFFE; b = 'h1;                ALUControl = 4'b0010;   #10;    //result = F..F HEX
        a = 'h2;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0010;   #10;    //result = 1 HEX    OVERFLOW
        a = 'hFFFFFFFFFFFFFFFE; b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0010;   #10;    //result = F..FD HEX OVERFLOW
        // sub(a-b)
        a = 'h555;              b = 'h222;              ALUControl = 4'b0110;   #10;    //result = 333 HEX
        a = 'hFFFFFFFFFFFFFFFD; b = 'h1;                ALUControl = 4'b0110;   #10;    //result = F..FC HEX
        a = 'h3;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0110;   #10;    //result = 4 HEX    OVERFLOW 
        a = 'hFFFFFFFFFFFFFFFF; b = 'hFFFFFFFFFFFFFFFD; ALUControl = 4'b0110;   #10;    //result = 2 HEX
        // pass input b
        a = 'h666;              b = 'h420;              ALUControl = 4'b0111;   #10;    //result = 420 HEX
        a = 'hFFFFFFFFFFFFFFFD; b = 'h1;                ALUControl = 4'b0111;   #10;    //result = 1 HEX
        a = 'h3;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0111;   #10;    //result = F..F HEX
        a = 'hFFFFFFFFFFFFFFFD; b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0111;   #10;    //result = F..F HEX
        // lsl a << shamt
        a = 'h01;               shamt = 'b1;            ALUControl = 4'b1000;   #10;    //result = 10 BIN
        a = 'hFFFFFFFFFFFFFFFF; shamt = 'b1;            ALUControl = 4'b1000;   #10;    //result = FFFFFFFFFFFFFFFE HEX
        // lsr a >> shamt
        a = 'h02;               shamt = 'b1;            ALUControl = 4'b1001;   #10;    //result = 1 BIN
        a = 'h0;                shamt = 'b1;            ALUControl = 4'b1001;   #10;    //result = 0 BIN
        // Todo pero en zero
        a = 'b0;                b = 'b1;                ALUControl = 4'b0000;   #10;    //result = 0 BIN y zero = 1
        a = 'b0;                b = 'b0;                ALUControl = 4'b0001;   #10;    //result = 0 BIN y zero = 1
        a = 'b1;                b = 'hFFFFFFFFFFFFFFFF; ALUControl = 4'b0010;   #10;    //result = 0 BIN y zero = 1
        a = 'b1;                b = 'b1;                ALUControl = 4'b0110;   #10;    //result = 0 BIN y zero = 1
        a = 'b0;                b = 'b0;                ALUControl = 4'b0111;   #10;    //result = 0 BIN y zero = 1
        // Caso default alu
        a = 'b0;                b = 'b1;                ALUControl = 4'b1000;   #10;    //result = b1ac7acc21 (BlakJack 21)
        
        $finish;
    end
endmodule
