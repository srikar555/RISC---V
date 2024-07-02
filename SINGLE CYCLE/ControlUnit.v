module ControlUnit(input [6:0]Op,
                    input [2:0] fun3,
                    input fun75,
                    output PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite,
                    output [1:0]ImmSrc,
                    output [2:0]ALUControl);
wire [1:0] ALUOp;
MainDecoder MD1(.ALUOp(ALUOp), .PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .ImmSrc(ImmSrc), .RegWrite(RegWrite),.zero(zero),.Op(Op) );
ALUDecoder AD1(.ALUOp(ALUOp),.op5(op5),.fun3(fun3),.fun75(fun75),.ALUControl(ALUControl));
endmodule