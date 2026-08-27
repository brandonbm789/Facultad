`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 10:06:52 PM
// Design Name: 
// Module Name: maindec_tb
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


module maindec_tb();
	logic [10:0] Op;
	logic Reg2Loc;
	logic ALUSrc;
	logic MemtoReg;
	logic RegWrite;
	logic MemRead;
	logic MemWrite;
	logic Branch;
	logic [1:0] ALUOp;

	maindec dut(.Op(Op), .Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
	
	initial begin
		Op = 11'b111_1100_0010;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 1 | MemtoReg !== 1| RegWrite !== 1 | MemRead !== 1 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b00)
			$display("LDUR failed.");
		Op = 11'b111_1100_0000;	#10;
		if (Reg2Loc !== 1 | ALUSrc !== 1 | MemtoReg !== 0| RegWrite !== 0 | MemRead !== 0 | MemWrite !== 1 | Branch !== 0 | ALUOp !== 2'b00)
			$display("STUR failed.");
		Op = 11'b101_1010_0???;	#10;
		if (Reg2Loc !== 1 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 0 | MemRead !== 0 | MemWrite !== 0 | Branch !== 1 | ALUOp !== 2'b01)
			$display("CBZ failed.");
		Op = 11'b100_0101_1000;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("ADD failed.");
		Op = 11'b110_0101_1000;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("SUB failed.");
		Op = 11'b100_0101_0000;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("AND failed.");
		Op = 11'b101_0101_0000;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("ORR failed.");
		Op = 11'b110_1001_1011;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("LSL failed.");
		Op = 11'b110_1001_1010;	#10;
		if (Reg2Loc !== 0 | ALUSrc !== 0 | MemtoReg !== 0| RegWrite !== 1 | MemRead !== 0 | MemWrite !== 0 | Branch !== 0 | ALUOp !== 2'b10)
			$display("LSR failed.");
		$finish;
	end
endmodule
