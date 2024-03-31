`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/26 20:05:48
// Design Name: 
// Module Name: key_encoder
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


module key_encode(
    input [7:0] key,
    output [2:0] chosen_key
    );
    reg [2:0] temp;
    always @(*) begin  
        if (key ==8'b00000001) temp  =3'b001 ;
        else if (key ==8'b00000010) temp  =3'b010 ;
        else if (key==8'b00000100 ) temp  =3'b011 ;
        else if (key== 8'b00001000) temp  =3'b100 ;
        else if (key== 8'b00010000) temp  =3'b101 ;
        else if (key==8'b00100000 ) temp  =3'b110 ;
        else if (key == 8'b01000000) temp =3'b111 ;
        else temp = 3'b000;
end  
assign chosen_key = temp;

endmodule
