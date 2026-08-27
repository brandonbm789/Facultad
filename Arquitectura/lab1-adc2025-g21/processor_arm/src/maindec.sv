`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 09:59:00 PM
// Design Name: 
// Module Name: maindec
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


module maindec(
    input logic [10:0] Op,
    output logic Reg2Loc,
    output logic ALUSrc,
    output logic MemtoReg,
    output logic RegWrite,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic [1:0] ALUOp
    );
		
	always_comb begin
		casez (Op)
	  	    11'b111_1100_0010: begin	//LDUR
	    	  Reg2Loc =  0;
			  ALUSrc =   1;
			  MemtoReg = 1;
			  RegWrite = 1;
			  MemRead =  1;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b00;
			  end
			11'b111_1100_0000: begin	//STUR
			  Reg2Loc =  1;
			  ALUSrc =   1;
			  MemtoReg = 0;
			  RegWrite = 0;
			  MemRead =  0;
			  MemWrite = 1;
			  Branch =   0;
			  ALUOp = 2'b00;
			  end
			11'b101_1010_0???: begin	//CBZ
			  Reg2Loc =  1;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 0;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   1;
			  ALUOp = 2'b01;
			  end
			11'b100_0101_1000: begin	//ADD
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			  end
			11'b110_0101_1000: begin	//SUB
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			  end
			11'b100_0101_0000: begin	//AND
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			  end
			11'b101_0101_0000: begin	//ORR
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			  end
			11'b110_1001_1011: begin     //LSL
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			end
			11'b110_1001_1010: begin     //LSR
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 1;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b10;
			end
			default: begin
			  Reg2Loc =  0;
			  ALUSrc =   0;
			  MemtoReg = 0;
			  RegWrite = 0;
			  MemRead =  0;
			  MemWrite = 0;
			  Branch =   0;
			  ALUOp = 2'b00;
			  end
		endcase
	end
endmodule
