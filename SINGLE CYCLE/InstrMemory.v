// Code your design here
module InstructionMemory(Address, Instruction); 
    input       [31:0]  Address;        // Input Address 
    output   [31:0]  Instruction;    // Instruction at memory location Address  
    reg [31:0] mem[0:1024];
	initial
	begin
		$readmemh("code.txt",mem);
	end
	assign Instruction = mem[Address];		
	integer i=0;
  initial begin
  for(integer i=0;i<5;i++) begin
		$display("%h",mem[i]);
	end
  end
endmodule