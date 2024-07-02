// Code your design here
module MainDecoder(ALUOp,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,Zero,Op);
input Zero;
input [6:0]Op;
output reg PCSrc,MemWrite,ALUSrc,RegWrite;
output reg [1:0]ResultSrc,ImmSrc,ALUOp;
always @(*) begin
  if(Op==7'd3) begin
    RegWrite = 1;
    ImmSrc = 2'b00;
    ALUSrc = 1;
    MemWrite = 0;
    ResultSrc = 1;
    Branch = 0;
    ALUOp = 2'b00; 
   end
  else if(Op==7'd35) begin
    RegWrite = 1;
    ImmSrc = 2'b01;
    ALUSrc = 1;
    MemWrite = 1;
    ResultSrc = 1;
    Branch = 0;
    ALUOp = 2'b00; 
   end
  else if(Op==7'd51) begin
    RegWrite = 1;
    ImmSrc = 2'b01;
    ALUSrc = 0;
    MemWrite = 0;
    ResultSrc = 0;
    Branch = 0;
    ALUOp = 2'b10; 
   end
  else if(Op==7'd99) begin
    RegWrite = 0;
    ImmSrc = 2'b10;
    ALUSrc = 0;
    MemWrite = 0;
    ResultSrc = 1;
    Branch = 1;
    ALUOp = 2'b01; 
   end
   else begin
    RegWrite = 1;
    ImmSrc = 2'b01;
    ALUSrc = 1;
    MemWrite = 1;
    ResultSrc = 1;
    Branch = 0;
    ALUOp = 2'b00; 
   end
   PCSrc = Zero & Branch;
end
endmodule