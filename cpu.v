`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:58 04/08/2017 
// Design Name: 
// Module Name:    cpu 
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
`define NOP 5'b00000
`define HALT 5'b00001
`define LOAD 5'b00010
`define STORE 5'b00011
`define LDIH 5'b10000
`define ADD 5'b01000
`define ADDI 5'b01001
`define ADDC 5'b10001
`define SUB 5'b01010
`define SUBI 5'b01011
`define SUBC 5'b10010
`define CMP 5'b01100
`define AND 5'b01101
`define OR 5'b01110
`define XOR 5'b01111
`define SLL 5'b00100
`define SRL 5'b00110
`define SLA 5'b00101
`define SRA 5'b00111
`define JUMP 5'b11000
`define JMPR 5'b11001
`define BZ 5'b11010
`define BNZ 5'b11011
`define BN 5'b11100
`define BNN 5'b11101
`define BC 5'b11110
`define BNC 5'b11111
`define idle 1'b0
`define exec 1'b1

module cpu(clock, reset, start, enable, id_ir, dw, data_address, smdr1, pc, read_data);
	input clock, reset, start, enable;
	input [15:0] id_ir;
	reg [15:0] ex_ir;
	reg [15:0] mem_ir;
	reg [15:0] wb_ir;
	reg [15:0] gr[0:7];
	output reg [7:0] pc;
	reg zf, nf, cf;
	reg [15:0] reg_A;
	reg [15:0] reg_B;
	reg [15:0] smdr;
	output reg [15:0] smdr1;
	output reg dw;
	reg [15:0] reg_C;
	output [7:0] data_address;
	reg [15:0] reg_C1;
	input [15:0] read_data;
	reg state, next_state;
	reg [15:0] ALUo;
	initial begin
		gr[0] <= 16'b0000_0000_0000_0000;
	end
	
	assign data_address = reg_C[7:0];
