`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 12:24:02 PM
// Design Name: 
// Module Name: signext
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


module signext #(parameter N=32)(
    input logic [N-1:0] a,
    output logic [63:0] y
    );
    always_comb begin
        // $display("a[31:21] = %11b", a[31:21]); // Debug
        casez(a[31:21])
            11'b111_1100_00?0: y <= {{55{a[20]}},a[20:12]};
            11'b101_1010_0???: y <= {{45{a[23]}},a[23:5]};
            default: y <= 'b0;
        endcase
    end 
endmodule
