`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/26 20:04:16
// Design Name: 
// Module Name: led_encode
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


module led_encode(
input [2:0]key,
output [7:0]chosen_led
    );
reg [7:0] temp;
always @(*) begin  
        if (key ==3'b001) temp  = 8'b00000001;
        else if (key ==3'b010) temp  = 8'b00000010;
        else if (key== 3'b011) temp  = 8'b00000100;
        else if (key== 3'b100) temp  = 8'b00001000;
        else if (key== 3'b101) temp  = 8'b00010000;
        else if (key== 3'b110) temp  = 8'b00100000;
        else if (key == 3'b111) temp = 8'b01000000;
        else temp = 8'b00000000;
end  
assign chosen_led = temp;


endmodule
