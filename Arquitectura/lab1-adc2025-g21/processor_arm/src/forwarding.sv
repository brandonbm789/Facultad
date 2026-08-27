`timescale 1ns / 1ps
// FORWARDING UNIT

module forwarding(
					input logic [4:0] ID_EX_Rn, ID_EX_Rm, EX_MEM_Rd, MEM_WB_Rd, ID_EX_Rt,
					input logic EX_MEM_RegWrite, MEM_WB_RegWrite, ID_EX_MemWrite,
					output logic [1:0] forwardA, forwardB
	);

	logic [4:0] fwdB_targetReg;
	always_comb begin
        forwardA = 2'b00;
        forwardB = 2'b00;
		// Forward A
		if (EX_MEM_RegWrite && (EX_MEM_Rd != 5'b11111) && (EX_MEM_Rd == ID_EX_Rn)) begin
			forwardA = 2'b10;
		end else if (MEM_WB_RegWrite && (MEM_WB_Rd != 5'b11111) && (MEM_WB_Rd == ID_EX_Rn)) begin
			forwardA = 2'b01;
		end

		// Forward B
		if (ID_EX_MemWrite) begin   //Si la señal de control MemWrite es 1 es pq es un STUR
			fwdB_targetReg = ID_EX_Rt;
		end else begin
			fwdB_targetReg = ID_EX_Rm;
		end

		if (EX_MEM_RegWrite && (EX_MEM_Rd != 5'b11111) && (EX_MEM_Rd == fwdB_targetReg)) begin
			forwardB = 2'b10;
		end else if (MEM_WB_RegWrite && (MEM_WB_Rd != 5'b11111) && (MEM_WB_Rd == fwdB_targetReg)) begin
			forwardB = 2'b01;
		end
	end
endmodule
