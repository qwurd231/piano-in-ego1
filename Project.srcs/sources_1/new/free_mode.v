`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 15:47:15
// Design Name: 
// Module Name: free_mode
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


module free_mode(
    input select,
    input [7:0] key,
    input [1:0] range,
    output reg [4:0] note,
    output [1:0] range_indication,
    output [7:0] led);
    
    assign led = key;
    assign range_indication = range;
    always @* begin
        note[4:3] = range;
        if (select) begin
            case (key)
                8'h1: note[2:0] = 3'h1;
                8'h2: note[2:0] = 3'h2;
                8'h4: note[2:0] = 3'h3;
                8'h8: note[2:0] = 3'h4;
                8'h10: note[2:0] = 3'h5;
                8'h20: note[2:0] = 3'h6;
                8'h40: note[2:0] = 3'h7;
                default: note[2:0] = 3'h0;
            endcase
        end
        else begin
            note[2:0] = 3'h0;
        end
    end    
    
endmodule
