`timescale 1ns / 1ps
// HAZARD DETECTION UNIT

module hdu (
    input logic [4:0] id_ex_Rt,
    input logic [4:0] if_id_Rt,
    input logic [4:0] if_id_Rm,
    input logic [4:0] if_id_Rn,
    input logic id_ex_Memread,
    output logic stall_control,
    output logic if_id_write,
    output logic pc_write
    );
    
    always_comb begin
        if (id_ex_Memread && ((id_ex_Rt == if_id_Rm) || (id_ex_Rt == if_id_Rn) || (id_ex_Rt == if_id_Rt))) begin
             stall_control = 0;
             if_id_write = 0;
             pc_write = 0;
        end else begin 
            stall_control = 1;
            if_id_write = 1;
            pc_write = 1;
        end 
    end
         
endmodule 
    
    
