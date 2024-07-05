// Code your design here
// 32 register
// 3 5 bit address ports
// one Enable port
// 2 read data ports
// one write data port

module RegBank(En,Clk,A1,A2,A3,WD,RD1,RD2);
input En,Clk;
input [31:0]WD;
input [4:0]A1,A2,A3;
  output wire [31:0]RD1,RD2;
reg [31:0]reg_bank[31:0];
assign RD1 = reg_bank[A1];
assign RD2 = reg_bank[A2];
  always @(posedge Clk) begin
    if(En) begin
        reg_bank[A3] <= WD;
    end
end

endmodule