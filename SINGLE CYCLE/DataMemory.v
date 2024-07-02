
// 32 address lines
// one Enable port
// one read data port
// one write data port

module DataMemory(En,Clk,A,WD,RD);
input En,Clk;
input [31:0]WD;
input [31:0]A;
  output wire [31:0]RD;
reg [31:0]reg_bank[4294967295:0];
assign RD = reg_bank[A];
  always @(posedge Clk) begin
    if(En) begin
        reg_bank[A] <= WD;
    end
end

endmodule