`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:12:10 04/09/2017
// Design Name:   cpu_top
// Module Name:   E:/meng/University/finalSectionOfGrade3/CaseStudyforEmbeddedSystemArchitectureDesign/experiments/project/pipeline_cpu/cpu_test.v
// Project Name:  pipeline_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_test;

	// Inputs
	reg clock;
	reg reset;
	reg enable;
	reg start;

	// Instantiate the Unit Under Test (UUT)
	cpu_top uut (
		.clock(clock),
		.reset(reset),
		.enable(enable), 
		.start(start)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 1;
		enable = 1;
		start = 1;

		// Wait 100 ns for global reset to finish
		#50;
      reset = 0;
		#50;
		reset = 1;
		forever #50 clock = !clock;
		// Add stimulus here
		
	end
      
endmodule

