//************************************************//
//* You need to complete the testbench below     *//
//* by yourself according to your operation set  *//
//************************************************//

//************* test pattern *************//	
// $display("pc:     id_ir      :reg_A:reg_B:reg_C:da:dd:  :w:reC1:gr1 :gr2 : gr3");
// $monitor("%h:%b:%h:%h:%h:%h:%h:%b:%h:%h:%h:%h", 
//	pcpu.pc, pcpu.id_ir, pcpu.reg_A, pcpu.reg_B, pcpu.reg_C,
//	d_addr, d_dataout, d_we, pcpu.reg_C1, pcpu.gr[1], pcpu.gr[2], pcpu.gr[3]);
	
enable <= 1; start <= 0; i_datain <= 0; d_datain <= 0; select_y <= 0;

#10 reset <= 0;
#10 reset <= 1;
#10 enable <= 1;
#10 start <=1;
#10 start <= 0;
	i_datain <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
#10 i_datain <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
#10 i_datain <= {`NOP, 11'b000_0000_0000};
#10 i_datain <= {`NOP, 11'b000_0000_0000};
	d_datain <=16'h00AB;  // 3 clk later from LOAD
#10 i_datain <= {`NOP, 11'b000_0000_0000};
	d_datain <=16'h3C00;  // 3 clk later from LOAD
#10 i_datain <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
#10 i_datain <= {`NOP, 11'b000_0000_0000};
#10 i_datain <= {`NOP, 11'b000_0000_0000};
#10 i_datain <= {`NOP, 11'b000_0000_0000};
#10 i_datain <= {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
#10 i_datain <= {`HALT, 11'b000_0000_0000};