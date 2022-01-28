`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:03:21 11/27/2021
// Design Name:   multiplier
// Module Name:   D:/PEC/7th SEMESTER/HDL based system design/Lab/project_verilog/multiplier_tb.v
// Project Name:  project_verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multiplier_tb;
   parameter n_bits = 5;
	
	// Inputs
	reg [n_bits-1:0] a_in;
	reg [n_bits-1:0] b_in;
	reg clk;
	reg start;
	reg reset;

	// Outputs
	wire [(n_bits*2)-1:0] out;
	wire finish;
	wire [(((n_bits*2)/3)+1)*4-1:0] bcd;

	// Instantiate the Unit Under Test (UUT)
	multiplier uut (
		.out(out), 
		.a_in(a_in), 
		.b_in(b_in), 
		.clk(clk), 
		.start(start), 
		.reset(reset), 
		.finish(finish),
		.bcd(bcd)
	);
   defparam uut.N = n_bits;

   
	initial
	begin
	forever 
		#50 clk= ~clk;
	end
	
	initial begin
		// Initialize Inputs
		a_in = 0;
		b_in = 0;
		clk = 0;
		start = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
      a_in = 'd26;
		b_in = 'd30;
		start = 0;
		#200
		start = 1;
		#(100*n_bits)
		a_in = 'd13;
		b_in = 'd13;
		start = 0;
		#200
		start = 1;
		#(100*n_bits)
		$finish;
	end
      
endmodule
