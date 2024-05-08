`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 09:12:05
// Design Name: 
// Module Name: MEM_WB_pipe
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


module MEM_WB_pipe(input clk,
                   input reset,
              
                   input [31:0] data_in,
                   input [31:0] alu_in,
                   input [4:0] rd_in,
                   input RegWrite_in,
                   input MemtoReg_in,
             
                   output reg [31:0] alu_out,
                   output reg [31:0] data_out,
                   output reg [4:0] rd_out,
                   output reg RegWrite_out,
                   output reg MemtoReg_out);
    
     always@(posedge clk) begin
        if (reset) begin 
            alu_out <= 32'b0;
            data_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 0;
            MemtoReg_out <= 0;
        end 
        else begin 
            alu_out <= alu_in;
            data_out <= data_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
        end 
     end         
endmodule
