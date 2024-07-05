`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 12:51:29 PM
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(Clk,
Zero,
fun75,
fun3,
Op,
PCWrite,
AdrSrc,
MemWrite,
IRWrite,
ResultSrc,
ALUControl,
ALUSrcB,
ALUSrcA,
ImmSrc,
RegWrite);

input Clk,Zero,fun75;
input [6:0]Op;
input [2:0]fun3;
output PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite;
output [1:0]ResultSrc,ALUSrcA,ALUSrcB,ImmSrc;
output [2:0]ALUControl;

wire [1:0] ALUOp;
MainFSM MFSM1(.ALUOp(ALUOp), .PCWrite(PCWrite), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ImmSrc(ImmSrc), .RegWrite(RegWrite),.Zero(Zero),.Op(Op) );
ALUDecoder AD1(.ALUOp(ALUOp),.Op5(Op[5]), .fun3(fun3),.fun75(fun75),.ALUControl(ALUControl));
InstrDecoder ID1(.Op(Op),.ImmSrc(ImmSrc));
endmodule