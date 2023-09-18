`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2020 08:47:46 PM
// Design Name: 
// Module Name: mic_task
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

// MIC TASK
// lower bound = 1845
// uupper bound = 4095
// diff per interval = 150
module mic_task(input [11:0] DATA, input clk, output reg [3:0] led,
    output reg [6:0] SS1, output reg [6:0] SS2, output reg [3:0] VOL);

    always @ (posedge clk)
    begin
        if (DATA < 1846) // led 0 lights up, seven segment displays 00
        begin
//            led <= 16'b0000000000000001;
            led <= 4'd0;
            SS1 <= 7'b1000000;
            SS2 <= 7'b1000000;
            VOL <= 4'd0;
        end
        else if (DATA > 1845 & DATA < 1996) // 1
        begin
//            led <= 16'b0000000000000011;
            led <= 4'd1;
            SS1 <= 7'b1000000;
            SS2 <= 7'b1111001;
            VOL <= 4'd1;
        end
        else if (DATA > 1995 & DATA < 2146) // 2
        begin
//            led <= 16'b0000000000000111;
            led <= 4'd2;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0100100;
            VOL <= 4'd2;
        end
        else if (DATA > 2145 & DATA < 2296) // 3
        begin
//            led <= 16'b0000000000001111;
            led <= 4'd3;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0110000;
            VOL <= 4'd3;
        end
        else if (DATA > 2295 & DATA < 2446) // 4
        begin
//            led <= 16'b0000000000011111;
            led <= 4'd4;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0011001;
            VOL <= 4'd4;
        end
        else if (DATA > 2445 & DATA < 2596) // 5
        begin
//            led <= 16'b0000000000111111;
            led <= 4'd5;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0010010;
            VOL <= 4'd5;
        end
        else if (DATA > 2595 & DATA < 2746) // 6
        begin
//            led <= 16'b0000000001111111;
            led <= 4'd6;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0000010;
            VOL <= 4'd6;
        end
        else if (DATA > 2746 & DATA < 2896) // 7
        begin
//            led <= 16'b0000000011111111;
            led <= 4'd7;
            SS1 <= 7'b1000000;
            SS2 <= 7'b1111000;
            VOL <= 4'd7;
        end
        else if (DATA > 2895 & DATA < 3046) // 8
        begin
//            led <= 16'b0000000111111111;
            led <= 4'd8;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0000000;
            VOL <= 4'd8;
        end
        else if (DATA > 3045 & DATA < 3196) // 9
        begin
//            led <= 16'b0000001111111111;
            led <= 4'd9;
            SS1 <= 7'b1000000;
            SS2 <= 7'b0010000;
            VOL <= 4'd9;
        end
        else if (DATA > 3195 & DATA < 3346) // 10
        begin
//            led <= 16'b0000011111111111;
            led <= 4'd10;
            SS1 <= 7'b1111001;
            SS2 <= 7'b1000000;
            VOL <= 4'd10;
        end
        else if (DATA > 3345 & DATA < 3496) // 11
        begin
//            led <= 16'b0000111111111111;
            led <= 4'd11;
            SS1 <= 7'b1111001;
            SS2 <= 7'b1111001;
            VOL <= 4'd11;
        end
        else if (DATA > 3495 & DATA < 3646) // 12
        begin
//            led <= 16'b0001111111111111;
            led <= 4'd12;
            SS1 <= 7'b1111001;
            SS2 <= 7'b0100100;
            VOL <= 4'd12;
        end
        else if (DATA > 3645 & DATA < 3796) // 13
        begin
//            led <= 16'b0011111111111111;
            led <= 4'd13;
            SS1 <= 7'b1111001;
            SS2 <= 7'b0110000;
            VOL <= 4'd13;
        end
        else if (DATA > 3795 & DATA < 3946) // 14
        begin
//            led <= 16'b0111111111111111;
            led <= 4'd14;
            SS1 <= 7'b1111001;
            SS2 <= 7'b0011001;
            VOL <= 4'd14;
        end
        else if (DATA > 3945)// 15
        begin
//            led <= 16'b1111111111111111;
            led <= 4'd15;
            SS1 <= 7'b1111001;
            SS2 <= 7'b0010010;
            VOL <= 4'd15;
        end
    end

endmodule
