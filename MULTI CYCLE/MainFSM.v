// Code your design here
// S0: Fetch
// S1: Deccode 
// S2: MemAdr
// S3: MemRead
// S4: MemWB


module MainFSM(op,               
Clk,
Reset,
Zero,
PCWrite,
Branch,
RegWrite,
MemWrite,
IRWrite,
ResultSrc,
ALUSrcA,
ALUSrcB,
ImmSrc,
AdrSrc,
ALUOp);
input Clk,Zero,Reset;
input [6:0]op;
output reg PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,Branch;
output reg [1:0]ResultSrc,ALUSrcA,ALUSrcB,ImmSrc;
output reg [2:0]ALUOp;
parameter  S0 = 000, S1 = 001, S2 = 010, S3 = 011, S4 = 100;
reg [2:0]PresentState,NextState;
reg PCUpdate;
//Next State
always@(*) begin
    if(PresentState == S0) begin
        NextState <= S1;
    end
    else if(PresentState == S1 && (op==7'd3 || op==7'd35)) begin
        NextState <=S2;
    end
    else if(PresentState == S2 && (op==7'd3)) begin
        NextState <=S3;
    end
    else if(PresentState == S3) begin
        NextState <=S4;
    end
    else if(PresentState == S4) begin
        NextState <=S0;
    end
    else begin
        NextState <= S0;
    end
end
// Flop
  always @(posedge Reset or posedge Clk) begin
    if(Reset) begin
        PresentState <= S0;
    end
    else begin
        PresentState <= NextState;
    end
end 
// Output
always @(*) begin
    if(PresentState == S0) begin
        AdrSrc <= 0;
        IRWrite <= 1;
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b10;
        ALUOp <= 2'b00;
        ResultSrc <= 2'b00;
        PCUpdate <= 1;
        end
    else if(PresentState == S1) begin
          // Do Nothing or wait
        end
    else if(PresentState == S2) begin        
         ALUSrcA <= 2'b10;
         ALUSrcB <= 2'b01;
         ALUOp <= 2'b00;
        end
    else if(PresentState == S3) begin        
         ResultSrc <= 2'b10;
         AdrSrc <=1;
        end         
    else if(PresentState == S4) begin        
         ResultSrc <= 2'b01;
         RegWrite <= 1;
        end
    else begin
        AdrSrc <= 0;
        IRWrite <= 1;
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b10;
        ALUOp <= 2'b00;
        ResultSrc <= 2'b00;
        PCUpdate <= 1;
    end
    PCWrite = PCUpdate | (Zero & Branch);                    
end
endmodule