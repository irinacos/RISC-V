`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 10:22:36
// Design Name: 
// Module Name: ID_EX_pipe
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EX_pipe(input clk,
                  input res,
                  
                  //semnale control
                  input RegWrite_in,
                  input MemtoReg_in,
                  input MemRead_in,
                  input MemWrite_in,
                  input Branch_in,
                  input ALUSrc_in,
                  input [1:0] ALUop_in,
                  
                  input [31:0] PC_in,
                  input [2:0] func3_in,
                  input [6:0] func7_in,
                  input [6:0] OPCODE_in,
                  input [31:0] ALU_A_in,    //reg_data1
                  input [31:0] ALU_B_in,    //reg_data2
                  input [4:0] RS1_in,
                  input [4:0] RS2_in,
                  input [4:0] RD_in,
                  input [31:0] IMM_in,
                  
                  //semnale control
                  output reg RegWrite_out,
                  output reg MemtoReg_out,
                  output reg MemRead_out,
                  output reg MemWrite_out,
                  output reg Branch_out,
                  output reg ALUSrc_out,
                  output reg [1:0] ALUop_out,
                  
                  output reg [31:0] PC_out,
                  output reg [2:0] func3_out,
                  output reg [6:0] func7_out,
                  output reg [6:0] OPCODE_out,
                  output reg [31:0] ALU_A_out,
                  output reg [31:0] ALU_B_out,
                  output reg [4:0] RS1_out,
                  output reg [4:0] RS2_out,
                  output reg [4:0] RD_out,
                  output reg [31:0] IMM_out);
                  
    always@(posedge clk) begin
        if (res) begin
            RegWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            Branch_out <= 1'b0;
            ALUSrc_out <= 1'b0;
            ALUop_out <= 2'b0;
                  
            PC_out <= 32'b0;
            func3_out <= 3'b0;
            func7_out <= 7'b0;
            OPCODE_out <= 7'b0;
            ALU_A_out <= 32'b0;
            ALU_B_out <= 32'b0;
            RS1_out <= 5'b0;
            RS2_out <= 5'b0;
            RD_out <= 5'b0;
            IMM_out <= 32'b0;
        end
        else begin
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            Branch_out <= Branch_in;
            ALUSrc_out <= ALUSrc_in;
            ALUop_out <= ALUop_in;
                      
            PC_out <= PC_in;
            func3_out <= func3_in;
            func7_out <= func7_in;
            OPCODE_out <= OPCODE_in;
            ALU_A_out <= ALU_A_in;
            ALU_B_out <= ALU_B_in;
            RS1_out <= RS1_in;
            RS2_out <= RS2_in;
            RD_out <= RD_in;
            IMM_out <= IMM_in;
        end
    end
endmodule
