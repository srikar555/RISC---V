module SingleCore(input Clk);
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
assign Op = Instr[6:0]

ExectionUnit EU1(.CLK(Clk),
.PCSrc(PCSrc),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUControl(ALUControl),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.Cout(Cout),
.Zero(Zero),
.Carry(Carry),
.OverFlow(OverFlow),
.Instr(Instr));

ControlUnit(.Op(Op),
            .fun3(fun3),
            .fun75(fun75),
            .PCSrc(PCSrc),
            .ResultSrc(ResultSrc)
            .MemWrite(MemWrite),
            .ALUSrc(ALUSrc),
            .RegWrite(RegWrite),
            .ImmSrc(ImmSrc),
            .ALUControl(ALUControl));
endmodule