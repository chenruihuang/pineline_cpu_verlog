`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:51 04/08/2017 
// Design Name: 
// Module Name:    instruction_memory 
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
module instruction_memory(clock, address, instruction_out
    );
	input clock;
	input [7:0] address;
	output reg [15:0] instruction_out;
	reg [15:0] instructions [0:255]; // 指令存储区域
	// 初始化指令集
	initial begin
		$readmemb("instructions.txt", instructions);
	end
	always @ (posedge clock) begin
		instruction_out <= instructions[address];
	end

endmodule
