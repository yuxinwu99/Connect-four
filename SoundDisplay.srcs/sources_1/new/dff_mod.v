`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 09:45:53 PM
// Design Name: 
// Module Name: dff_mod
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


module dff_mod(input dff_clock, D, output reg Q = 0);

    always @ (posedge dff_clock)
    begin
        Q <= D;
    end

endmodule
