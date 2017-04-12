`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:08 04/08/2017 
// Design Name: 
// Module Name:    cpu_top 
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
module cpu_top(clock, reset, enable, start);
	input clock, reset, enable, start;
	wire [7:0] ins_address;
	wire [15:0] ins_instruction;
	wire dw;
	wire [7:0] data_address;
	wire [15:0] smdr1;
	wire [15:0] read_data;
data_memory data_memory0(
.clock(clock),
.address(data_address),
.we(dw),
.read_data(read_data),
.write_data(smdr1)
);

instruction_memory instruction_memory0(
.clock(clock),
.address(ins_address),
.instruction_out(ins_instruction)
);

cpu cpu0(
.clock(clock), 
.reset(reset), 
.start(start), 
.enable(enable), 
.id_ir(ins_instruction), 
.dw(dw), 
.data_address(data_address), 
.smdr1(smdr1),
.pc(ins_address),
.read_data(read_data)
);
endmodule
