module DataPath(Clk,
Cout,
Carry,
Zero,
OverFlow,
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
RegWrite,
Instr);

output Cout,Carry,Zero,OverFlow,fun75;
output [6:0]Op;
output [2:0]fun3;
output [31:0]Instr;
input Clk,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite;
input [1:0]ResultSrc,ALUSrcA,ALUSrcB,ImmSrc;
input [2:0]ALUControl;

reg [31:0] PCNext,PC,OldPc,Data,A,WriteData,ALUOut,Instr; 
wire [31:0] Adr,RD1,RD2,SrcA,SrcB,ALUResult,Zero,ReadData,Result,ImmExt;


always @(posedge Clk ) begin
    if(PCWrite) begin
      PC <= PCNext;
    end
end 
assign Adr = (AdrSrc)? Result : PC;

Memory M1(.Clk(Clk),
.A(Adr),
.WD(WriteData),
.RD(ReadData),
.WE(MemWrite));

always @(posedge Clk ) begin
    if(IRWrite) begin
      OldPc <= PC;
      Instr <= ReadData;
    end
end 
always @(posedge Clk ) begin
      Data <= ReadData;
end 

RegBank RB1(.Clk(Clk),
            .En(RegWrite),
            .A1(Instr[19:15]),
            .A2(Instr[24:20]), 
            .A3(Instr[11:7]), 
            .WD(Result), 
            .RD1(RD1), 
            .RD2(RD2));

always @(posedge Clk ) begin
      A <= RD1;
      WriteData <= RD2;
end 

assign SrcA = (ALUSrcA==2'b00)? PC : (ALUSrcA==2'b01)? OldPc: (ALUSrcA==2'b10)? A:32'd0; 
assign SrcB = (ALUSrcA==2'b00)? WriteData : (ALUSrcA==2'b01)? ImmExt : (ALUSrcA==2'b10)? 1:32'd0; 

ALU ALU1(.A(SrcA), .B(SrcB), .ALUControl(ALUControl), .Y(ALUResult), .Cout(Cout), .Carry(Carry), .Zero(Zero), .OverFlow(OverFlow));            

always @(posedge Clk ) begin
     ALUOut <= ALUResult;
end 

assign Result = (ResultSrc==2'b01)? Data : (ResultSrc==2'b10)? ALUOut: (ResultSrc==2'b00)? ALUResult : 32'd0;

endmodule