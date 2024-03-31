`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 21:58:26
// Design Name: 
// Module Name: buzzer
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


module buzzer(
    input clk , // Clock signal
    input [4:0] note, // Note ( Input 1 outputs a signal for 'do , ' 2 for 're , ' 3 for 'mi , and so on)
    output speaker // Buzzer output signal
);

    reg [31:0] notes [7:0];
    reg [31:0] counter = 0;
    reg pwm = 0;
    wire [2:0] note_number;
    wire [1:0] range;
    
    assign range = note[4:3];
    assign note_number = note[2:0];
    
    // Frequencies of do , re , mi , fa , so , la , si
    // Obtain the ratio of how long the buzzer should be active in one second
    always @(*) begin
        notes[0] = 0;
        if (range == 2'b00) begin
            notes[1] = 382263;
            notes[2] = 340599;
            notes[3] = 303398;
            notes[4] = 286369;
            notes[5] = 255102;
            notes[6] = 227273;
            notes[7] = 202511;
        end
        else if (range == 2'b10) begin
            notes[1] = 764526;
            notes[2] = 681199;
            notes[3] = 606796;
            notes[4] = 572738;
            notes[5] = 510204;
            notes[6] = 454545;
            notes[7] = 405022;
        end
        else if (range == 2'b01) begin
            notes[1] = 191132;
            notes[2] = 170299;
            notes[3] = 151699;
            notes[4] = 143185;
            notes[5] = 127551;
            notes[6] = 113637;
            notes[7] = 101256;
        end
        else begin
            notes[1] = 0;
            notes[2] = 0;
            notes[3] = 0;
            notes[4] = 0;
            notes[5] = 0;
            notes[6] = 0;
            notes[7] = 0;
        end
    end
    
    always @ (posedge clk) begin
        if (counter < notes[note_number] || note_number == 3'b0) begin
            counter <= counter + 1;
        end else begin
            pwm = ~pwm;
            counter <= 0;
        end
    end
    
    assign speaker = pwm;

endmodule
