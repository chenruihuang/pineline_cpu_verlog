`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:14 04/08/2017 
// Design Name: 
// Module Name:    pc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pc(clock, reset, pc);
	input clock, reset, pc;
	always @(posedge clock or negedge reset) begin
		if (!reset) begin
			pc_out <= 8'0000_0000;
		end else if (state ==`exec) begin
			if(((mem_ir[15:11] == `BZ)
				&& (zf == 1'b1)) 
			|| ((mem_ir[15:11] == `BN)
				&& (nf == 1'b1)))
				pc <= reg_C[7:0];
			else
				pc <= pc + 1;
		end
	end
endmodule
