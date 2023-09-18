`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 06:54:07 PM
// Design Name: 
// Module Name: single_pulse
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


module single_pulse(input pb, sp_clock, output sp_out);

    wire dff_one_out;
    wire dff_two_out;
    
    dff_mod DFF_1 (.dff_clock(sp_clock), .D(pb), .Q(dff_one_out));
    dff_mod DFF_2 (.dff_clock(sp_clock), .D(dff_one_out), .Q(dff_two_out));
    
    assign sp_out = dff_one_out & ~dff_two_out;

endmodule
