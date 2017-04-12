`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:13 04/08/2017 
// Design Name: 
// Module Name:    IF 
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
module IF(
input clock,
input reset,
output [4:0] opcode;
output [2:0] register_a;
output [2:0] register_b;
output [3:0] imidiate_date1;
output [3:0] imidiate_date2;
output mux_select
);
wire [7:0] pc;
wire [15:0] instruction;

pc pc0(
.clock(clock),
.reset(reset),
.pc(pc)
);

id_ir id_ir0(
.instruction(instruction),
.clock(clock),
.opcode(opcode),
.immidiate_data1(immidiate_data1),
.immidiate_data2(immidiate_data2),
.register_a(register_a),
.register_b(register_b),
.mux_select(mux_select)
);

instruction_memory(
.pc(pc),
.instruction(instruction)
);
endmodule
