`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 04:43:14 PM
// Design Name: 
// Module Name: signext_tb
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


module signext_tb();
    logic [31:0] a;
    logic [63:0] y;

    signext dut(.a(a),.y(y));

    initial begin
        a = 32'b11111000010_111111111_10_00110_11100;#20;   //LDUR X28, [X6, #-1]
        assert(y == 64'hFFFF_FFFF_FFFF_FFFF);
        a = 32'b11111000010_100000000_10_00110_11100;#20;   //LDUR X28, [X6, #-256]
        assert(y == 64'hFFFF_FFFF_FFFF_FF00);
        a = 32'b11111000010_000101010_10_00110_11100;#20;   //LDUR X28, [X6, #42]
        assert(y == 64'h0000_0000_0000_002A);
        a = 32'b11111000000_101010101_10_00110_11100;#20;   //STUR X28, [X6, #-171]
        assert(y == 64'hFFFF_FFFF_FFFF_FF55);
        a = 32'b11111000000_010101010_10_00110_11100;#20;   //STUR X28, [X6, #170]
        assert(y == 64'h0000_0000_0000_00AA);
        a = 32'b10110100_1111111111000110101_11100;#20;     //CBZ X28 -459
        assert(y == 64'hFFFF_FFFF_FFFF_FE35);
        a = 32'b10110100_0001010101000110011_11100;#20;     //CBZ X28 43571
        assert(y == 64'h0000_0000_0000_AA33);
    
        $finish;
    end
endmodule
