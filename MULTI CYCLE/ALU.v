// Code your design here
/* ALU
000 A & B
001 A | B
010 A + B
110 A - B
111 SLT
*/


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
input [2:0]ALUControl; //8 Operations


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