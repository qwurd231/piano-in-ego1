`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 21:26:26
// Design Name: 
// Module Name: tub_mode
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


module tub_mode(
    input [1:0] in,
    output display,
    output reg [7:0] tub);
    assign display = 1'b1;
    always @ * begin
        case(in)
            2'b00: tub = 8'b1111_1100; //"0"  
            2'b01: tub = 8'b0110_0000; //"1"
            2'b10: tub = 8'b1101_1010; //"2" 
            2'b11: tub = 8'b1111_0010; //"3"
            default: tub = 8'b1111_1100; //"0"
        endcase
    end
endmodule
