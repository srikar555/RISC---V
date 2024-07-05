`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 01:14:50 PM
// Design Name: 
// Module Name: MultiCycel
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

module MultiCycle(input Clk);
wire PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite;
wire [2:0]ALUControl;
wire [1:0]ImmSrc;
wire fun75;
wire [2:0]fun3;
wire [6:0]Op;
wire Cout,Zero,Carry,OverFlow;
wire [31:0]Instr;

assign fun75 = Instr[30];
assign fun3 = Instr[14:12];
assign Op = Instr[6:0];

DataPath DP1(.Clk(Clk),
.PCWrite(PCWrite),
.AdrSrc(AdrSrc),
.MemWrite(MemWrite),
.IRWrite(IRWrite),
.ResultSrc(ResultSrc),
.ALUControl(ALUControl),
.ALUSrcA(ALUSrcA),
.ALUSrcB(ALUSrcB),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.Cout(Cout),
.Zero(Zero),
.Carry(Carry),
.OverFlow(OverFlow),
.Instr(Instr));

ControlUnit CU1(.Clk(Clk),
.PCWrite(PCWrite),
.AdrSrc(AdrSrc),
.MemWrite(MemWrite),
.IRWrite(IRWrite),
.ResultSrc(ResultSrc),
.ALUControl(ALUControl),
.ALUSrcA(ALUSrcA),
.ALUSrcB(ALUSrcB),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.Zero(Zero),
.Op(Op),
.fun3(fun3),
.fun75(fun75)
);

endmodule