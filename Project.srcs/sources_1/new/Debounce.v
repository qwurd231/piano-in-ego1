`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/26 18:58:35
// Design Name: 
// Module Name: debounce
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


module Debounce(
    input clk,
    input [2:0] buttons,
    output reg [2:0] debouncedbuttons
);
    reg state = 0;
    reg [24:0] count = 0;

    always @(posedge clk) begin
        if (state == 0) begin
            if (buttons != 0) begin
                debouncedbuttons <= buttons;
                count <= 1;
                state <= 1;
            end
        end else if (state == 1) begin
            debouncedbuttons <= 0;
            count <= count + 1;
            if (count == 0 && buttons == 0) begin
                state <= 0;
            end
        end
    end

endmodule


