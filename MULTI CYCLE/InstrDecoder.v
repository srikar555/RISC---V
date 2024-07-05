module InstrDecoder(Op,ImmSrc);
input [6:0]Op;
output [1:0]ImmSrc;
assign ImmSrc = (Op==7'd3)? 2'b00 : (Op==7'd35)? 2'b01 : (Op==7'd99)? 2'b10 : 2'b11;
endmodule  