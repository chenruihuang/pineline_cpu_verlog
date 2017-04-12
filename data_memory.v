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
	input clock, we; // ʱ�Ӻ�дʹ���ź�
	input [7:0] address; // �ڴ��ַ
	input [15:0] write_data; // Ҫд�������
	output reg [15:0] read_data; // ��ȡ������
	reg [15:0] data_mem [0:255]; // �ڴ�����
	
	initial begin
		$readmemb("data_memory.txt", data_mem);
	end
	
	always @(negedge clock) begin
		// d_we = 1;дʹ�ܣ�д������
		// d_we = 0;��ȡ����
		if (we) begin
			data_mem[address] <= write_data;
		end else begin
			read_data <= data_mem[address];
		end
	end
endmodule