//************* CU *************//
always @(posedge clock or negedge reset)
	begin
		if (!reset)
			state <= `idle;
		else
			state <= next_state;
	end
	
always @(*)
	begin
		case (state)
			`idle :
				if ((enable == 1'b1) 
				&& (start == 1'b1))
					next_state <= `exec;
				else	
					next_state <= `idle;
			`exec :
				if ((enable == 1'b0) 
				|| (wb_ir[15:11] == `HALT))
					next_state <= `idle;
				else
					next_state <= `exec;
		endcase
	end
	
always @(posedge clock or negedge reset)
	begin
		if (!reset)
			begin
				pc <= 8'b0000_0000;
			end
			
		else if (state ==`exec)
			begin
				if(((mem_ir[15:11] == `BZ)
					&& (zf == 1'b1)) 
				|| ((mem_ir[15:11] == `BN)
					&& (nf == 1'b1)) 
				|| ((mem_ir[15:11] == `BC)
					&& (cf == 1'b1)) 
				|| ((mem_ir[15:11] == `BNZ)
					&& (zf == 1'b0)) 
				|| ((mem_ir[15:11] == `BNN)
					&& (nf == 1'b0)) 
				|| ((mem_ir[15:11] == `BNC)
					&& (cf == 1'b0))
				|| (mem_ir[15:11] == `JUMP)
				|| (mem_ir[15:11] == `JMPR))
					pc <= reg_C[7:0];
				else
					pc <= pc + 1;
			end
	//end
	
	
//************* ID *************//
		if (state == `exec)
			begin
				ex_ir <= id_ir;
				
				// TODO:JUMP命令
				// 给寄存器输出，ALU输入reg_A赋值
				if ((id_ir[15:11] == `LDIH) 
				|| (id_ir[15:11] == `ADDI) 
				|| (id_ir[15:11] == `SUBI) 
				|| (id_ir[15:11] == `BZ) 
				|| (id_ir[15:11] == `BNZ) 
				|| (id_ir[15:11] == `BN) 
				|| (id_ir[15:11] == `BNN) 
				|| (id_ir[15:11] == `BC) 
				|| (id_ir[15:11] == `BNC) 
				|| (id_ir[15:11] == `JMPR))
					reg_A <= gr[(id_ir[10:8])];
				else	
					reg_A <= gr[(id_ir[6:4])];
				
				// 给寄存器输出，ALU输入reg_B赋值
				if (id_ir[15:11] == `LOAD)
					reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
				else if ((id_ir[15:11] == `STORE)
						|| (id_ir[15:11] == `SLL)
						|| (id_ir[15:11] == `SRL)
						|| (id_ir[15:11] == `SLA)
						|| (id_ir[15:11] == `SRA))
					reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
				else if ((id_ir[15:11] == `ADDI) 
						|| (id_ir[15:11] == `SUBI)  
						|| (id_ir[15:11] == `BZ) 
						|| (id_ir[15:11] == `BNZ) 
						|| (id_ir[15:11] == `BN) 
						|| (id_ir[15:11] == `BNN) 
						|| (id_ir[15:11] == `BC) 
						|| (id_ir[15:11] == `BNC) 
						|| (id_ir[15:11] == `JMPR)
						|| (id_ir[15:11] == `JUMP))
					reg_B <= {8'b0000_0000, id_ir[7:0]};
				else if (id_ir[15:11] == `LDIH)
					reg_B <= {id_ir[7:0], 8'b0000_0000};
				else
					reg_B <= gr[id_ir[2:0]];
					
				// 给写回数据赋值
				smdr <= gr[id_ir[10:8]];
			end
			
			
//************* EX *************//	
		if (state == `exec)
			begin
				mem_ir <= ex_ir;
				smdr1 <= smdr;
				
				// ALU计算及输出
				if ((ex_ir[15:11] == `LOAD) 
					|| (ex_ir[15:11] == `STORE)  
					|| (ex_ir[15:11] == `LDIH) 
					|| (ex_ir[15:11] == `ADD) 
					|| (ex_ir[15:11] == `ADDI) 
					|| (ex_ir[15:11] == `ADDC) 
					|| (ex_ir[15:11] == `JMPR) 
					|| (ex_ir[15:11] == `BZ) 
					|| (ex_ir[15:11] == `BNZ) 
					|| (ex_ir[15:11] == `BN) 
					|| (ex_ir[15:11] == `BNN) 
					|| (ex_ir[15:11] == `BC) 
					|| (ex_ir[15:11] == `BNC))
					{cf,reg_C} <= reg_A + reg_B;
				else if (ex_ir[15:11] == `AND)
					reg_C <= reg_A & reg_B;
				else if (ex_ir[15:11] == `OR)
					reg_C <= reg_A | reg_B;
				else if (ex_ir[15:11] == `XOR)
					reg_C <= reg_A ^ reg_B;
				else if (ex_ir[15:11] == `SLL)
					reg_C <= reg_A << reg_B;
				else if (ex_ir[15:11] == `SRL)
					reg_C <= reg_A >> reg_B;
				else if (ex_ir[15:11] == `SLA)
					reg_C <= reg_A <<< reg_B;
				else if (ex_ir[15:11] == `SRA)
					reg_C <= reg_A >>> reg_B;
				else if (ex_ir[15:11] == `JUMP)
					reg_C <= reg_B;
				else
					reg_C <= reg_A - reg_B;
				// TODO:进位cf
				if ((ex_ir[15:11] == `ADD) 
				|| (ex_ir[15:11] == `CMP))
					begin
						if (reg_C == 16'b0000_0000_0000_0000)
							zf <= 1'b1;
						else
							zf <= 1'b0;
						if (reg_C[15] == 1'b1)
							nf <= 1'b1;
						else
							nf <= 1'b0;
						
					end
				// 写入信号
				if (ex_ir[15:11] == `STORE)
					dw <= 1'b1;
				else
					dw <= 1'b0;
				
			end
			

//************* MEM *************//
		if (state == `exec)
			begin
				wb_ir <= mem_ir;
				
				if (mem_ir[15:11] == `LOAD)
					reg_C1 <= read_data;
				else
					reg_C1 <= reg_C;
			end
			
		
//************* WB *************//
		if (state == `exec)
			begin
				if ((wb_ir[15:11] == `LOAD)
				|| (wb_ir[15:11] == `ADD)
				|| (wb_ir[15:11] == `ADDI)
				|| (wb_ir[15:11] == `ADDC)
				|| (wb_ir[15:11] == `SUB)
				|| (wb_ir[15:11] == `SUBI)
				|| (wb_ir[15:11] == `SUBC)
				|| (wb_ir[15:11] == `AND)
				|| (wb_ir[15:11] == `OR)
				|| (wb_ir[15:11] == `XOR)
				|| (wb_ir[15:11] == `SLL)
				|| (wb_ir[15:11] == `SRL)
				|| (wb_ir[15:11] == `SLA)
				|| (wb_ir[15:11] == `SRA))
					gr[wb_ir[10:8]] <= reg_C1;
			end
	end
endmodule
