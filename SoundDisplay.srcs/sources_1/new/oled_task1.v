`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2020 01:27:18 PM
// Design Name: 
// Module Name: oled_task1
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

// THEME SELECT
module oled1(input clk, input [4:0] sw, output reg [15:0] BD, 
    BG, L, M, H);
    
    // Default
    localparam BLACK = 16'b0;
    localparam WHITE = 16'b1111111111111111;
    localparam GREEN = 16'b0000011111100000;
    localparam RED = 16'b1111100000000000;
    localparam YELLOW = 16'b1111111111100000;
    
    //inverted colour
    localparam BD1 = 16'b0;
    localparam BG1 = 16'b1111111111111111;
    localparam L1 = 16'b1111100000011111;
    localparam M1 = 16'b0000011111111111;
    localparam H1 = 16'b0000000000011111;
    
    //blue-ish
    localparam BD2 = 16'b1111111111111111;
    localparam BG2 = 16'b0;
    localparam L2 = 16'b0000011001111001;
    localparam M2 = 16'b0000001001110011;
    localparam H2 = 16'b0000000000010011;
    
    always @ (posedge clk) begin
        case(sw[4:3])
            2'b01:
            begin
                if(sw[2]==1)
                BD=BLACK;
                else
                BD = BD1;
                
                if(sw[0]==1)
                BG=BLACK;
                else
                BG = BG1;
                
                if(sw[1]==1) begin
                L=BLACK;
                M=BLACK;
                H=BLACK;
                end
                else begin
                L = L1;
                M = M1;
                H = H1;
                end
            end
            2'b10:
            begin  
                if(sw[2]==1)
                BD=BLACK;
                else
                BD = BD2;
                
                if(sw[0]==1)
                BG=BLACK;
                else
                BG = BG2;
                
                if(sw[1]==1) begin
                L=BLACK;
                M=BLACK;
                H=BLACK;
                end
                else begin
                L = L2;
                M = M2;
                H = H2;
                end
            end
            default: 
            begin 
                if(sw[2]==1)
                BD=BLACK;
                else
                BD = WHITE;
                
                BG=BLACK;

                if(sw[1]==1) begin
                L=BLACK;
                M=BLACK;
                H=BLACK;
                end
                else begin
                L = GREEN;
                M = YELLOW;
                H = RED;
                end
            end
        endcase
        
        if(sw[2]==1)
            BD=BLACK;
        else
        
        if(sw[1]==1) begin
            L=BLACK;
            M=BLACK;
            H=BLACK;
        end
        if(sw[0]==1)
            BG=BLACK;
            
    end
endmodule
