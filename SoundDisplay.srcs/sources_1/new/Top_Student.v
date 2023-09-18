`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: WANG SHUYI
//  STUDENT A MATRICULATION NUMBER: A0199514U
//
//  STUDENT B NAME: WU YUXIN
//  STUDENT B MATRICULATION NUMBER: A0205199Y
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input [15:0] sw,        // Switches
    input CLOCK,            // Basys clock
    input btnC, btnL, btnR, // Pushbuttons
    input J_MIC3_Pin3,      // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,     // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,     // Connect to this signal from Audio_Capture.v
    output [7:0] JC,        // OLED display
    output reg [15:0] led = 0,
    output reg [3:0] an = 0,
    output reg [6:0] seg = 0,
    output dp               // Decimal on display
    );
    
    // sw[15] = 2 to 1 MUX, sw[14] = select border thickness
    // sw[13] = select theme 1, sw[12] = select theme 2
    // sw[0] = reset game, sw[1] = volume bar
    // sw[2] = connect4 game, sw[3] = interactive image 
    // sw[4] = static image, sw[5] = gif animation
    
/////////////////////////////////////////////////// 
    
//    reg [15:0] OLED_DATA = 16'h07E0; 
    reg offstate = 0;
    reg [11:0] ZERO_SIG = 0;
    reg [11:0] MIC_DATA = 0;
    reg [1:0] AN_PTR = 0; // For displaying different numbers on 2 separately anodes
    reg [11:0] COUNT = 0; // For slowing down change in volume display
    reg [15:0] PIXEL_DATA; // Main pixel data to send to OLED
    
    wire clk_20k, clk_6p25m, clk_sp;
    wire csout, out381;
    wire cout, lout, rout; // Debounced signals for pb
    wire RESET;
    wire [12:0] frame_begin, sending_pixels, sample_pixel, pixel_index;
    wire [4:0] teststate;
    wire [11:0] MIC_IN; // RAW data read by mic
    wire [11:0] SAMPLE; // MIC_IN if sw15 on
    wire [3:0] LED_INDEX; // displaying LEDs
    wire [6:0] SS1; // 7 segment display AN1
    wire [6:0] SS2; // 7 segment display AN0
    wire [3:0] VOLUME_LVL; // For volume bar, levels 0-15
    wire [15:0] BORDER, BACKGRD, COLOR_L, COLOR_M, COLOR_H; // Colors for volume bar
    wire [15:0] pixel_data1; // For volume bar
    wire [15:0] pixel_data2; // For game
    wire [15:0] pixel_data3; // For interactive image
    wire [15:0] pixel_data4; // For static image
    wire [15:0] pixel_data5; // For GIF

/////////////////////////////////////////////////// 
    
    mux1 MUX (sw[15], ZERO_SIG [11:0], MIC_IN [11:0], SAMPLE [11:0]);
    var_clk CLK_6p25m (CLOCK, 7, clk_6p25m);
    var_clk CLK_20k (CLOCK, 2499, clk_20k);
    var_clk CLK_SP (CLOCK, 65100, clk_sp);
    var_clk CLK_381 (CLOCK, 262143, out381);
    single_pulse BTN_C (btnC, out381, cout);
    single_pulse BTN_L (btnL, out381, lout);
    single_pulse BTN_R (btnR, out381, rout);
    
    Audio_Capture MIC_MOD (CLOCK, clk_20k, J_MIC3_Pin3,
        J_MIC3_Pin1, J_MIC3_Pin4, MIC_IN [11:0]);

    mic_task SORT_VOLUME (MIC_DATA [11:0], clk_20k, LED_INDEX [3:0], 
        SS1 [6:0], SS2 [6:0], VOLUME_LVL [3:0]);
        
    Oled_Display OLED_MOD (clk_6p25m, 0, frame_begin, 
        sending_pixels, sample_pixel, pixel_index, PIXEL_DATA, 
        JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], 
        teststate); 
        
    oled0 volbar(pixel_index, pixel_data1, VOLUME_LVL[3:0],
        BORDER, BACKGRD, COLOR_L, COLOR_M, COLOR_H,
        sw[14],sw[7], clk_20k);
        
    oled1 theme(clk_6p25m, sw [13:9], BORDER, 
        BACKGRD, COLOR_L, COLOR_M, COLOR_H);
    
    oledmod C4_game (pixel_index, pixel_data2, cout, lout, rout, out381, sw[0]);
        
    image VOL_IMG (pixel_index[12:0], clk_6p25m, VOLUME_LVL[3:0],
         pixel_data3[15:0]);
         
    doge STATIC_IMG (pixel_index[12:0], clk_6p25m, pixel_data4[15:0]);
    
    gif MOVING_IMG (pixel_index[12:0], clk_6p25m, pixel_data5[15:0]);
         
///////////////////////////////////////////////////    
    
    assign JC[2] = 0;
    assign dp = 1;
    
    always @ (*)
    begin
//        OLED_DATA[4:0] <= SAMPLE [11:7];
        if (sw[1] == 1 && sw[2] == 0 && sw[3] == 0 && sw[4] == 0 && sw[5] == 0)
            PIXEL_DATA <= pixel_data1;
        else if (sw[1] == 0 && sw[2] == 1 && sw[3] == 0 && sw[4] == 0 && sw[5] == 0)
            PIXEL_DATA <= pixel_data2;
        else if (sw[1] == 0 && sw[2] == 0 && sw[3] == 1 && sw[4] == 0 && sw[5] == 0)
            PIXEL_DATA <= pixel_data3;
        else if (sw[1] == 0 && sw[2] == 0 && sw[3] == 0 && sw[4] == 1 && sw[5] == 0)
            PIXEL_DATA <= pixel_data4;
        else if (sw[1] == 0 && sw[2] == 0 && sw[3] == 0 && sw[4] == 0 && sw[5] == 1)
            PIXEL_DATA <= pixel_data5;
        else
            PIXEL_DATA <= 0;
        case(LED_INDEX)
        4'd0: led <= 16'b0000000000000001;
        4'd1: led <= 16'b0000000000000011;
        4'd2: led <= 16'b0000000000000111;
        4'd3: led <= 16'b0000000000001111;
        4'd4: led <= 16'b0000000000011111;
        4'd5: led <= 16'b0000000000111111;
        4'd6: led <= 16'b0000000001111111;
        4'd7: led <= 16'b0000000011111111;
        4'd8: led <= 16'b0000000111111111;
        4'd9: led <= 16'b0000001111111111;
        4'd10: led <= 16'b0000011111111111;
        4'd11: led <= 16'b0000111111111111;
        4'd12: led <= 16'b0001111111111111;
        4'd13: led <= 16'b0011111111111111;
        4'd14: led <= 16'b0111111111111111;
        4'd15: led <= 16'b1111111111111111;
        endcase
    end
    
    always @ (posedge clk_20k)
    begin
        COUNT <= (COUNT == 2000) ? 0 : COUNT + 1;
        if (COUNT == 1999)
            MIC_DATA <= 0;
        else if (SAMPLE > MIC_DATA)
            MIC_DATA <= SAMPLE[11:0];
        case(AN_PTR)
        2'd0:
        begin
            an <= 4'b1101;
            seg <= SS1;
            AN_PTR <= AN_PTR + 1;
        end
        2'd1:
        begin
            an <= 4'b1110;
            seg <= SS2;
            AN_PTR <= AN_PTR + 1;
        end
        2'd2:
            AN_PTR <= 0;
        endcase
    end
   
    
endmodule