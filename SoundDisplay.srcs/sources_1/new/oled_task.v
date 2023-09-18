`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2020 04:48:03 PM
// Design Name: 
// Module Name: oled_task
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


module oled0(pixel_index, pixel_data, vol, BD, 
    BG, L, M, H, sw, freeze,clk);

    input [12:0]pixel_index;
    output reg [15:0]pixel_data;
    input [15:0]BD, BG, L, M, H;
    input sw,freeze,clk;
    wire [1:0] BDsize;
    reg [15:0] min, x, y, gap;
    input [3:0] vol;
    reg [3:0]sample;
    reg rate=0;
    wire [3:0] temp;
    assign BDsize = (sw==1)? 3 : 1;
    
    dff bit0(rate,vol[0],temp[0]);
    dff bit1(rate,vol[1],temp[1]);
    dff bit2(rate,vol[2],temp[2]);
    dff bit3(rate,vol[3],temp[3]);
    
    
    always @(pixel_index)begin
    
        case(freeze)
        1'd0: begin rate= clk; sample=vol; end
        1'd1: begin rate= 0; sample=temp; end
        endcase
        x = pixel_index % 96;
        y = pixel_index /96;
        min = 53 - sample*3;
        gap = (y - 5) % 3;
        if(y > min && gap != 0 && x>44 && x<53 && y>8 && y<24)
            pixel_data = H;
        else if(y > min && gap != 0 && x>44 && x<53 && y>23 && y <39)
            pixel_data = M;
        else if(y > min && gap != 0 && x>44 && x<53 && y>38 && y<57)
            pixel_data = L;
        else if((x<BDsize) || (y<BDsize) || (x>95-BDsize) || (y >63-BDsize))
            pixel_data = BD;
        else
            pixel_data = BG;
    end
endmodule
