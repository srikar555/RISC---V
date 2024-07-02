// 10 address lines 
// 10 address lines 
module ExectionUnit(Clk,
PCSrc,
ResultSrc,
MemWrite,
ALUControl,
ALUSrc,
ImmSrc,
RegWrite);
input Clk,PCSrc,MemWrite,ALUSrc,RegWrite;
input [1:0]ResultSrc,ImmSrc;
input [2:0]ALUControl;
wire [9:0]PCNext,PC,PCplus4,PCTarget;
wire [31:0] Instr,SrcA,SrcB,ALUResult,Zero,WriteData,ReadData,Result,ImmExt;

assign PC = (PCSrc)? PCTarget : PCplus4 
InstrLoader IL1(.Clk(Clk), 
                .PCNext(PCNext),
                .PC(PC));
InstructionMemory IM1(.PC(A), 
                      .Instr(RD));
RegBank RB1(.Clk(Clk),
            .RegWrite(En),
            .Instr[19:15](A1),
            .Instr[24:20](A2), 
            .Instr[11:7](A3), 
            .Result(WD), 
            .SrcA(RD1), 
            .WriteData(RD2));
wire Cout,Carry,Zero,OverFlow;
ALU ALU1(.A(SrcA), .B(SrcB), .ALUControl(ALUControl), .Y(ALUResult), .Cout(Cout), .Carry(Carry), .Zero(Zero), .OverFlow(OverFlow));            
assign SrcB = (ALUSrc)? ImmExt : WriteData;
DataMemory DM1(.Clk(Clk), .ALUResult(A), .WriteData(WD), .MemWrite(En), .ReadData(RD));
assign Result = (ResultSrc==2'b10)? ReadData : (ResultSrc==2'b01)? ALUResult: (ResultSrc==2'b00)? PCplus4 : 32'd0;
assign PCplus4 = PC + 1;

endmodule
assign ImmExt = (ImmSrc=2'b00)? {{20{instr[31]}},instr[31:20]}: 
(ImmSrc=2'b01)?{{20{instr[31]}}, instr[31:25], instr[11:7]} :
 (ImmSrc=2'b10)? {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}:
{{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};  



module ALU(A, 
B,
ALUControl, 
Y, 
Cout, 
Carry,
OverFlow,
Negative,
Zero);

//INPUTS
input [31:0]A,B;
input [2:0]ALUControl; //8 operations


//OUTPUTS
output [31:0]Y;
output Cout,Carry,OverFlow,Zero,Negative;

//WIRES
wire [31:0] A_AND_B;
wire [31:0] A_OR_B;
wire [31:0] Mux_Out; // for 2's complement
wire [31:0] Sum;
wire Cout;


//LOGIC
assign A_AND_B = A & B;
assign A_OR_B = A | B;
assign Mux_Out = (~ALUControl[2])? (~B):(B);
assign {Cout,Sum} = ALUControl[0] + A + Mux_Out;
assign Y = (ALUControl[1:0] == 2'b00) ? A_AND_B :
    (ALUControl[1:0] == 2'b01) ? A_OR_B :
    (ALUControl[1:0] == 2'b10) ? Sum : 
{{31{1'b0}},Sum[31]};
  assign OverFlow = (~ALUControl[0])&(A[31] & B[31] & (~Y[31]) + (~A[31]) & (~B[31]) & Sum[31]);
assign Carry = ((~ALUControl[0]) & Cout);
assign Zero = &(~Y);
assign Negative = Y[31];    
endmodule


