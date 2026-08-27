`timescale 1ns / 1ps
// EXECUTE

module execute #(parameter N = 64) (
	input logic AluSrc,
	input logic [5:0]shamt,
	input logic [3:0] AluControl,
	input logic [1:0] fwA_ctrl, fwB_ctrl,
	input logic [N-1:0] PC_E,
	input logic [N-1:0] signImm_E,
	input logic [N-1:0] readData1_E,
	input logic [N-1:0] readData2_E,
	input logic [N-1:0] writeData3_W,
	input logic [N-1:0] aluResult_M,
	output logic [N-1:0] PCBranch_E,
	output logic [N-1:0] aluResult_E,
	output logic [N-1:0] writeData_E,
	output logic zero_E
	);

	logic [N-1:0] aluSrcOut;
	logic [N-1:0] sl2Out;
	logic [N-1:0] fwA_muxOut, fwB_muxOut;

	mux3 fwA_mux(  .d0(readData1_E),
	               .d1(writeData3_W),
	               .d2(aluResult_M),
	               .s(fwA_ctrl),
	               .y(fwA_muxOut));

	mux3 fwB_mux(  .d0(readData2_E),
		           .d1(writeData3_W),
	               .d2(aluResult_M),
	               .s(fwB_ctrl),
	               .y(fwB_muxOut));

	mux2 alu_mux(	.d0(fwB_muxOut),
					.d1(signImm_E),
					.s(AluSrc),
					.y(aluSrcOut));

	alu main_alu(	.a(fwA_muxOut),
					.b(aluSrcOut),
					.ALUControl(AluControl),
					.result(aluResult_E),
					.zero(zero_E),
					.shamt(shamt));

	sl2 shift_left2(.a(signImm_E),
					.y(sl2Out));

	adder branch_adder(	.in1(PC_E),
						.in2(sl2Out),
						.out(PCBranch_E));

	assign writeData_E = fwB_muxOut;

endmodule
