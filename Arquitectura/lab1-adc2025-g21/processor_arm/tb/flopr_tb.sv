`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 10:26:54 AM
// Design Name: 
// Module Name: flopr_tb
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


module flopr_tb();
    logic clk;
    logic reset;
    logic [63:0] q_64;
    logic [63:0] d_64;
    logic [31:0] q_32;
    logic [31:0] d_32;
    
    flopr dut(.clk(clk), .reset(reset), .d(d_64), .q(q_64));
    flopr #(32) dut2 (.clk(clk), .reset(reset), .d(d_32), .q(q_32));

    initial begin   //Solo debe pasar a q con reset en bajo y clock en alto.
        reset = 1;  d_64 = 5;    clk= 0; #10;
        reset = 1;  d_64 = 50;   clk= 1; #10;
        reset = 1;  d_64 = 500;  clk= 0; #10;
        reset = 1;  d_64 = 100;  clk= 1; #10;
        reset = 1;  d_64 = 900;  clk= 0; #10;
        reset = 0;  d_64 = 7;    clk= 1; #10;
        reset = 0;  d_64 = 13;   clk= 0; #10;
        reset = 0;  d_64 = 63;   clk= 1; #10;
        reset = 0;  d_64 = 96;   clk= 0; #10;
        reset = 0;  d_64 = 58;   clk= 1; #10;
        
        reset = 1;  d_32 = 32'h80000000;    clk= 0; #10;
        reset = 1;  d_32 = 32'hF12345;      clk= 1; #10;
        reset = 1;  d_32 = 32'hFFAA;        clk= 0; #10;
        reset = 1;  d_32 = 32'h10101010;    clk= 1; #10;
        reset = 1;  d_32 = 32'h23412312;    clk= 0; #10;
        reset = 0;  d_32 = 32'h56565656;    clk= 1; #10;
        reset = 0;  d_32 = 32'h78787878;    clk= 0; #10;
        reset = 0;  d_32 = 32'h19876543;    clk= 1; #10;
        reset = 0;  d_32 = 32'hABCDEFFF;    clk= 0; #10;
        reset = 0;  d_32 = 32'hFFFACBDF;    clk= 1; #10;
        
        $finish;
    end
endmodule
