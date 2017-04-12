`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:14 04/08/2017 
// Design Name: 
// Module Name:    id_ir 
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
module id_ir(instruction, clock, opcode, immidiate_data1, immidiate_data2, register_a, register_b, mux_select
    );
	input [15:0] instruction;
	input clock;
	reg [15:0] id_ir;
	output reg [4:0] opcode;
	output reg [2:0] register_a;
	output reg [2:0] register_b;
	output reg [3:0] imidiate_date1;
	output reg [3:0] imidiate_date2;
	output reg mux_select;
	always (posedge clock or negedge reset) begin
		if (!reset) begin
			id_ir <= 16'b0000_0000_0000_0000;
		end else begin
			id_ir <= instruction;
			opcode <= id_ir[15:11];
			if ((id_ir[15:11] == `BZ) 
				|| (id_ir[15:11] == `BN))
				register_a <= gr[(id_ir[10:8])];
			else	
				register_a <= gr[id_ir[6:4]]];
			
			if (id_ir[15:11] == `LOAD)
				register_b <= {12'b0000_0000_0000, id_ir[3:0]};
			else if (id_ir[15:11] == `STORE)
				begin
					register_b <= {12'b0000_0000_0000, id_ir[3:0]};
					smdr <= gr[id_ir[10:8]];
				end
			else if ((id_ir[15:11] == `BZ) 
					|| (id_ir[15:11] == `BN))
				register_b <= {8'b0000_0000, id_ir[7:0]};
			else
				register_b <= gr[id_ir[2:0]];
			
			imidiate_date1 <= id_ir[7:4];
			imidiate_date2 <= id_ir[3:0];
		end
	end
endmodule
