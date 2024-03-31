

module learning_mod(
    input start,
    input clk,
    input wire [7:0] key,
    input wire [1:0] range,
    input wire [2:0] buttons,
    output[7:0] buzzer_out,
    output[7:0] led_note_out,
    output[1:0] led_range_out,
    output[1:0] rank);
    
    wire [2:0] debounced_button;
    Debounce debouncer(.clk(clk),.buttons(buttons),.debouncedbuttons(debounced_button));
    
    reg[1:0]music_num = 0;
    reg[1:0]ranks=0;
    reg[6:0]note_num = 0;
    
    wire[6:0]sum_of_note;
    wire[7:0]note_fetch;
    wire[7:0]fetch_led;
    wire[2:0]chosen_key;
    
    music musica(.music_number(music_num), .entry_number(note_num),
    .info(note_fetch), .entry(sum_of_note));
    
    led_encode encodeled(.key(note_fetch[2:0]), .chosen_led(fetch_led));
    
    key_encode encodekey(.key(key), .chosen_key(chosen_key));
    
    
    reg [7:0] temp_out = 0;
    reg [1:0] range_led = 0;
    reg [7:0] note_led = 0;
    reg[3:0] state = 0;
    reg[10:0] mistake=0;
    
    always@(posedge clk) begin
        if (start) begin
            if (state == 3'b000) begin
                music_num <= 0;
                note_num <= 0;
                temp_out <= 0;
                state <= 3'b001;
            end
            else if (state == 3'b001) begin
                if (debounced_button[1] == 1) begin
                    state <= 3'b010;
                end
                else if (debounced_button[0] == 1 && music_num > 1) begin
                    state <= 3'b011;
                end 
                else if (debounced_button[2] == 1 && music_num < 3)begin
                    state <= 3'b100;
                end
            end
            else if (state == 3'b011) begin
                music_num <= music_num - 1;
                state <= 3'b001;
            end
            else if (state == 3'b100) begin
                music_num <= music_num + 1;
                state <= 3'b001;  
            end
            else if (state == 3'b010) begin
                range_led <= note_fetch[4:3];
                note_led <= fetch_led;
                temp_out <= {3'b111, range, chosen_key};
                if (debounced_button[1] == 1) begin
                    if (range_led == range && note_fetch[2:0] == chosen_key) begin
                      if (note_num < sum_of_note) state <= 3'b110;
                      else state <= 3'b000;
                    end
                    else begin
                      mistake <= mistake + 1;
                      state <= 3'b111;
                    end
                end
            end
            else if (state == 3'b110) begin
                note_num <= note_num + 1;
                state <= 3'b010;
            end
            else if (state == 3'b111) state <= 3'b010;
        end
    end
    
    
    always@(*) begin
        if (mistake == 0) ranks = 1;
        else if (mistake < 3) ranks = 2;
        else ranks = 3;
    end
    
    assign buzzer_out = temp_out;
    assign led_note_out = note_led;
    assign led_range_out = range_led;
    assign rank = ranks;
endmodule