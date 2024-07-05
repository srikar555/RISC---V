`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 01:21:17 PM
// Design Name: 
// Module Name: Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Memory(Clk,
A,
WD,
RD,
WE);
input Clk,WE;
input [31:0]A,WD;
output reg [31:0]RD; 
reg [31:0]RD_reg[31:0];
always @(posedge Clk ) begin
    RD <= RD_reg[A];
end
endmodule