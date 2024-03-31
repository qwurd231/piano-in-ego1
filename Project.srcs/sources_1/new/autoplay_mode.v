`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 12:52:10
// Design Name: 
// Module Name: autoplay_mode
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
`include "constants.v"

module autoplay_mode(
    input clk,
    input select,
    output reg [7:0] led,
    output [4:0] note);
    
    reg [7:0] info;
    reg [8:0] counter;
    reg [2:0] beat;
    reg [1:0] range;
    reg [2:0] key;
    
    reg [7:0] song [2:0][170:0];
    reg [1:0] num = 2'h0;
    reg [31:0] t;
    reg [31:0] portion;
    
    always @(*) begin
        beat = info[7:5];
        range = info[4:3];
    end
        
    always @(*) begin
        case (beat)
            3'b000: portion = 30000000;
            3'b001: portion = 7500000;
            3'b010: portion = 15000000;
            3'b011: portion = 2500000;
            3'b100: portion = 5000000;
            3'b101: portion = 10000000;
            3'b110: portion = 20000000;
            3'b111: portion = 40000000;
        endcase
    end
    
    always @(*) begin
        case (key)
            3'h1: led = 8'h1;
            3'h2: led = 8'h2;
            3'h3: led = 8'h4;
            3'h4: led = 8'h8;
            3'h5: led = 8'h10;
            3'h6: led = 8'h20;
            3'h7: led = 8'h40;
            default: led = 8'h0;
        endcase
    end
    
    always @(posedge clk) begin
        if (select) begin
            info <= song[num][counter];
            if (t >= portion * 10) begin
                t <= 0;
                counter <= counter + 6'b1;
            end
            else begin
                t = t + 1;
                if (t >= portion * 8) begin
                    key <= 3'h0;
                end
                else key <= info[2:0];
            end
        end
        else begin
            counter <= 6'h0;
            info <= 8'b10100000;
        end
    end
    
    assign note = {range, key};
       
endmodule
