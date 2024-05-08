`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 09:11:06
// Design Name: 
// Module Name: EX_MEM_pipe
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


module EX_MEM_pipe (input clk,
                    input res,
                    
                    //semnale de control
                    input RegWrite_in,
                    input MemtoReg_in,
                    input MemRead_in,
                    input MemWrite_in,
                    input [1:0] ALUop_in,
                    input ALUSrc_in,
                    input Branch_in,
              
                    input [31:0] pc_in,
                    input [2:0] func3_in,
                    input [6:0] func7_in,
                    input zero_in,
                    input [31:0] alu_in,
                    input [31:0] reg2_data_in,
                    input [4:0] rd_in,
                      
                    //semnale control
                    output reg RegWrite_out,
                    output reg MemtoReg_out,
                    output reg MemRead_out,
                    output reg MemWrite_out,
                    output reg [1:0] ALUop_out,
                    output reg ALUSrc_out,
                    output reg Branch_out,
                    
                    output reg [31:0] pc_out,
                    output reg [2:0] func3_out,
                    output reg [6:0] func7_out,
                    output reg zero_out,
                    output reg [31:0] alu_out,
                    output reg [31:0] reg2_data_out,
                    output reg [4:0] rd_out);
     
     always@(posedge clk) begin
        if (res) begin 
            pc_out <= 32'b0;
            func3_out <= 3'b0;
            func7_out <= 7'b0;
            zero_out <= 0;
            alu_out <= 32'b0;
            reg2_data_out <= 32'b0;
            rd_out <= 5'b0;
        end 
        else begin 
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            Branch_out <= Branch_in;
            ALUSrc_out <= ALUSrc_in;
            ALUop_out <= ALUop_in;
           
            pc_out <= pc_in;
            func3_out <= func3_in;
            func7_out <= func7_in;
            zero_out <= zero_in;
            alu_out <= alu_in;
            reg2_data_out <= reg2_data_in;
            rd_out <= rd_in;
        end 
     end         
     
endmodule
