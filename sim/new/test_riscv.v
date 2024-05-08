///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
  reg clk,reset;        
  wire [31:0] PC_EX, ALU_OUT_EX, PC_MEM, DATA_MEMORY_MEM, ALU_DATA_WB;
  wire PCSrc, pipeline_stall;
  wire [1:0] forwardA, forwardB;
  
  RISC_V RV(clk,reset,PC_EX,ALU_OUT_EX,PC_MEM,PCSrc,DATA_MEMORY_MEM,ALU_DATA_WB,forwardA,forwardB,pipeline_stall);
        
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
    #20 reset=1'b0;
    #200 $finish;
  end
endmodule
