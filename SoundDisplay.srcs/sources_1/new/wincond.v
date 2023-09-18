`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 02:05:45 PM
// Design Name: 
// Module Name: wincond
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


module wincond(input c1,c2,c3,c4,d1,d2,d3,d4,output reg [1:0] pwin, input clock);
    always @ (posedge clock) begin
        if(d1==1 && d2==1 && d3==1 && d4 ==1) begin
            if(c1==0 && c2==0 && c3==0 && c4==0)
                pwin = 2'd1;
            else if(c1==1 && c2==1 && c3==1 && c4==1)
                pwin = 2'd2;
            else 
                pwin = 2'd0;
        end
        else
            pwin=2'd0;
    end
endmodule
