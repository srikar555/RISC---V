module ALUDecoder(ALUOp,Op5,fun3,fun75,ALUControl);
input [1:0]ALUOp;
input fun75,Op5;
input [2:0]fun3;
output reg [2:0]ALUControl;
always @(*) begin
if(ALUOp==2'b00) begin
 ALUControl = 3'b010;
end
else if (ALUOp==2'b01) begin
 ALUControl = 3'b110;
end
else if(ALUOp==2'b10) begin
if(fun3==3'b000) begin 
  if(fun75==0) begin
     ALUControl = 3'b010;
  end
  else if(fun75==1 && Op5==1) begin
     ALUControl = 3'b110;
  end
  else begin
    ALUControl = 3'b000;
end
end
else if(fun3==3'b010 && fun75==0) begin
     ALUControl = 3'b111;
  end
else if(fun3==3'b110 && fun75==0) begin
     ALUControl = 3'b001;
  end
else if(fun3==3'b111 && fun75==0) begin
     ALUControl = 3'b000;
  end
else begin
    ALUControl = 3'b000;
end
end 
else begin
    ALUControl = 3'b000;
end

end

endmodule