`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 20:44:31
// Design Name: 
// Module Name: top
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


module top(
    input [1:0] select_mode,
    input [7:0] key,
    input clk,
    input control,
    input [1:0] range,
    input [2:0] buttons,
    output reg [1:0] range_indication,
    output boost_volume,
    output speaker,
    output reg [7:0] led,
    output display,
    output [7:0] tub_mode);
    
    assign boost_volume = control;
    
    wire [7:0] led_free, led_auto, led_learn, led_adjust;
    wire [1:0] range_indication_free, range_indication_auto, range_indication_learn, range_indication_adjust;
    
    wire [4:0] note_free_mode, note_autoplay_mode, note_learning_mode, note_adjust_mode;
    reg [4:0] note_buzzer;
    
    wire adjust_mode, learning_mode, autoplay_mode, free_mode;
    assign free_mode = ~select_mode[0] & ~select_mode[1];
    assign autoplay_mode = select_mode[0] & ~select_mode[1];
    assign learning_mode = ~select_mode[0] & select_mode[1];
    assign adjust_mode = select_mode[0] & select_mode[1];
    
    always @(*) begin
        case (select_mode)
            2'h0: begin 
                note_buzzer = note_free_mode; 
                led = led_free; 
                range_indication = range_indication_free;
            end
            2'h1: begin 
                note_buzzer = note_autoplay_mode; 
                led = led_auto; 
                range_indication = range_indication_auto;
            end
            2'h2: begin 
                note_buzzer = note_learning_mode; 
                led = led_learn; 
                range_indication = range_indication_learn;
            end
            2'h3: begin 
                note_buzzer = note_adjust_mode; 
                led = led_adjust; 
                range_indication = range_indication_adjust;
            end
        endcase
    end
    
    tub_mode mode_display(.in(select_mode), .display(display), .tub(tub_mode));
    
    
    buzzer buzz(.clk(clk), .note(note_buzzer), .speaker(speaker));
    
    free_mode u_free(.select(free_mode), .key(key), .range(range), .note(note_free_mode), .led(led_free), 
    .range_indication(range_indication_free));
    
    autoplay_mode u_auto(.clk(clk), .select(autoplay_mode), .led(led_auto), .note(note_autoplay_mode));
    
    learning_mod u_learn(.start(learning_mode), .clk(clk), .key(key), .buttons(buttons),
    .range(range), .buzzer_out(note_learning_mode), .led_note_out(led_learn), 
    .led_range_out(range_indication_learn));
    
endmodule
