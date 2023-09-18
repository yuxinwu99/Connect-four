`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 06:54:38 PM
// Design Name: 
// Module Name: variable_clk
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


module var_clk(input CLOCK, [32:0] m, output reg myclk = 0);
    
    reg [12:0] count = 0;
    
    always @ (posedge CLOCK)
    begin   
        count <= (count == m) ? 0 : count + 1;
        myclk <= (count == 0) ? ~myclk : myclk;
    end
endmodule
