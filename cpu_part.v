//************************************************//
//* You need to complete the design below        *//
//* by yourself according to your operation set  *//
//************************************************//

//************* CPU control *************//
always @(posedge clock)
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
	
	
	
//************* IF *************//
always @(posedge clock or negedge reset)
	begin
		if (!reset)
			begin
				id_ir <= 16'b0000_0000_\
				0000_0000;
				pc <= 8'0000_0000;
			end
			
		else if (state ==`exec)
			begin
				id_ir <= i_datain;
				
				if(((mem_ir[15:11] == `BZ)
					&& (zf == 1'b1)) 
				|| ((mem_ir[15:11] == `BN)
					&& (nf == 1'b1)))
					pc <= reg_C[7:0];
				else
					pc <= pc + 1;
			end
	//end
	
	
//************* ID *************//
		else if (state == `exec)
			begin
				ex_ir <= id_ir;
			
				if ((id_ir[15:11] == `BZ) 
				|| (id_ir[15:11] == `BN))
					reg_A <= gr[(id_ir[10:8])];
				else	
					reg_A <= gr[id_ir[6:4]]];
				
				if (id_ir[15:11] == `LOAD)
					reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
				else if (id_ir[15:11] == `STORE)
					begin
						reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
						smdr <= gr[id_ir[10:8]];
					end
				else if ((id_ir[15:11] == `BZ) 
						|| (id_ir[15:11] == `BN))
					reg_B <= {8'b0000_0000, id_ir[7:0]};
				else
					reg_B <= gr[id_ir[2:0]];
			end
			
			
//************* EX *************//	
		else if (state == `exec)
			begin
				mem_ir <= ex_ir;
				reg_C <= ALUo;
				
				if ((ex_ir[15:11] == `ADD) 
				|| (ex_ir[15:11] == `CMP))
					begin
						if (ALUo == 16'b0000_0000_0000_0000)
							zf <= 1'b1;
						else
							zf <= 1'b0;
						if (ALUo[15] == 1'b1)
							nf <= 1'b1;
						else
							nf <= 1'b0;
					end
				if (ex_ir[15:11] == `STORE)
					begin
						dw <= 1'b1;
						smdr1 <= smdr;
					end
				else
					dw <= 1'b0;
			end
			

//************* MEM *************//
		else if (state == `exec)
			begin
				wb_ir <= mem_ir;
				
				if (mem_ir[15:11] == `LOAD)
					reg_C1 <= d_datain;
				else
					reg_C1 <= reg_C;
			end
			
		
//************* WB *************//
		else if (state == `exec)
			begin
				if ((wb_ir[15:11] == `LOAD)
				|| (wb_ir[15:11] == `ADD))
					gr[wb_ir[10:8]] <= reg_C1;
			end
	
