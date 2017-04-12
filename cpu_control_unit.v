`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:19:10 04/07/2017 
// Design Name: 
// Module Name:    cpu_control_unit 
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
module cpu_control_unit(
    );
	 input clock, reset;
	 parameter [2:0] IF = 3'B000;
	 parameter [2:0] ID = 3'b001;
	 parameter [2:0] EX = 3'b010;
	 parameter [2:0] MEM = 3'b011;
	 parameter [2:0] WB = 3'b100;
always @(posedge clock)
	begin
		if (!reset)
			state <= IF;
		else
			state <= next_state;
	end
	
always @(*)
	begin
		case (state)
			IF :
				if 
			idle : 
				if ((enable == 1'b1) 
				&& (start == 1'b1))
					next_state <= `exec;
				else	
					next_state <= `idle;
			exec :
				if ((enable == 1'b0) 
				|| (wb_ir[15:11] == `HALT))
					next_state <= `idle;
				else
					next_state <= `exec;
		endcase
	end

endmodule
