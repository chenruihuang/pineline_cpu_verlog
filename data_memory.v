`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:15 04/08/2017 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(clock, address, we, read_data, write_data);
	input clock, we; // 时钟和写使能信号
	input [7:0] address; // 内存地址
	input [15:0] write_data; // 要写入的数据
	output reg [15:0] read_data; // 读取的数据
	reg [15:0] data_mem [0:255]; // 内存数据
	
	initial begin
		$readmemb("data_memory.txt", data_mem);
	end
	
	always @(negedge clock) begin
		// d_we = 1;写使能，写入数据
		// d_we = 0;读取数据
		if (we) begin
			data_mem[address] <= write_data;
		end else begin
			read_data <= data_mem[address];
		end
	end
endmodule