//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(input clk,reset,           
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall);
  
  //////////////////////////////////////////internal signals////////////////////////////////////////////////////////
 
  wire PC_write, IF_ID_write;
  wire PC_Branch, PC_Branch_EX;
  wire [31:0] PC_IF, PC_ID;
  wire [31:0] INSTRUCTION_IF, INSTRUCTION_ID;
  wire [31:0] ALU_OUT_MEM, ALU_OUT_WB;
  wire [31:0] IMM_ID, IMM_EX;
  wire [31:0] REG_DATA1_ID, REG_DATA2_ID, REG_DATA1_EX, REG_DATA2_EX, REG_DATA2_EX_FINAL, REG_DATA2_MEM;
  wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUSrc_ID, Branch_ID;
  wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX, ALUSrc_EX;
  wire RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM,ALUSrc_MEM;
  wire RegWrite_WB, MemtoReg_WB;
  wire [1:0] ALUop_ID, ALUop_EX, ALUop_MEM;
  wire [2:0] FUNC3_ID, FUNC3_EX, FUNC3_MEM;
  wire [6:0] FUNC7_ID, FUNC7_EX, FUNC7_MEM;
  wire [6:0] OPCODE, OPCODE_EX;
  wire [4:0] RD_ID, RS1_ID, RS2_ID, RS1_EX, RS2_EX, RD_EX, RD_MEM, RD_WB;                         
  wire zero_EX, zero_MEM;
  wire [31:0] MUX_B_temp, DATA_Memory_WB;
 
 /////////////////////////////////////IF Module/////////////////////////////////////
 IF instruction_fetch(clk, reset, 
                      PCSrc, PC_write,
                      PC_Branch,
                      PC_IF,INSTRUCTION_IF);
  
  
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
 IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
  
 ////////////////////////////////////////ID Module//////////////////////////////////
 ID instruction_decode(clk,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_WB,
                       RD_WB,
                       IMM_ID,
                       REG_DATA1_ID,REG_DATA2_ID,
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                       ALUop_ID,
                       ALUSrc_ID,
                       Branch_ID,
                       FUNC3_ID,FUNC7_ID,
                       OPCODE,
                       RD_ID,RS1_ID,RS2_ID);
                       
//HAZARD DETECTION UNIT
hazard_detection HD(RD_EX,
                    RS1_ID,
                    RS2_ID,
                    MemRead_EX,
                    //output
                    PC_write,
                    IF_ID_write,
                    pipeline_stall);
                    
//CONTROL PATH
control_path CP(pipeline_stall,
                OPCODE_ID,
                //output
                RegWrite_ID,
                MemtoReg_ID,
                MemRead_ID,
                MemWrite_ID,
                Branch_ID,
                ALUSrc_ID,
                ALUop_ID);
 
//ID-EX PIPELINE
ID_EX_pipe ID_EX_REG(clk,
                     reset,
                  
                     RegWrite_ID,
                     MemtoReg_ID,
                     MemRead_ID,
                     MemWrite_ID,
                     Branch_ID,
                     ALUSrc_ID,
                     ALUop_ID,
                  
                     PC_ID,
                     FUNC3_ID,
                     FUNC7_ID,
                     OPCODE,
                     REG_DATA1_ID,
                     REG_DATA2_ID,
                     RS1_ID,
                     RS2_ID,
                     RD_ID,
                     IMM_ID,
                     //output
                     RegWrite_EX,
                     MemtoReg_EX,
                     MemRead_EX,
                     MemWrite_EX,
                     Branch_EX,
                     ALUSrc_EX,
                     ALUop_EX,
                  
                     PC_EX,
                     FUNC3_EX,
                     FUNC7_EX,
                     OPCODE_EX,
                     REG_DATA1_EX,
                     REG_DATA2_EX,
                     RS1_EX,
                     RS2_EX,
                     RD_EX,
                     IMM_EX);

//FORWARDING UNIT
forwarding FW(RS1_EX,
              RS2_EX,
              RD_MEM,
              RD_WB,
              RegWrite_MEM,
              RegWrite_WB,
              //output
              forwardA, forwardB);

//EXECUTE
EX execute(IMM_EX,             
           REG_DATA1_EX,        
           REG_DATA2_EX,       
           PC_EX,               
           FUNC3_EX,            
           FUNC7_EX,           
           RD_EX,               
           RS1_EX,               
           RS2_EX,              
           RegWrite_EX,                
           MemtoReg_EX,                
           MemRead_EX,                 
           MemWrite_EX,                
           ALUop_EX,             
           ALUSrc_EX,                  
           Branch_EX,                 
           forwardA,forwardB,
              
           ALU_DATA_WB,
           ALU_OUT_MEM,
           //output
           zero_EX,
           ALU_OUT_EX,
           PC_Branch_EX,
           REG_DATA2_EX_FINAL);
          
//EX-MEM PIPELINE
EX_MEM_pipe EX_MEM_REG(clk,
                       reset,
              
                       RegWrite_EX,
                       MemtoReg_EX,
                       MemRead_EX,
                       MemWrite_EX,
                       ALUop_EX,
                       ALUSrc_EX,
                       Branch_EX,
              
                       PC_Branch_EX,
                       FUNC3_EX,
                       FUNC7_EX,
                       zero_EX,
                       ALU_OUT_EX,
                       MUX_B_temp,
                       RD_EX,
                       //output
                       RegWrite_MEM,
                       MemtoReg_MEM,
                       MemRead_MEM,
                       MemWrite_MEM,
                       ALUop_MEM,
                       ALUSrc_MEM,
                       Branch_MEM,
                       
                       PC_MEM,
                       FUNC3_MEM,
                       FUNC7_MEM,
                       zero_MEM,
                       ALU_OUT_MEM,
                       REG_DATA2_MEM,
                       RD_MEM);
                       
branch_control BC(zero_MEM, ALU_OUT_MEM, Branch_MEM, FUNC3_MEM,
                  //output
                  PCSrc);
                  
data_memory DM(clk,       
               MemRead_MEM,
               MemWrite_MEM,
               ALU_OUT_MEM,
               REG_DATA2_MEM,
               //output
               DATA_MEMORY_MEM);
               
MEM_WB_pipe MEM_WB_REG(clk,
                       reset,
              
                       DATA_MEMORY_MEM,
                       ALU_OUT_MEM,
                       RD_MEM,
                       RegWrite_MEM,
                       MemtoReg_MEM,
                       //output
                       ALU_OUT_WB,
                       DATA_Memory_WB,
                       RD_WB,
                       RegWrite_WB,
                       MemtoReg_WB);
                       
mux2_1 mux_WB(ALU_OUT_WB, DATA_Memory_WB, MemtoReg_WB, ALU_DATA_WB);
    
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
