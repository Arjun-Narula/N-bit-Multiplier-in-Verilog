`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:44 11/26/2021 
// Design Name: 
// Module Name:    project 
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
module multiplier(
		out, a_in, b_in, clk, start, reset, finish, bcd
	);
	
parameter N = 8;

// Outputs
output[(((N*2)/3)+1)*4-1:0] bcd; 
output[(N*2)-1:0] out;
output finish;

// Inputs
input start;
input clk;
input reset;
input [N-1:0] a_in;
input [N-1:0] b_in;

// Reference registers
reg[(((N*2)/3)+1)*4-1:0] bcd_reg = 0;
reg[(N*2)-1:0] out_reg;
reg finish_reg = 0;
reg [(N*2)-1:0] a_in_reg;
reg [(N*2)-1:0] b_in_reg;
reg [8:0] bits;

// Continuous assignment
assign bcd = bcd_reg; 
assign out = out_reg;
assign finish = finish_reg;

integer i, j;  

// Reset clk and inputs
always @(negedge reset)
begin
	out_reg = 0;
	a_in_reg = 0;
	b_in_reg = 0;
end

always @(posedge clk)
begin
	if(!reset)
	begin
		case(start)
			1'b0: begin
				a_in_reg = a_in;
				b_in_reg = b_in;
				bits = N;
				finish_reg = 0;
				out_reg = 0;
				bcd_reg = 0; 
				$display("Values loaded into the input register!");
			end
			
			1'b1: begin
				if(b_in_reg[0]==1)
				begin
					out_reg = out_reg + a_in_reg;
				end
				bits = bits - 1;
				a_in_reg = a_in_reg<<1;
				b_in_reg = b_in_reg>>1;				
			end
		endcase
		if(bits==0)
		begin
			$display("Multiplication completed!");
			finish_reg = 1'b1;
			
			//----------------------------------------------------------------------
			// conversion of binary to bcd
			for(i=0;i<(N*2);i=i+1)
			begin
				if (3 <= (((N*2)/3)+1)*4-1 && bcd_reg[3:0] >= 5) bcd_reg[3:0] = bcd_reg[3:0] + 3;		
				if (7 <= (((N*2)/3)+1)*4-1 && bcd_reg[7:4] >= 5) bcd_reg[7:4] = bcd_reg[7:4] + 3;
				if (11 <= (((N*2)/3)+1)*4-1 && bcd_reg[11:8] >= 5) bcd_reg[11:8] = bcd_reg[11:8] + 3;
				if (15 <= (((N*2)/3)+1)*4-1 && bcd_reg[15:12] >= 5) bcd_reg[15:12] = bcd_reg[15:12] + 3;
				if (19 <= (((N*2)/3)+1)*4-1 && bcd_reg[19:16] >= 5) bcd_reg[19:13] = bcd_reg[19:13] + 3;
				bcd_reg = {bcd_reg[(((N*2)/3)+1)*4-2:0],out_reg[(N*2)-1-i]};
			end
			//----------------------------------------------------------------------
			$display("Conversion of binary to BCD completed!");

		end
	end
end
endmodule

