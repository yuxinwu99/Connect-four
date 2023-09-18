`timescale 1ns / 1ps

module oledmod(pixel_index,pixel_data,c,l,r,clk,reset);
    input c,l,r,clk,reset;
    input [12:0] pixel_index;
    output reg [15:0] pixel_data;
    reg player=0;
    reg[2:0] temp;
    reg [6:0]data[6:0];
    reg [6:0]colour[6:0];
    reg [2:0]dir=0;
    reg [15:0] x, y, location;
    reg [2:0]pos=0;
    reg[3:0]hi,hj,vi,vj,ldrui,ldruj,lurdi,lurdj;
    wire [1:0]pwinv,pwinh,pwinlurd,pwinldru;
    reg [1:0]pwinfinal;
    
    initial begin
    data[0]=8'd0;
    data[1]=8'd0;
    data[2]=8'd0;
    data[3]=8'd0;
    data[4]=8'd0;
    data[5]=8'd0;
    data[6]=8'd0;
    colour[0]=8'd0;
    colour[1]=8'd0;
    colour[2]=8'd0;
    colour[3]=8'd0;
    colour[4]=8'd0;
    colour[5]=8'd0;
    colour[6]=8'd0;
    end
        
    wincond hori(colour[hi][hj],colour[hi][hj+1],colour[hi][hj+2],colour[hi][hj+3],data[hi][hj],data[hi][hj+1],data[hi][hj+2],data[hi][hj+3],pwinv,clk);
    wincond verti(colour[vi][vj],colour[vi+1][vj],colour[vi+2][vj],colour[vi+3][vj],data[vi][vj],data[vi+1][vj],data[vi+2][vj],data[vi+3][vj],pwinh,clk);
    wincond ldru(colour[ldrui][ldruj],colour[ldrui+1][ldruj+1],colour[ldrui+2][ldruj+2],colour[ldrui+3][ldruj+3],data[ldrui][ldruj],data[ldrui+1][ldruj+1],data[ldrui+2][ldruj+2],data[ldrui+3][ldruj+3],pwinldru,clk);
    wincond lurd(colour[lurdi][lurdj],colour[lurdi-1][lurdj+1],colour[lurdi-2][lurdj+2],colour[lurdi-3][lurdj+3],data[lurdi][lurdj],data[lurdi-1][lurdj+1],data[lurdi-2][lurdj+2],data[lurdi-3][lurdj+3],pwinlurd,clk);
    
    always @ (posedge clk) begin
        if(r==1) begin
        dir<=(dir==3'd6)? 0 : dir+1;
        pos<=(pos==3'd6)? 0 : pos+1;
        end
        if(l==1) begin
        dir<=(dir==0)? 6 : dir-1;
        pos<=(pos==0)? 6 : pos-1;
        end
    end
    
    always @(pixel_index)begin
            
        x <= pixel_index % 96;
        y <= pixel_index / 96;
        
        hi<=(7-(y/8)>5)? 5 :7-(y/8);
        hj<=((x/8)-2>3)? 3:(x/8)-2;
        
        vi<=(7-(y/8)>2)? 2:7-(y/8);
        vj<=((x/8)-2>6)? 6:(x/8)-2;
        
        ldrui<=(7-(y/8)>2)? 2 :7-(y/8);
        ldruj<=((x/8)-2>3)? 3 :(x/8)-2;
        
        lurdi<=(7-(y/8)<4)? 4 :7-(y/8);
        lurdj<=((x/8)-2>3)? 3 :(x/8)-2;
        

        if (reset==1)begin
                pwinfinal=0;
        end 
        
        if(y<=11 && y >4 && x>= location && x < location+7 && pwinfinal == 0) 
            temp = player;
        else if((pwinfinal == 2'd2 || pwinfinal == 2'd1) && y<13)begin
        
                if(pwinv[1:0]==2'd2 || pwinv[1:0]==2'd1)
                    pwinfinal=pwinv;
                else if(pwinh[1:0]==2'd2 || pwinh[1:0]==2'd1)
                    pwinfinal=pwinh;
                else if (pwinlurd[1:0]==2'd2 || pwinlurd[1:0]==2'd1)
                     pwinfinal=pwinlurd;
                else if(pwinldru[1:0]==2'd2 || pwinldru[1:0]==2'd1)
                    pwinfinal=pwinldru;
                    
                if(pwinfinal==2'd1) begin
                case (pixel_index)
                            13'd0: pixel_data <= 16'h0;
                            13'd1: pixel_data <= 16'h0;
                            13'd2: pixel_data <= 16'h0;
                            13'd3: pixel_data <= 16'h0;
                            13'd4: pixel_data <= 16'h0;
                            13'd5: pixel_data <= 16'h0;
                            13'd6: pixel_data <= 16'h0;
                            13'd7: pixel_data <= 16'h0;
                            13'd8: pixel_data <= 16'h0;
                            13'd9: pixel_data <= 16'h0;
                            13'd10: pixel_data <= 16'h0;
                            13'd11: pixel_data <= 16'h0;
                            13'd12: pixel_data <= 16'h0;
                            13'd13: pixel_data <= 16'h0;
                            13'd14: pixel_data <= 16'h0;
                            13'd15: pixel_data <= 16'h0;
                            13'd16: pixel_data <= 16'h0;
                            13'd17: pixel_data <= 16'h0;
                            13'd18: pixel_data <= 16'h2000;
                            13'd19: pixel_data <= 16'hA1E8;
                            13'd20: pixel_data <= 16'hA986;
                            13'd21: pixel_data <= 16'hAA07;
                            13'd22: pixel_data <= 16'h9207;
                            13'd23: pixel_data <= 16'h2800;
                            13'd24: pixel_data <= 16'h3000;
                            13'd25: pixel_data <= 16'h3800;
                            13'd26: pixel_data <= 16'h99C8;
                            13'd27: pixel_data <= 16'hA9E8;
                            13'd28: pixel_data <= 16'hA1C7;
                            13'd29: pixel_data <= 16'hA1E7;
                            13'd30: pixel_data <= 16'h9208;
                            13'd31: pixel_data <= 16'h1800;
                            13'd32: pixel_data <= 16'h2000;
                            13'd33: pixel_data <= 16'hA1C7;
                            13'd34: pixel_data <= 16'hB187;
                            13'd35: pixel_data <= 16'hA9C8;
                            13'd36: pixel_data <= 16'h9A09;
                            13'd37: pixel_data <= 16'h2800;
                            13'd38: pixel_data <= 16'h1800;
                            13'd39: pixel_data <= 16'h1000;
                            13'd40: pixel_data <= 16'h0;
                            13'd41: pixel_data <= 16'h0;
                            13'd42: pixel_data <= 16'h1000;
                            13'd43: pixel_data <= 16'h8A49;
                            13'd44: pixel_data <= 16'h4800;
                            13'd45: pixel_data <= 16'h5000;
                            13'd46: pixel_data <= 16'h9229;
                            13'd47: pixel_data <= 16'h1800;
                            13'd48: pixel_data <= 16'h1000;
                            13'd49: pixel_data <= 16'h8A29;
                            13'd50: pixel_data <= 16'h4000;
                            13'd51: pixel_data <= 16'h3000;
                            13'd52: pixel_data <= 16'h9209;
                            13'd53: pixel_data <= 16'hA9C8;
                            13'd54: pixel_data <= 16'hB186;
                            13'd55: pixel_data <= 16'hA9C7;
                            13'd56: pixel_data <= 16'h9A08;
                            13'd57: pixel_data <= 16'h1800;
                            13'd58: pixel_data <= 16'h1800;
                            13'd59: pixel_data <= 16'h9A07;
                            13'd60: pixel_data <= 16'h4800;
                            13'd61: pixel_data <= 16'h2000;
                            13'd62: pixel_data <= 16'h1800;
                            13'd63: pixel_data <= 16'h9229;
                            13'd64: pixel_data <= 16'h4000;
                            13'd65: pixel_data <= 16'h2800;
                            13'd66: pixel_data <= 16'h2800;
                            13'd67: pixel_data <= 16'h9A08;
                            13'd68: pixel_data <= 16'hA1E8;
                            13'd69: pixel_data <= 16'hA1E8;
                            13'd70: pixel_data <= 16'h9208;
                            13'd71: pixel_data <= 16'h1800;
                            13'd72: pixel_data <= 16'h2000;
                            13'd73: pixel_data <= 16'hA9A7;
                            13'd74: pixel_data <= 16'hA9A7;
                            13'd75: pixel_data <= 16'h2800;
                            13'd76: pixel_data <= 16'h800;
                            13'd77: pixel_data <= 16'h0;
                            13'd78: pixel_data <= 16'h0;
                            13'd79: pixel_data <= 16'h0;
                            13'd80: pixel_data <= 16'h0;
                            13'd81: pixel_data <= 16'h0;
                            13'd82: pixel_data <= 16'h0;
                            13'd83: pixel_data <= 16'h0;
                            13'd84: pixel_data <= 16'h0;
                            13'd85: pixel_data <= 16'h0;
                            13'd86: pixel_data <= 16'h0;
                            13'd87: pixel_data <= 16'h0;
                            13'd88: pixel_data <= 16'h0;
                            13'd89: pixel_data <= 16'h0;
                            13'd90: pixel_data <= 16'h0;
                            13'd91: pixel_data <= 16'h0;
                            13'd92: pixel_data <= 16'h0;
                            13'd93: pixel_data <= 16'h0;
                            13'd94: pixel_data <= 16'h0;
                            13'd95: pixel_data <= 16'h0;
                            13'd96: pixel_data <= 16'h0;
                            13'd97: pixel_data <= 16'h0;
                            13'd98: pixel_data <= 16'h0;
                            13'd99: pixel_data <= 16'h0;
                            13'd100: pixel_data <= 16'h0;
                            13'd101: pixel_data <= 16'h0;
                            13'd102: pixel_data <= 16'h0;
                            13'd103: pixel_data <= 16'h0;
                            13'd104: pixel_data <= 16'h0;
                            13'd105: pixel_data <= 16'h0;
                            13'd106: pixel_data <= 16'h0;
                            13'd107: pixel_data <= 16'h0;
                            13'd108: pixel_data <= 16'h0;
                            13'd109: pixel_data <= 16'h0;
                            13'd110: pixel_data <= 16'h0;
                            13'd111: pixel_data <= 16'h20;
                            13'd112: pixel_data <= 16'h20;
                            13'd113: pixel_data <= 16'h21;
                            13'd114: pixel_data <= 16'h1800;
                            13'd115: pixel_data <= 16'hA1A8;
                            13'd116: pixel_data <= 16'h5800;
                            13'd117: pixel_data <= 16'h3000;
                            13'd118: pixel_data <= 16'h3000;
                            13'd119: pixel_data <= 16'h9A08;
                            13'd120: pixel_data <= 16'h5800;
                            13'd121: pixel_data <= 16'h6000;
                            13'd122: pixel_data <= 16'hA9E8;
                            13'd123: pixel_data <= 16'h4000;
                            13'd124: pixel_data <= 16'h2800;
                            13'd125: pixel_data <= 16'h2000;
                            13'd126: pixel_data <= 16'h1800;
                            13'd127: pixel_data <= 16'h800;
                            13'd128: pixel_data <= 16'h2000;
                            13'd129: pixel_data <= 16'h99E7;
                            13'd130: pixel_data <= 16'h5800;
                            13'd131: pixel_data <= 16'h3000;
                            13'd132: pixel_data <= 16'h2800;
                            13'd133: pixel_data <= 16'h9A09;
                            13'd134: pixel_data <= 16'h4000;
                            13'd135: pixel_data <= 16'h2000;
                            13'd136: pixel_data <= 16'h800;
                            13'd137: pixel_data <= 16'h800;
                            13'd138: pixel_data <= 16'h1800;
                            13'd139: pixel_data <= 16'h91E8;
                            13'd140: pixel_data <= 16'h6000;
                            13'd141: pixel_data <= 16'h6000;
                            13'd142: pixel_data <= 16'h99E8;
                            13'd143: pixel_data <= 16'h1800;
                            13'd144: pixel_data <= 16'h2000;
                            13'd145: pixel_data <= 16'h9A09;
                            13'd146: pixel_data <= 16'h4800;
                            13'd147: pixel_data <= 16'h2800;
                            13'd148: pixel_data <= 16'h2800;
                            13'd149: pixel_data <= 16'h5800;
                            13'd150: pixel_data <= 16'hA9E7;
                            13'd151: pixel_data <= 16'h3800;
                            13'd152: pixel_data <= 16'h2000;
                            13'd153: pixel_data <= 16'h800;
                            13'd154: pixel_data <= 16'h2800;
                            13'd155: pixel_data <= 16'hB9C6;
                            13'd156: pixel_data <= 16'hB165;
                            13'd157: pixel_data <= 16'h3000;
                            13'd158: pixel_data <= 16'h2000;
                            13'd159: pixel_data <= 16'h99E8;
                            13'd160: pixel_data <= 16'h6000;
                            13'd161: pixel_data <= 16'h5000;
                            13'd162: pixel_data <= 16'h9207;
                            13'd163: pixel_data <= 16'h3000;
                            13'd164: pixel_data <= 16'h2800;
                            13'd165: pixel_data <= 16'h2000;
                            13'd166: pixel_data <= 16'h1800;
                            13'd167: pixel_data <= 16'h800;
                            13'd168: pixel_data <= 16'h3000;
                            13'd169: pixel_data <= 16'hB966;
                            13'd170: pixel_data <= 16'hC1A6;
                            13'd171: pixel_data <= 16'h3000;
                            13'd172: pixel_data <= 16'h800;
                            13'd173: pixel_data <= 16'h0;
                            13'd174: pixel_data <= 16'h0;
                            13'd175: pixel_data <= 16'h0;
                            13'd176: pixel_data <= 16'h0;
                            13'd177: pixel_data <= 16'h0;
                            13'd178: pixel_data <= 16'h0;
                            13'd179: pixel_data <= 16'h0;
                            13'd180: pixel_data <= 16'h0;
                            13'd181: pixel_data <= 16'h0;
                            13'd182: pixel_data <= 16'h0;
                            13'd183: pixel_data <= 16'h0;
                            13'd184: pixel_data <= 16'h0;
                            13'd185: pixel_data <= 16'h0;
                            13'd186: pixel_data <= 16'h0;
                            13'd187: pixel_data <= 16'h0;
                            13'd188: pixel_data <= 16'h0;
                            13'd189: pixel_data <= 16'h0;
                            13'd190: pixel_data <= 16'h0;
                            13'd191: pixel_data <= 16'h0;
                            13'd192: pixel_data <= 16'h0;
                            13'd193: pixel_data <= 16'h0;
                            13'd194: pixel_data <= 16'h0;
                            13'd195: pixel_data <= 16'h0;
                            13'd196: pixel_data <= 16'h0;
                            13'd197: pixel_data <= 16'h0;
                            13'd198: pixel_data <= 16'h0;
                            13'd199: pixel_data <= 16'h0;
                            13'd200: pixel_data <= 16'h0;
                            13'd201: pixel_data <= 16'h0;
                            13'd202: pixel_data <= 16'h0;
                            13'd203: pixel_data <= 16'h0;
                            13'd204: pixel_data <= 16'h0;
                            13'd205: pixel_data <= 16'h0;
                            13'd206: pixel_data <= 16'h0;
                            13'd207: pixel_data <= 16'h0;
                            13'd208: pixel_data <= 16'h0;
                            13'd209: pixel_data <= 16'h0;
                            13'd210: pixel_data <= 16'h2000;
                            13'd211: pixel_data <= 16'hA9A8;
                            13'd212: pixel_data <= 16'h6800;
                            13'd213: pixel_data <= 16'h4000;
                            13'd214: pixel_data <= 16'h3800;
                            13'd215: pixel_data <= 16'hA1C7;
                            13'd216: pixel_data <= 16'h6800;
                            13'd217: pixel_data <= 16'h7000;
                            13'd218: pixel_data <= 16'hA987;
                            13'd219: pixel_data <= 16'h4000;
                            13'd220: pixel_data <= 16'h2800;
                            13'd221: pixel_data <= 16'h2000;
                            13'd222: pixel_data <= 16'h1000;
                            13'd223: pixel_data <= 16'h800;
                            13'd224: pixel_data <= 16'h2000;
                            13'd225: pixel_data <= 16'h99C7;
                            13'd226: pixel_data <= 16'h5000;
                            13'd227: pixel_data <= 16'h2800;
                            13'd228: pixel_data <= 16'h2800;
                            13'd229: pixel_data <= 16'hA1C8;
                            13'd230: pixel_data <= 16'h5000;
                            13'd231: pixel_data <= 16'h2000;
                            13'd232: pixel_data <= 16'h800;
                            13'd233: pixel_data <= 16'h0;
                            13'd234: pixel_data <= 16'h1800;
                            13'd235: pixel_data <= 16'hA1E8;
                            13'd236: pixel_data <= 16'h7000;
                            13'd237: pixel_data <= 16'h6800;
                            13'd238: pixel_data <= 16'hA1E8;
                            13'd239: pixel_data <= 16'h2800;
                            13'd240: pixel_data <= 16'h2000;
                            13'd241: pixel_data <= 16'hA1E8;
                            13'd242: pixel_data <= 16'h5000;
                            13'd243: pixel_data <= 16'h2000;
                            13'd244: pixel_data <= 16'h2000;
                            13'd245: pixel_data <= 16'h4800;
                            13'd246: pixel_data <= 16'h99C7;
                            13'd247: pixel_data <= 16'h2000;
                            13'd248: pixel_data <= 16'h800;
                            13'd249: pixel_data <= 16'h800;
                            13'd250: pixel_data <= 16'h2800;
                            13'd251: pixel_data <= 16'hB165;
                            13'd252: pixel_data <= 16'hC985;
                            13'd253: pixel_data <= 16'h4800;
                            13'd254: pixel_data <= 16'h3800;
                            13'd255: pixel_data <= 16'hA9A7;
                            13'd256: pixel_data <= 16'h7000;
                            13'd257: pixel_data <= 16'h6000;
                            13'd258: pixel_data <= 16'hA207;
                            13'd259: pixel_data <= 16'h3000;
                            13'd260: pixel_data <= 16'h2000;
                            13'd261: pixel_data <= 16'h1800;
                            13'd262: pixel_data <= 16'h1000;
                            13'd263: pixel_data <= 16'h800;
                            13'd264: pixel_data <= 16'h3000;
                            13'd265: pixel_data <= 16'hC945;
                            13'd266: pixel_data <= 16'hC945;
                            13'd267: pixel_data <= 16'h3000;
                            13'd268: pixel_data <= 16'h800;
                            13'd269: pixel_data <= 16'h0;
                            13'd270: pixel_data <= 16'h0;
                            13'd271: pixel_data <= 16'h0;
                            13'd272: pixel_data <= 16'h0;
                            13'd273: pixel_data <= 16'h0;
                            13'd274: pixel_data <= 16'h0;
                            13'd275: pixel_data <= 16'h0;
                            13'd276: pixel_data <= 16'h0;
                            13'd277: pixel_data <= 16'h0;
                            13'd278: pixel_data <= 16'h0;
                            13'd279: pixel_data <= 16'h0;
                            13'd280: pixel_data <= 16'h0;
                            13'd281: pixel_data <= 16'h0;
                            13'd282: pixel_data <= 16'h0;
                            13'd283: pixel_data <= 16'h0;
                            13'd284: pixel_data <= 16'h0;
                            13'd285: pixel_data <= 16'h0;
                            13'd286: pixel_data <= 16'h0;
                            13'd287: pixel_data <= 16'h0;
                            13'd288: pixel_data <= 16'h0;
                            13'd289: pixel_data <= 16'h0;
                            13'd290: pixel_data <= 16'h0;
                            13'd291: pixel_data <= 16'h0;
                            13'd292: pixel_data <= 16'h0;
                            13'd293: pixel_data <= 16'h0;
                            13'd294: pixel_data <= 16'h0;
                            13'd295: pixel_data <= 16'h0;
                            13'd296: pixel_data <= 16'h0;
                            13'd297: pixel_data <= 16'h0;
                            13'd298: pixel_data <= 16'h0;
                            13'd299: pixel_data <= 16'h0;
                            13'd300: pixel_data <= 16'h0;
                            13'd301: pixel_data <= 16'h0;
                            13'd302: pixel_data <= 16'h0;
                            13'd303: pixel_data <= 16'h20;
                            13'd304: pixel_data <= 16'h0;
                            13'd305: pixel_data <= 16'h0;
                            13'd306: pixel_data <= 16'h2000;
                            13'd307: pixel_data <= 16'hB1A7;
                            13'd308: pixel_data <= 16'h7800;
                            13'd309: pixel_data <= 16'h6000;
                            13'd310: pixel_data <= 16'h5000;
                            13'd311: pixel_data <= 16'hA208;
                            13'd312: pixel_data <= 16'h5000;
                            13'd313: pixel_data <= 16'h6000;
                            13'd314: pixel_data <= 16'hB9A7;
                            13'd315: pixel_data <= 16'h5800;
                            13'd316: pixel_data <= 16'h5000;
                            13'd317: pixel_data <= 16'h5000;
                            13'd318: pixel_data <= 16'h4000;
                            13'd319: pixel_data <= 16'h1800;
                            13'd320: pixel_data <= 16'h2000;
                            13'd321: pixel_data <= 16'hAA08;
                            13'd322: pixel_data <= 16'h5000;
                            13'd323: pixel_data <= 16'h2000;
                            13'd324: pixel_data <= 16'h2000;
                            13'd325: pixel_data <= 16'hA1E8;
                            13'd326: pixel_data <= 16'h5000;
                            13'd327: pixel_data <= 16'h1800;
                            13'd328: pixel_data <= 16'h800;
                            13'd329: pixel_data <= 16'h820;
                            13'd330: pixel_data <= 16'h1800;
                            13'd331: pixel_data <= 16'hA1E8;
                            13'd332: pixel_data <= 16'h6800;
                            13'd333: pixel_data <= 16'h6800;
                            13'd334: pixel_data <= 16'h99C7;
                            13'd335: pixel_data <= 16'h2000;
                            13'd336: pixel_data <= 16'h2800;
                            13'd337: pixel_data <= 16'hA1C8;
                            13'd338: pixel_data <= 16'h5800;
                            13'd339: pixel_data <= 16'h2000;
                            13'd340: pixel_data <= 16'h2000;
                            13'd341: pixel_data <= 16'h5000;
                            13'd342: pixel_data <= 16'hAA09;
                            13'd343: pixel_data <= 16'h2000;
                            13'd344: pixel_data <= 16'h800;
                            13'd345: pixel_data <= 16'h821;
                            13'd346: pixel_data <= 16'h2000;
                            13'd347: pixel_data <= 16'hA1C7;
                            13'd348: pixel_data <= 16'h7000;
                            13'd349: pixel_data <= 16'hB1A7;
                            13'd350: pixel_data <= 16'h6800;
                            13'd351: pixel_data <= 16'hB166;
                            13'd352: pixel_data <= 16'h6800;
                            13'd353: pixel_data <= 16'h4800;
                            13'd354: pixel_data <= 16'h9A28;
                            13'd355: pixel_data <= 16'h5800;
                            13'd356: pixel_data <= 16'h5000;
                            13'd357: pixel_data <= 16'h3800;
                            13'd358: pixel_data <= 16'h2000;
                            13'd359: pixel_data <= 16'h1000;
                            13'd360: pixel_data <= 16'h3800;
                            13'd361: pixel_data <= 16'hC945;
                            13'd362: pixel_data <= 16'hC945;
                            13'd363: pixel_data <= 16'h3000;
                            13'd364: pixel_data <= 16'h800;
                            13'd365: pixel_data <= 16'h0;
                            13'd366: pixel_data <= 16'h0;
                            13'd367: pixel_data <= 16'h0;
                            13'd368: pixel_data <= 16'h0;
                            13'd369: pixel_data <= 16'h0;
                            13'd370: pixel_data <= 16'h0;
                            13'd371: pixel_data <= 16'h0;
                            13'd372: pixel_data <= 16'h0;
                            13'd373: pixel_data <= 16'h0;
                            13'd374: pixel_data <= 16'h0;
                            13'd375: pixel_data <= 16'h0;
                            13'd376: pixel_data <= 16'h0;
                            13'd377: pixel_data <= 16'h0;
                            13'd378: pixel_data <= 16'h0;
                            13'd379: pixel_data <= 16'h0;
                            13'd380: pixel_data <= 16'h0;
                            13'd381: pixel_data <= 16'h0;
                            13'd382: pixel_data <= 16'h0;
                            13'd383: pixel_data <= 16'h0;
                            13'd384: pixel_data <= 16'h0;
                            13'd385: pixel_data <= 16'h0;
                            13'd386: pixel_data <= 16'h0;
                            13'd387: pixel_data <= 16'h0;
                            13'd388: pixel_data <= 16'h0;
                            13'd389: pixel_data <= 16'h0;
                            13'd390: pixel_data <= 16'h0;
                            13'd391: pixel_data <= 16'h0;
                            13'd392: pixel_data <= 16'h0;
                            13'd393: pixel_data <= 16'h0;
                            13'd394: pixel_data <= 16'h0;
                            13'd395: pixel_data <= 16'h0;
                            13'd396: pixel_data <= 16'h0;
                            13'd397: pixel_data <= 16'h0;
                            13'd398: pixel_data <= 16'h0;
                            13'd399: pixel_data <= 16'h0;
                            13'd400: pixel_data <= 16'h20;
                            13'd401: pixel_data <= 16'h0;
                            13'd402: pixel_data <= 16'h2800;
                            13'd403: pixel_data <= 16'hB986;
                            13'd404: pixel_data <= 16'hD165;
                            13'd405: pixel_data <= 16'hB9A6;
                            13'd406: pixel_data <= 16'hA1E7;
                            13'd407: pixel_data <= 16'h3800;
                            13'd408: pixel_data <= 16'h3800;
                            13'd409: pixel_data <= 16'h5800;
                            13'd410: pixel_data <= 16'hB186;
                            13'd411: pixel_data <= 16'hA9E8;
                            13'd412: pixel_data <= 16'hA1C7;
                            13'd413: pixel_data <= 16'hAA08;
                            13'd414: pixel_data <= 16'h91E8;
                            13'd415: pixel_data <= 16'h1800;
                            13'd416: pixel_data <= 16'h2000;
                            13'd417: pixel_data <= 16'hA1A7;
                            13'd418: pixel_data <= 16'h5800;
                            13'd419: pixel_data <= 16'h2000;
                            13'd420: pixel_data <= 16'h2000;
                            13'd421: pixel_data <= 16'hA208;
                            13'd422: pixel_data <= 16'h4800;
                            13'd423: pixel_data <= 16'h1800;
                            13'd424: pixel_data <= 16'h0;
                            13'd425: pixel_data <= 16'h0;
                            13'd426: pixel_data <= 16'h2800;
                            13'd427: pixel_data <= 16'h99A8;
                            13'd428: pixel_data <= 16'h7000;
                            13'd429: pixel_data <= 16'h6800;
                            13'd430: pixel_data <= 16'hA1E8;
                            13'd431: pixel_data <= 16'h2800;
                            13'd432: pixel_data <= 16'h2000;
                            13'd433: pixel_data <= 16'hA1C8;
                            13'd434: pixel_data <= 16'h5800;
                            13'd435: pixel_data <= 16'h1800;
                            13'd436: pixel_data <= 16'h2000;
                            13'd437: pixel_data <= 16'h5800;
                            13'd438: pixel_data <= 16'hA1C8;
                            13'd439: pixel_data <= 16'h2000;
                            13'd440: pixel_data <= 16'h0;
                            13'd441: pixel_data <= 16'h0;
                            13'd442: pixel_data <= 16'h1800;
                            13'd443: pixel_data <= 16'hA1E8;
                            13'd444: pixel_data <= 16'h7000;
                            13'd445: pixel_data <= 16'hB986;
                            13'd446: pixel_data <= 16'h7000;
                            13'd447: pixel_data <= 16'hB9A7;
                            13'd448: pixel_data <= 16'h6000;
                            13'd449: pixel_data <= 16'h3800;
                            13'd450: pixel_data <= 16'h3800;
                            13'd451: pixel_data <= 16'h99C8;
                            13'd452: pixel_data <= 16'hA9E8;
                            13'd453: pixel_data <= 16'h99E8;
                            13'd454: pixel_data <= 16'h3800;
                            13'd455: pixel_data <= 16'h1800;
                            13'd456: pixel_data <= 16'h3800;
                            13'd457: pixel_data <= 16'hC145;
                            13'd458: pixel_data <= 16'hC186;
                            13'd459: pixel_data <= 16'h2800;
                            13'd460: pixel_data <= 16'h0;
                            13'd461: pixel_data <= 16'h0;
                            13'd462: pixel_data <= 16'h0;
                            13'd463: pixel_data <= 16'h0;
                            13'd464: pixel_data <= 16'h0;
                            13'd465: pixel_data <= 16'h0;
                            13'd466: pixel_data <= 16'h0;
                            13'd467: pixel_data <= 16'h0;
                            13'd468: pixel_data <= 16'h0;
                            13'd469: pixel_data <= 16'h0;
                            13'd470: pixel_data <= 16'h0;
                            13'd471: pixel_data <= 16'h0;
                            13'd472: pixel_data <= 16'h0;
                            13'd473: pixel_data <= 16'h0;
                            13'd474: pixel_data <= 16'h0;
                            13'd475: pixel_data <= 16'h0;
                            13'd476: pixel_data <= 16'h0;
                            13'd477: pixel_data <= 16'h0;
                            13'd478: pixel_data <= 16'h0;
                            13'd479: pixel_data <= 16'h0;
                            13'd480: pixel_data <= 16'h0;
                            13'd481: pixel_data <= 16'h0;
                            13'd482: pixel_data <= 16'h0;
                            13'd483: pixel_data <= 16'h0;
                            13'd484: pixel_data <= 16'h0;
                            13'd485: pixel_data <= 16'h0;
                            13'd486: pixel_data <= 16'h0;
                            13'd487: pixel_data <= 16'h0;
                            13'd488: pixel_data <= 16'h0;
                            13'd489: pixel_data <= 16'h0;
                            13'd490: pixel_data <= 16'h0;
                            13'd491: pixel_data <= 16'h0;
                            13'd492: pixel_data <= 16'h0;
                            13'd493: pixel_data <= 16'h0;
                            13'd494: pixel_data <= 16'h0;
                            13'd495: pixel_data <= 16'h0;
                            13'd496: pixel_data <= 16'h0;
                            13'd497: pixel_data <= 16'h800;
                            13'd498: pixel_data <= 16'h2800;
                            13'd499: pixel_data <= 16'hB987;
                            13'd500: pixel_data <= 16'hC966;
                            13'd501: pixel_data <= 16'h5800;
                            13'd502: pixel_data <= 16'h4000;
                            13'd503: pixel_data <= 16'h2000;
                            13'd504: pixel_data <= 16'h2800;
                            13'd505: pixel_data <= 16'h5800;
                            13'd506: pixel_data <= 16'hA9A7;
                            13'd507: pixel_data <= 16'h3000;
                            13'd508: pixel_data <= 16'h2800;
                            13'd509: pixel_data <= 16'h2000;
                            13'd510: pixel_data <= 16'h2000;
                            13'd511: pixel_data <= 16'h800;
                            13'd512: pixel_data <= 16'h2000;
                            13'd513: pixel_data <= 16'hA1C7;
                            13'd514: pixel_data <= 16'h5800;
                            13'd515: pixel_data <= 16'h2000;
                            13'd516: pixel_data <= 16'h2000;
                            13'd517: pixel_data <= 16'hA1E8;
                            13'd518: pixel_data <= 16'h5000;
                            13'd519: pixel_data <= 16'h1800;
                            13'd520: pixel_data <= 16'h800;
                            13'd521: pixel_data <= 16'h800;
                            13'd522: pixel_data <= 16'h2000;
                            13'd523: pixel_data <= 16'hA1C8;
                            13'd524: pixel_data <= 16'h7000;
                            13'd525: pixel_data <= 16'h6800;
                            13'd526: pixel_data <= 16'hA1C7;
                            13'd527: pixel_data <= 16'h2800;
                            13'd528: pixel_data <= 16'h2000;
                            13'd529: pixel_data <= 16'hA1C8;
                            13'd530: pixel_data <= 16'h5000;
                            13'd531: pixel_data <= 16'h1800;
                            13'd532: pixel_data <= 16'h2000;
                            13'd533: pixel_data <= 16'h5800;
                            13'd534: pixel_data <= 16'hA1C7;
                            13'd535: pixel_data <= 16'h2000;
                            13'd536: pixel_data <= 16'h800;
                            13'd537: pixel_data <= 16'h0;
                            13'd538: pixel_data <= 16'h2000;
                            13'd539: pixel_data <= 16'hA1A8;
                            13'd540: pixel_data <= 16'h7000;
                            13'd541: pixel_data <= 16'hB987;
                            13'd542: pixel_data <= 16'h6800;
                            13'd543: pixel_data <= 16'hB186;
                            13'd544: pixel_data <= 16'h5800;
                            13'd545: pixel_data <= 16'h3000;
                            13'd546: pixel_data <= 16'h1800;
                            13'd547: pixel_data <= 16'h2000;
                            13'd548: pixel_data <= 16'h3800;
                            13'd549: pixel_data <= 16'h5000;
                            13'd550: pixel_data <= 16'h9A08;
                            13'd551: pixel_data <= 16'h2000;
                            13'd552: pixel_data <= 16'h2800;
                            13'd553: pixel_data <= 16'hA9A7;
                            13'd554: pixel_data <= 16'hA9A7;
                            13'd555: pixel_data <= 16'h2000;
                            13'd556: pixel_data <= 16'h0;
                            13'd557: pixel_data <= 16'h0;
                            13'd558: pixel_data <= 16'h0;
                            13'd559: pixel_data <= 16'h0;
                            13'd560: pixel_data <= 16'h0;
                            13'd561: pixel_data <= 16'h0;
                            13'd562: pixel_data <= 16'h0;
                            13'd563: pixel_data <= 16'h0;
                            13'd564: pixel_data <= 16'h0;
                            13'd565: pixel_data <= 16'h0;
                            13'd566: pixel_data <= 16'h0;
                            13'd567: pixel_data <= 16'h0;
                            13'd568: pixel_data <= 16'h0;
                            13'd569: pixel_data <= 16'h0;
                            13'd570: pixel_data <= 16'h0;
                            13'd571: pixel_data <= 16'h0;
                            13'd572: pixel_data <= 16'h0;
                            13'd573: pixel_data <= 16'h0;
                            13'd574: pixel_data <= 16'h0;
                            13'd575: pixel_data <= 16'h0;
                            13'd576: pixel_data <= 16'h0;
                            13'd577: pixel_data <= 16'h0;
                            13'd578: pixel_data <= 16'h0;
                            13'd579: pixel_data <= 16'h0;
                            13'd580: pixel_data <= 16'h0;
                            13'd581: pixel_data <= 16'h0;
                            13'd582: pixel_data <= 16'h0;
                            13'd583: pixel_data <= 16'h0;
                            13'd584: pixel_data <= 16'h0;
                            13'd585: pixel_data <= 16'h0;
                            13'd586: pixel_data <= 16'h0;
                            13'd587: pixel_data <= 16'h0;
                            13'd588: pixel_data <= 16'h0;
                            13'd589: pixel_data <= 16'h0;
                            13'd590: pixel_data <= 16'h0;
                            13'd591: pixel_data <= 16'h20;
                            13'd592: pixel_data <= 16'h0;
                            13'd593: pixel_data <= 16'h0;
                            13'd594: pixel_data <= 16'h2800;
                            13'd595: pixel_data <= 16'hB1A7;
                            13'd596: pixel_data <= 16'h7800;
                            13'd597: pixel_data <= 16'hA207;
                            13'd598: pixel_data <= 16'h3000;
                            13'd599: pixel_data <= 16'h1800;
                            13'd600: pixel_data <= 16'h2800;
                            13'd601: pixel_data <= 16'h5000;
                            13'd602: pixel_data <= 16'hA9C7;
                            13'd603: pixel_data <= 16'h4000;
                            13'd604: pixel_data <= 16'h2800;
                            13'd605: pixel_data <= 16'h2000;
                            13'd606: pixel_data <= 16'h1800;
                            13'd607: pixel_data <= 16'h800;
                            13'd608: pixel_data <= 16'h2000;
                            13'd609: pixel_data <= 16'hA9A7;
                            13'd610: pixel_data <= 16'h6800;
                            13'd611: pixel_data <= 16'h3800;
                            13'd612: pixel_data <= 16'h3000;
                            13'd613: pixel_data <= 16'hA1E7;
                            13'd614: pixel_data <= 16'h4800;
                            13'd615: pixel_data <= 16'h1800;
                            13'd616: pixel_data <= 16'h0;
                            13'd617: pixel_data <= 16'h800;
                            13'd618: pixel_data <= 16'h2800;
                            13'd619: pixel_data <= 16'hA1C8;
                            13'd620: pixel_data <= 16'h7000;
                            13'd621: pixel_data <= 16'h7000;
                            13'd622: pixel_data <= 16'hA9C7;
                            13'd623: pixel_data <= 16'h3800;
                            13'd624: pixel_data <= 16'h3800;
                            13'd625: pixel_data <= 16'hA1C8;
                            13'd626: pixel_data <= 16'h5000;
                            13'd627: pixel_data <= 16'h2000;
                            13'd628: pixel_data <= 16'h2800;
                            13'd629: pixel_data <= 16'h6000;
                            13'd630: pixel_data <= 16'hB1A7;
                            13'd631: pixel_data <= 16'h3800;
                            13'd632: pixel_data <= 16'h1800;
                            13'd633: pixel_data <= 16'h800;
                            13'd634: pixel_data <= 16'h1800;
                            13'd635: pixel_data <= 16'hA1C8;
                            13'd636: pixel_data <= 16'h7000;
                            13'd637: pixel_data <= 16'h6000;
                            13'd638: pixel_data <= 16'hB1A7;
                            13'd639: pixel_data <= 16'hB9C6;
                            13'd640: pixel_data <= 16'h5000;
                            13'd641: pixel_data <= 16'h2800;
                            13'd642: pixel_data <= 16'h1800;
                            13'd643: pixel_data <= 16'h2000;
                            13'd644: pixel_data <= 16'h3800;
                            13'd645: pixel_data <= 16'h6000;
                            13'd646: pixel_data <= 16'hA1C7;
                            13'd647: pixel_data <= 16'h2000;
                            13'd648: pixel_data <= 16'h2800;
                            13'd649: pixel_data <= 16'h6000;
                            13'd650: pixel_data <= 16'h6000;
                            13'd651: pixel_data <= 16'h2000;
                            13'd652: pixel_data <= 16'h0;
                            13'd653: pixel_data <= 16'h0;
                            13'd654: pixel_data <= 16'h0;
                            13'd655: pixel_data <= 16'h0;
                            13'd656: pixel_data <= 16'h0;
                            13'd657: pixel_data <= 16'h0;
                            13'd658: pixel_data <= 16'h0;
                            13'd659: pixel_data <= 16'h0;
                            13'd660: pixel_data <= 16'h0;
                            13'd661: pixel_data <= 16'h0;
                            13'd662: pixel_data <= 16'h0;
                            13'd663: pixel_data <= 16'h0;
                            13'd664: pixel_data <= 16'h0;
                            13'd665: pixel_data <= 16'h0;
                            13'd666: pixel_data <= 16'h0;
                            13'd667: pixel_data <= 16'h0;
                            13'd668: pixel_data <= 16'h0;
                            13'd669: pixel_data <= 16'h0;
                            13'd670: pixel_data <= 16'h0;
                            13'd671: pixel_data <= 16'h0;
                            13'd672: pixel_data <= 16'h0;
                            13'd673: pixel_data <= 16'h0;
                            13'd674: pixel_data <= 16'h0;
                            13'd675: pixel_data <= 16'h0;
                            13'd676: pixel_data <= 16'h0;
                            13'd677: pixel_data <= 16'h0;
                            13'd678: pixel_data <= 16'h0;
                            13'd679: pixel_data <= 16'h0;
                            13'd680: pixel_data <= 16'h0;
                            13'd681: pixel_data <= 16'h0;
                            13'd682: pixel_data <= 16'h0;
                            13'd683: pixel_data <= 16'h0;
                            13'd684: pixel_data <= 16'h0;
                            13'd685: pixel_data <= 16'h0;
                            13'd686: pixel_data <= 16'h0;
                            13'd687: pixel_data <= 16'h0;
                            13'd688: pixel_data <= 16'h20;
                            13'd689: pixel_data <= 16'h800;
                            13'd690: pixel_data <= 16'h2000;
                            13'd691: pixel_data <= 16'hA9C7;
                            13'd692: pixel_data <= 16'h6800;
                            13'd693: pixel_data <= 16'h4800;
                            13'd694: pixel_data <= 16'h9269;
                            13'd695: pixel_data <= 16'h2800;
                            13'd696: pixel_data <= 16'h4000;
                            13'd697: pixel_data <= 16'h5800;
                            13'd698: pixel_data <= 16'hA9A7;
                            13'd699: pixel_data <= 16'h6000;
                            13'd700: pixel_data <= 16'h5000;
                            13'd701: pixel_data <= 16'h5000;
                            13'd702: pixel_data <= 16'h4000;
                            13'd703: pixel_data <= 16'h1800;
                            13'd704: pixel_data <= 16'h2800;
                            13'd705: pixel_data <= 16'hB186;
                            13'd706: pixel_data <= 16'h8000;
                            13'd707: pixel_data <= 16'h6000;
                            13'd708: pixel_data <= 16'h4800;
                            13'd709: pixel_data <= 16'h9A07;
                            13'd710: pixel_data <= 16'h3800;
                            13'd711: pixel_data <= 16'h1000;
                            13'd712: pixel_data <= 16'h0;
                            13'd713: pixel_data <= 16'h800;
                            13'd714: pixel_data <= 16'h1800;
                            13'd715: pixel_data <= 16'hA1E8;
                            13'd716: pixel_data <= 16'h7000;
                            13'd717: pixel_data <= 16'h7000;
                            13'd718: pixel_data <= 16'hB1A7;
                            13'd719: pixel_data <= 16'h5800;
                            13'd720: pixel_data <= 16'h5000;
                            13'd721: pixel_data <= 16'h99E9;
                            13'd722: pixel_data <= 16'h4000;
                            13'd723: pixel_data <= 16'h3000;
                            13'd724: pixel_data <= 16'h4800;
                            13'd725: pixel_data <= 16'h7800;
                            13'd726: pixel_data <= 16'hC166;
                            13'd727: pixel_data <= 16'h6000;
                            13'd728: pixel_data <= 16'h4000;
                            13'd729: pixel_data <= 16'h2000;
                            13'd730: pixel_data <= 16'h2000;
                            13'd731: pixel_data <= 16'hA1C8;
                            13'd732: pixel_data <= 16'h6800;
                            13'd733: pixel_data <= 16'h5800;
                            13'd734: pixel_data <= 16'hA1E7;
                            13'd735: pixel_data <= 16'hA9A7;
                            13'd736: pixel_data <= 16'h5800;
                            13'd737: pixel_data <= 16'h3800;
                            13'd738: pixel_data <= 16'h3800;
                            13'd739: pixel_data <= 16'h4800;
                            13'd740: pixel_data <= 16'h5800;
                            13'd741: pixel_data <= 16'h6800;
                            13'd742: pixel_data <= 16'hA1E8;
                            13'd743: pixel_data <= 16'h2000;
                            13'd744: pixel_data <= 16'h3000;
                            13'd745: pixel_data <= 16'hC185;
                            13'd746: pixel_data <= 16'hB965;
                            13'd747: pixel_data <= 16'h2800;
                            13'd748: pixel_data <= 16'h820;
                            13'd749: pixel_data <= 16'h0;
                            13'd750: pixel_data <= 16'h21;
                            13'd751: pixel_data <= 16'h0;
                            13'd752: pixel_data <= 16'h0;
                            13'd753: pixel_data <= 16'h0;
                            13'd754: pixel_data <= 16'h0;
                            13'd755: pixel_data <= 16'h0;
                            13'd756: pixel_data <= 16'h0;
                            13'd757: pixel_data <= 16'h0;
                            13'd758: pixel_data <= 16'h0;
                            13'd759: pixel_data <= 16'h0;
                            13'd760: pixel_data <= 16'h0;
                            13'd761: pixel_data <= 16'h0;
                            13'd762: pixel_data <= 16'h0;
                            13'd763: pixel_data <= 16'h0;
                            13'd764: pixel_data <= 16'h0;
                            13'd765: pixel_data <= 16'h0;
                            13'd766: pixel_data <= 16'h0;
                            13'd767: pixel_data <= 16'h0;
                            13'd768: pixel_data <= 16'h0;
                            13'd769: pixel_data <= 16'h0;
                            13'd770: pixel_data <= 16'h0;
                            13'd771: pixel_data <= 16'h0;
                            13'd772: pixel_data <= 16'h0;
                            13'd773: pixel_data <= 16'h0;
                            13'd774: pixel_data <= 16'h0;
                            13'd775: pixel_data <= 16'h0;
                            13'd776: pixel_data <= 16'h0;
                            13'd777: pixel_data <= 16'h0;
                            13'd778: pixel_data <= 16'h0;
                            13'd779: pixel_data <= 16'h0;
                            13'd780: pixel_data <= 16'h0;
                            13'd781: pixel_data <= 16'h0;
                            13'd782: pixel_data <= 16'h0;
                            13'd783: pixel_data <= 16'h0;
                            13'd784: pixel_data <= 16'h0;
                            13'd785: pixel_data <= 16'h0;
                            13'd786: pixel_data <= 16'h2000;
                            13'd787: pixel_data <= 16'h9208;
                            13'd788: pixel_data <= 16'h4000;
                            13'd789: pixel_data <= 16'h3800;
                            13'd790: pixel_data <= 16'h2800;
                            13'd791: pixel_data <= 16'h8A69;
                            13'd792: pixel_data <= 16'h3000;
                            13'd793: pixel_data <= 16'h4000;
                            13'd794: pixel_data <= 16'hA209;
                            13'd795: pixel_data <= 16'h99C7;
                            13'd796: pixel_data <= 16'h99E8;
                            13'd797: pixel_data <= 16'h99E8;
                            13'd798: pixel_data <= 16'h8A09;
                            13'd799: pixel_data <= 16'h1800;
                            13'd800: pixel_data <= 16'h2000;
                            13'd801: pixel_data <= 16'hA9E8;
                            13'd802: pixel_data <= 16'hA986;
                            13'd803: pixel_data <= 16'hA1C7;
                            13'd804: pixel_data <= 16'h9A08;
                            13'd805: pixel_data <= 16'h3000;
                            13'd806: pixel_data <= 16'h2000;
                            13'd807: pixel_data <= 16'h800;
                            13'd808: pixel_data <= 16'h0;
                            13'd809: pixel_data <= 16'h0;
                            13'd810: pixel_data <= 16'h1800;
                            13'd811: pixel_data <= 16'h4000;
                            13'd812: pixel_data <= 16'hA1E7;
                            13'd813: pixel_data <= 16'hA1E8;
                            13'd814: pixel_data <= 16'h5000;
                            13'd815: pixel_data <= 16'hA1E7;
                            13'd816: pixel_data <= 16'h99E8;
                            13'd817: pixel_data <= 16'h3000;
                            13'd818: pixel_data <= 16'h3000;
                            13'd819: pixel_data <= 16'h3000;
                            13'd820: pixel_data <= 16'h9208;
                            13'd821: pixel_data <= 16'hA9C7;
                            13'd822: pixel_data <= 16'hB187;
                            13'd823: pixel_data <= 16'hA1C8;
                            13'd824: pixel_data <= 16'h8A08;
                            13'd825: pixel_data <= 16'h1800;
                            13'd826: pixel_data <= 16'h1800;
                            13'd827: pixel_data <= 16'h9229;
                            13'd828: pixel_data <= 16'h4800;
                            13'd829: pixel_data <= 16'h3800;
                            13'd830: pixel_data <= 16'h3800;
                            13'd831: pixel_data <= 16'h9208;
                            13'd832: pixel_data <= 16'h4000;
                            13'd833: pixel_data <= 16'h3000;
                            13'd834: pixel_data <= 16'h8228;
                            13'd835: pixel_data <= 16'h9A29;
                            13'd836: pixel_data <= 16'hA1E8;
                            13'd837: pixel_data <= 16'hA1E8;
                            13'd838: pixel_data <= 16'h3800;
                            13'd839: pixel_data <= 16'h1800;
                            13'd840: pixel_data <= 16'h2800;
                            13'd841: pixel_data <= 16'hB1C6;
                            13'd842: pixel_data <= 16'hB1E7;
                            13'd843: pixel_data <= 16'h2000;
                            13'd844: pixel_data <= 16'h0;
                            13'd845: pixel_data <= 16'h0;
                            13'd846: pixel_data <= 16'h0;
                            13'd847: pixel_data <= 16'h0;
                            13'd848: pixel_data <= 16'h0;
                            13'd849: pixel_data <= 16'h0;
                            13'd850: pixel_data <= 16'h0;
                            13'd851: pixel_data <= 16'h0;
                            13'd852: pixel_data <= 16'h0;
                            13'd853: pixel_data <= 16'h0;
                            13'd854: pixel_data <= 16'h0;
                            13'd855: pixel_data <= 16'h0;
                            13'd856: pixel_data <= 16'h0;
                            13'd857: pixel_data <= 16'h0;
                            13'd858: pixel_data <= 16'h0;
                            13'd859: pixel_data <= 16'h0;
                            13'd860: pixel_data <= 16'h0;
                            13'd861: pixel_data <= 16'h0;
                            13'd862: pixel_data <= 16'h0;
                            13'd863: pixel_data <= 16'h0;
                            13'd864: pixel_data <= 16'h0;
                            13'd865: pixel_data <= 16'h0;
                            13'd866: pixel_data <= 16'h0;
                            13'd867: pixel_data <= 16'h0;
                            13'd868: pixel_data <= 16'h0;
                            13'd869: pixel_data <= 16'h0;
                            13'd870: pixel_data <= 16'h0;
                            13'd871: pixel_data <= 16'h0;
                            13'd872: pixel_data <= 16'h0;
                            13'd873: pixel_data <= 16'h0;
                            13'd874: pixel_data <= 16'h0;
                            13'd875: pixel_data <= 16'h0;
                            13'd876: pixel_data <= 16'h0;
                            13'd877: pixel_data <= 16'h0;
                            13'd878: pixel_data <= 16'h0;
                            13'd879: pixel_data <= 16'h0;
                            13'd880: pixel_data <= 16'h0;
                            13'd881: pixel_data <= 16'h800;
                            13'd882: pixel_data <= 16'h1000;
                            13'd883: pixel_data <= 16'h1800;
                            13'd884: pixel_data <= 16'h1800;
                            13'd885: pixel_data <= 16'h1000;
                            13'd886: pixel_data <= 16'h1001;
                            13'd887: pixel_data <= 16'h1000;
                            13'd888: pixel_data <= 16'h1800;
                            13'd889: pixel_data <= 16'h2000;
                            13'd890: pixel_data <= 16'h1800;
                            13'd891: pixel_data <= 16'h2000;
                            13'd892: pixel_data <= 16'h2000;
                            13'd893: pixel_data <= 16'h1800;
                            13'd894: pixel_data <= 16'h2001;
                            13'd895: pixel_data <= 16'h1000;
                            13'd896: pixel_data <= 16'h800;
                            13'd897: pixel_data <= 16'h2000;
                            13'd898: pixel_data <= 16'h2800;
                            13'd899: pixel_data <= 16'h1800;
                            13'd900: pixel_data <= 16'h1800;
                            13'd901: pixel_data <= 16'h1800;
                            13'd902: pixel_data <= 16'h800;
                            13'd903: pixel_data <= 16'h0;
                            13'd904: pixel_data <= 16'h0;
                            13'd905: pixel_data <= 16'h0;
                            13'd906: pixel_data <= 16'h800;
                            13'd907: pixel_data <= 16'h1800;
                            13'd908: pixel_data <= 16'h2000;
                            13'd909: pixel_data <= 16'h2000;
                            13'd910: pixel_data <= 16'h2000;
                            13'd911: pixel_data <= 16'h2000;
                            13'd912: pixel_data <= 16'h1000;
                            13'd913: pixel_data <= 16'h1000;
                            13'd914: pixel_data <= 16'h800;
                            13'd915: pixel_data <= 16'h1000;
                            13'd916: pixel_data <= 16'h1800;
                            13'd917: pixel_data <= 16'h2000;
                            13'd918: pixel_data <= 16'h2800;
                            13'd919: pixel_data <= 16'h2000;
                            13'd920: pixel_data <= 16'h1000;
                            13'd921: pixel_data <= 16'h0;
                            13'd922: pixel_data <= 16'h800;
                            13'd923: pixel_data <= 16'h1800;
                            13'd924: pixel_data <= 16'h1800;
                            13'd925: pixel_data <= 16'h1800;
                            13'd926: pixel_data <= 16'h1800;
                            13'd927: pixel_data <= 16'h2000;
                            13'd928: pixel_data <= 16'h1800;
                            13'd929: pixel_data <= 16'h1000;
                            13'd930: pixel_data <= 16'h1000;
                            13'd931: pixel_data <= 16'h1800;
                            13'd932: pixel_data <= 16'h2000;
                            13'd933: pixel_data <= 16'h1800;
                            13'd934: pixel_data <= 16'h1800;
                            13'd935: pixel_data <= 16'h800;
                            13'd936: pixel_data <= 16'h1000;
                            13'd937: pixel_data <= 16'h2000;
                            13'd938: pixel_data <= 16'h2000;
                            13'd939: pixel_data <= 16'h1000;
                            13'd940: pixel_data <= 16'h800;
                            13'd941: pixel_data <= 16'h0;
                            13'd942: pixel_data <= 16'h20;
                            13'd943: pixel_data <= 16'h0;
                            13'd944: pixel_data <= 16'h0;
                            13'd945: pixel_data <= 16'h0;
                            13'd946: pixel_data <= 16'h0;
                            13'd947: pixel_data <= 16'h0;
                            13'd948: pixel_data <= 16'h0;
                            13'd949: pixel_data <= 16'h0;
                            13'd950: pixel_data <= 16'h0;
                            13'd951: pixel_data <= 16'h0;
                            13'd952: pixel_data <= 16'h0;
                            13'd953: pixel_data <= 16'h0;
                            13'd954: pixel_data <= 16'h0;
                            13'd955: pixel_data <= 16'h0;
                            13'd956: pixel_data <= 16'h0;
                            13'd957: pixel_data <= 16'h0;
                            13'd958: pixel_data <= 16'h0;
                            13'd959: pixel_data <= 16'h0;
                            13'd960: pixel_data <= 16'h0;
                            13'd961: pixel_data <= 16'h0;
                            13'd962: pixel_data <= 16'h0;
                            13'd963: pixel_data <= 16'h0;
                            13'd964: pixel_data <= 16'h0;
                            13'd965: pixel_data <= 16'h0;
                            13'd966: pixel_data <= 16'h0;
                            13'd967: pixel_data <= 16'h0;
                            13'd968: pixel_data <= 16'h0;
                            13'd969: pixel_data <= 16'h0;
                            13'd970: pixel_data <= 16'h0;
                            13'd971: pixel_data <= 16'h0;
                            13'd972: pixel_data <= 16'h0;
                            13'd973: pixel_data <= 16'h0;
                            13'd974: pixel_data <= 16'h0;
                            13'd975: pixel_data <= 16'h0;
                            13'd976: pixel_data <= 16'h0;
                            13'd977: pixel_data <= 16'h800;
                            13'd978: pixel_data <= 16'h800;
                            13'd979: pixel_data <= 16'h0;
                            13'd980: pixel_data <= 16'h800;
                            13'd981: pixel_data <= 16'h1;
                            13'd982: pixel_data <= 16'h1;
                            13'd983: pixel_data <= 16'h1;
                            13'd984: pixel_data <= 16'h801;
                            13'd985: pixel_data <= 16'h801;
                            13'd986: pixel_data <= 16'h801;
                            13'd987: pixel_data <= 16'h0;
                            13'd988: pixel_data <= 16'h800;
                            13'd989: pixel_data <= 16'h0;
                            13'd990: pixel_data <= 16'h0;
                            13'd991: pixel_data <= 16'h800;
                            13'd992: pixel_data <= 16'h800;
                            13'd993: pixel_data <= 16'h800;
                            13'd994: pixel_data <= 16'h0;
                            13'd995: pixel_data <= 16'h801;
                            13'd996: pixel_data <= 16'h800;
                            13'd997: pixel_data <= 16'h0;
                            13'd998: pixel_data <= 16'h1;
                            13'd999: pixel_data <= 16'h0;
                            13'd1000: pixel_data <= 16'h0;
                            13'd1001: pixel_data <= 16'h0;
                            13'd1002: pixel_data <= 16'h800;
                            13'd1003: pixel_data <= 16'h800;
                            13'd1004: pixel_data <= 16'h800;
                            13'd1005: pixel_data <= 16'h800;
                            13'd1006: pixel_data <= 16'h0;
                            13'd1007: pixel_data <= 16'h0;
                            13'd1008: pixel_data <= 16'h20;
                            13'd1009: pixel_data <= 16'h20;
                            13'd1010: pixel_data <= 16'h20;
                            13'd1011: pixel_data <= 16'h0;
                            13'd1012: pixel_data <= 16'h20;
                            13'd1013: pixel_data <= 16'h801;
                            13'd1014: pixel_data <= 16'h801;
                            13'd1015: pixel_data <= 16'h0;
                            13'd1016: pixel_data <= 16'h820;
                            13'd1017: pixel_data <= 16'h0;
                            13'd1018: pixel_data <= 16'h0;
                            13'd1019: pixel_data <= 16'h0;
                            13'd1020: pixel_data <= 16'h0;
                            13'd1021: pixel_data <= 16'h800;
                            13'd1022: pixel_data <= 16'h0;
                            13'd1023: pixel_data <= 16'h800;
                            13'd1024: pixel_data <= 16'h800;
                            13'd1025: pixel_data <= 16'h0;
                            13'd1026: pixel_data <= 16'h820;
                            13'd1027: pixel_data <= 16'h0;
                            13'd1028: pixel_data <= 16'h800;
                            13'd1029: pixel_data <= 16'h820;
                            13'd1030: pixel_data <= 16'h0;
                            13'd1031: pixel_data <= 16'h1;
                            13'd1032: pixel_data <= 16'h1;
                            13'd1033: pixel_data <= 16'h800;
                            13'd1034: pixel_data <= 16'h800;
                            13'd1035: pixel_data <= 16'h800;
                            13'd1036: pixel_data <= 16'h800;
                            13'd1037: pixel_data <= 16'h0;
                            13'd1038: pixel_data <= 16'h20;
                            13'd1039: pixel_data <= 16'h0;
                            13'd1040: pixel_data <= 16'h0;
                            13'd1041: pixel_data <= 16'h0;
                            13'd1042: pixel_data <= 16'h0;
                            13'd1043: pixel_data <= 16'h0;
                            13'd1044: pixel_data <= 16'h0;
                            13'd1045: pixel_data <= 16'h0;
                            13'd1046: pixel_data <= 16'h0;
                            13'd1047: pixel_data <= 16'h0;
                            13'd1048: pixel_data <= 16'h0;
                            13'd1049: pixel_data <= 16'h0;
                            13'd1050: pixel_data <= 16'h0;
                            13'd1051: pixel_data <= 16'h0;
                            13'd1052: pixel_data <= 16'h0;
                            13'd1053: pixel_data <= 16'h0;
                            13'd1054: pixel_data <= 16'h0;
                            13'd1055: pixel_data <= 16'h0;
                            13'd1056: pixel_data <= 16'h0;
                            13'd1057: pixel_data <= 16'h0;
                            13'd1058: pixel_data <= 16'h0;
                            13'd1059: pixel_data <= 16'h0;
                            13'd1060: pixel_data <= 16'h0;
                            13'd1061: pixel_data <= 16'h0;
                            13'd1062: pixel_data <= 16'h0;
                            13'd1063: pixel_data <= 16'h0;
                            13'd1064: pixel_data <= 16'h0;
                            13'd1065: pixel_data <= 16'h0;
                            13'd1066: pixel_data <= 16'h0;
                            13'd1067: pixel_data <= 16'h0;
                            13'd1068: pixel_data <= 16'h0;
                            13'd1069: pixel_data <= 16'h0;
                            13'd1070: pixel_data <= 16'h0;
                            13'd1071: pixel_data <= 16'h0;
                            13'd1072: pixel_data <= 16'h0;
                            13'd1073: pixel_data <= 16'h0;
                            13'd1074: pixel_data <= 16'h0;
                            13'd1075: pixel_data <= 16'h0;
                            13'd1076: pixel_data <= 16'h0;
                            13'd1077: pixel_data <= 16'h0;
                            13'd1078: pixel_data <= 16'h0;
                            13'd1079: pixel_data <= 16'h0;
                            13'd1080: pixel_data <= 16'h0;
                            13'd1081: pixel_data <= 16'h0;
                            13'd1082: pixel_data <= 16'h0;
                            13'd1083: pixel_data <= 16'h0;
                            13'd1084: pixel_data <= 16'h0;
                            13'd1085: pixel_data <= 16'h0;
                            13'd1086: pixel_data <= 16'h0;
                            13'd1087: pixel_data <= 16'h0;
                            13'd1088: pixel_data <= 16'h0;
                            13'd1089: pixel_data <= 16'h0;
                            13'd1090: pixel_data <= 16'h0;
                            13'd1091: pixel_data <= 16'h0;
                            13'd1092: pixel_data <= 16'h0;
                            13'd1093: pixel_data <= 16'h0;
                            13'd1094: pixel_data <= 16'h0;
                            13'd1095: pixel_data <= 16'h0;
                            13'd1096: pixel_data <= 16'h0;
                            13'd1097: pixel_data <= 16'h0;
                            13'd1098: pixel_data <= 16'h0;
                            13'd1099: pixel_data <= 16'h0;
                            13'd1100: pixel_data <= 16'h0;
                            13'd1101: pixel_data <= 16'h0;
                            13'd1102: pixel_data <= 16'h0;
                            13'd1103: pixel_data <= 16'h0;
                            13'd1104: pixel_data <= 16'h0;
                            13'd1105: pixel_data <= 16'h0;
                            13'd1106: pixel_data <= 16'h0;
                            13'd1107: pixel_data <= 16'h0;
                            13'd1108: pixel_data <= 16'h0;
                            13'd1109: pixel_data <= 16'h0;
                            13'd1110: pixel_data <= 16'h0;
                            13'd1111: pixel_data <= 16'h0;
                            13'd1112: pixel_data <= 16'h0;
                            13'd1113: pixel_data <= 16'h0;
                            13'd1114: pixel_data <= 16'h0;
                            13'd1115: pixel_data <= 16'h0;
                            13'd1116: pixel_data <= 16'h0;
                            13'd1117: pixel_data <= 16'h0;
                            13'd1118: pixel_data <= 16'h0;
                            13'd1119: pixel_data <= 16'h0;
                            13'd1120: pixel_data <= 16'h0;
                            13'd1121: pixel_data <= 16'h0;
                            13'd1122: pixel_data <= 16'h0;
                            13'd1123: pixel_data <= 16'h0;
                            13'd1124: pixel_data <= 16'h0;
                            13'd1125: pixel_data <= 16'h0;
                            13'd1126: pixel_data <= 16'h0;
                            13'd1127: pixel_data <= 16'h0;
                            13'd1128: pixel_data <= 16'h0;
                            13'd1129: pixel_data <= 16'h0;
                            13'd1130: pixel_data <= 16'h0;
                            13'd1131: pixel_data <= 16'h0;
                            13'd1132: pixel_data <= 16'h0;
                            13'd1133: pixel_data <= 16'h0;
                            13'd1134: pixel_data <= 16'h0;
                            13'd1135: pixel_data <= 16'h0;
                            13'd1136: pixel_data <= 16'h0;
                            13'd1137: pixel_data <= 16'h0;
                            13'd1138: pixel_data <= 16'h0;
                            13'd1139: pixel_data <= 16'h0;
                            13'd1140: pixel_data <= 16'h0;
                            13'd1141: pixel_data <= 16'h0;
                            13'd1142: pixel_data <= 16'h0;
                            13'd1143: pixel_data <= 16'h0;
                            13'd1144: pixel_data <= 16'h0;
                            13'd1145: pixel_data <= 16'h0;
                            13'd1146: pixel_data <= 16'h0;
                            13'd1147: pixel_data <= 16'h0;
                            13'd1148: pixel_data <= 16'h0;
                            13'd1149: pixel_data <= 16'h0;
                            13'd1150: pixel_data <= 16'h0;
                            13'd1151: pixel_data <= 16'h0;
            
                            endcase
                end
                else if(pwinfinal==2'd2) begin
                case (pixel_index)
                            13'd0: pixel_data <= 16'h0;
                            13'd1: pixel_data <= 16'h0;
                            13'd2: pixel_data <= 16'h0;
                            13'd3: pixel_data <= 16'h0;
                            13'd4: pixel_data <= 16'h0;
                            13'd5: pixel_data <= 16'h0;
                            13'd6: pixel_data <= 16'h0;
                            13'd7: pixel_data <= 16'h0;
                            13'd8: pixel_data <= 16'h0;
                            13'd9: pixel_data <= 16'h0;
                            13'd10: pixel_data <= 16'h0;
                            13'd11: pixel_data <= 16'h0;
                            13'd12: pixel_data <= 16'h0;
                            13'd13: pixel_data <= 16'h0;
                            13'd14: pixel_data <= 16'h0;
                            13'd15: pixel_data <= 16'h0;
                            13'd16: pixel_data <= 16'h0;
                            13'd17: pixel_data <= 16'h20;
                            13'd18: pixel_data <= 16'hE716;
                            13'd19: pixel_data <= 16'h0;
                            13'd20: pixel_data <= 16'h0;
                            13'd21: pixel_data <= 16'h0;
                            13'd22: pixel_data <= 16'h800;
                            13'd23: pixel_data <= 16'h0;
                            13'd24: pixel_data <= 16'hEF14;
                            13'd25: pixel_data <= 16'h840;
                            13'd26: pixel_data <= 16'hEF11;
                            13'd27: pixel_data <= 16'hEF10;
                            13'd28: pixel_data <= 16'hEF31;
                            13'd29: pixel_data <= 16'hEF11;
                            13'd30: pixel_data <= 16'hE6F3;
                            13'd31: pixel_data <= 16'h800;
                            13'd32: pixel_data <= 16'h0;
                            13'd33: pixel_data <= 16'hE714;
                            13'd34: pixel_data <= 16'h840;
                            13'd35: pixel_data <= 16'h20;
                            13'd36: pixel_data <= 16'h0;
                            13'd37: pixel_data <= 16'h0;
                            13'd38: pixel_data <= 16'h0;
                            13'd39: pixel_data <= 16'h0;
                            13'd40: pixel_data <= 16'h0;
                            13'd41: pixel_data <= 16'h0;
                            13'd42: pixel_data <= 16'h0;
                            13'd43: pixel_data <= 16'hEEF3;
                            13'd44: pixel_data <= 16'h1860;
                            13'd45: pixel_data <= 16'h0;
                            13'd46: pixel_data <= 16'hE735;
                            13'd47: pixel_data <= 16'h0;
                            13'd48: pixel_data <= 16'h0;
                            13'd49: pixel_data <= 16'hEF14;
                            13'd50: pixel_data <= 16'h0;
                            13'd51: pixel_data <= 16'h800;
                            13'd52: pixel_data <= 16'hEF14;
                            13'd53: pixel_data <= 16'hEF2F;
                            13'd54: pixel_data <= 16'hEF2E;
                            13'd55: pixel_data <= 16'hF72F;
                            13'd56: pixel_data <= 16'hE6F2;
                            13'd57: pixel_data <= 16'h20;
                            13'd58: pixel_data <= 16'h60;
                            13'd59: pixel_data <= 16'hEF12;
                            13'd60: pixel_data <= 16'h0;
                            13'd61: pixel_data <= 16'h0;
                            13'd62: pixel_data <= 16'h20;
                            13'd63: pixel_data <= 16'hE713;
                            13'd64: pixel_data <= 16'h0;
                            13'd65: pixel_data <= 16'h800;
                            13'd66: pixel_data <= 16'h1000;
                            13'd67: pixel_data <= 16'hF712;
                            13'd68: pixel_data <= 16'hEEEF;
                            13'd69: pixel_data <= 16'hE6F0;
                            13'd70: pixel_data <= 16'hE713;
                            13'd71: pixel_data <= 16'h20;
                            13'd72: pixel_data <= 16'h20;
                            13'd73: pixel_data <= 16'hEF2E;
                            13'd74: pixel_data <= 16'hEF2E;
                            13'd75: pixel_data <= 16'h0;
                            13'd76: pixel_data <= 16'h0;
                            13'd77: pixel_data <= 16'h0;
                            13'd78: pixel_data <= 16'h0;
                            13'd79: pixel_data <= 16'h0;
                            13'd80: pixel_data <= 16'h0;
                            13'd81: pixel_data <= 16'h0;
                            13'd82: pixel_data <= 16'h0;
                            13'd83: pixel_data <= 16'h0;
                            13'd84: pixel_data <= 16'h0;
                            13'd85: pixel_data <= 16'h0;
                            13'd86: pixel_data <= 16'h0;
                            13'd87: pixel_data <= 16'h0;
                            13'd88: pixel_data <= 16'h0;
                            13'd89: pixel_data <= 16'h0;
                            13'd90: pixel_data <= 16'h0;
                            13'd91: pixel_data <= 16'h0;
                            13'd92: pixel_data <= 16'h0;
                            13'd93: pixel_data <= 16'h0;
                            13'd94: pixel_data <= 16'h0;
                            13'd95: pixel_data <= 16'h0;
                            13'd96: pixel_data <= 16'h0;
                            13'd97: pixel_data <= 16'h0;
                            13'd98: pixel_data <= 16'h0;
                            13'd99: pixel_data <= 16'h0;
                            13'd100: pixel_data <= 16'h0;
                            13'd101: pixel_data <= 16'h0;
                            13'd102: pixel_data <= 16'h0;
                            13'd103: pixel_data <= 16'h0;
                            13'd104: pixel_data <= 16'h0;
                            13'd105: pixel_data <= 16'h0;
                            13'd106: pixel_data <= 16'h0;
                            13'd107: pixel_data <= 16'h0;
                            13'd108: pixel_data <= 16'h0;
                            13'd109: pixel_data <= 16'h0;
                            13'd110: pixel_data <= 16'h0;
                            13'd111: pixel_data <= 16'h0;
                            13'd112: pixel_data <= 16'h840;
                            13'd113: pixel_data <= 16'h40;
                            13'd114: pixel_data <= 16'h20;
                            13'd115: pixel_data <= 16'hE732;
                            13'd116: pixel_data <= 16'h860;
                            13'd117: pixel_data <= 16'h0;
                            13'd118: pixel_data <= 16'h0;
                            13'd119: pixel_data <= 16'hEEF5;
                            13'd120: pixel_data <= 16'h0;
                            13'd121: pixel_data <= 16'h1080;
                            13'd122: pixel_data <= 16'hEF31;
                            13'd123: pixel_data <= 16'h0;
                            13'd124: pixel_data <= 16'h800;
                            13'd125: pixel_data <= 16'h840;
                            13'd126: pixel_data <= 16'h0;
                            13'd127: pixel_data <= 16'h0;
                            13'd128: pixel_data <= 16'h0;
                            13'd129: pixel_data <= 16'hE711;
                            13'd130: pixel_data <= 16'h1080;
                            13'd131: pixel_data <= 16'h0;
                            13'd132: pixel_data <= 16'h20;
                            13'd133: pixel_data <= 16'h0;
                            13'd134: pixel_data <= 16'h0;
                            13'd135: pixel_data <= 16'h0;
                            13'd136: pixel_data <= 16'h0;
                            13'd137: pixel_data <= 16'h0;
                            13'd138: pixel_data <= 16'h0;
                            13'd139: pixel_data <= 16'hEEF0;
                            13'd140: pixel_data <= 16'h0;
                            13'd141: pixel_data <= 16'h0;
                            13'd142: pixel_data <= 16'hE712;
                            13'd143: pixel_data <= 16'h20;
                            13'd144: pixel_data <= 16'h840;
                            13'd145: pixel_data <= 16'hEF32;
                            13'd146: pixel_data <= 16'h0;
                            13'd147: pixel_data <= 16'h0;
                            13'd148: pixel_data <= 16'h0;
                            13'd149: pixel_data <= 16'h0;
                            13'd150: pixel_data <= 16'hEF0F;
                            13'd151: pixel_data <= 16'h840;
                            13'd152: pixel_data <= 16'h20;
                            13'd153: pixel_data <= 16'h60;
                            13'd154: pixel_data <= 16'h40;
                            13'd155: pixel_data <= 16'hF74B;
                            13'd156: pixel_data <= 16'hF70A;
                            13'd157: pixel_data <= 16'h0;
                            13'd158: pixel_data <= 16'h0;
                            13'd159: pixel_data <= 16'hE711;
                            13'd160: pixel_data <= 16'h0;
                            13'd161: pixel_data <= 16'h1880;
                            13'd162: pixel_data <= 16'hF713;
                            13'd163: pixel_data <= 16'h800;
                            13'd164: pixel_data <= 16'h800;
                            13'd165: pixel_data <= 16'h1080;
                            13'd166: pixel_data <= 16'h0;
                            13'd167: pixel_data <= 16'h0;
                            13'd168: pixel_data <= 16'h0;
                            13'd169: pixel_data <= 16'hF748;
                            13'd170: pixel_data <= 16'hF748;
                            13'd171: pixel_data <= 16'h0;
                            13'd172: pixel_data <= 16'h0;
                            13'd173: pixel_data <= 16'h21;
                            13'd174: pixel_data <= 16'h0;
                            13'd175: pixel_data <= 16'h0;
                            13'd176: pixel_data <= 16'h0;
                            13'd177: pixel_data <= 16'h0;
                            13'd178: pixel_data <= 16'h0;
                            13'd179: pixel_data <= 16'h0;
                            13'd180: pixel_data <= 16'h0;
                            13'd181: pixel_data <= 16'h0;
                            13'd182: pixel_data <= 16'h0;
                            13'd183: pixel_data <= 16'h0;
                            13'd184: pixel_data <= 16'h0;
                            13'd185: pixel_data <= 16'h0;
                            13'd186: pixel_data <= 16'h0;
                            13'd187: pixel_data <= 16'h0;
                            13'd188: pixel_data <= 16'h0;
                            13'd189: pixel_data <= 16'h0;
                            13'd190: pixel_data <= 16'h0;
                            13'd191: pixel_data <= 16'h0;
                            13'd192: pixel_data <= 16'h0;
                            13'd193: pixel_data <= 16'h0;
                            13'd194: pixel_data <= 16'h0;
                            13'd195: pixel_data <= 16'h0;
                            13'd196: pixel_data <= 16'h0;
                            13'd197: pixel_data <= 16'h0;
                            13'd198: pixel_data <= 16'h0;
                            13'd199: pixel_data <= 16'h0;
                            13'd200: pixel_data <= 16'h0;
                            13'd201: pixel_data <= 16'h0;
                            13'd202: pixel_data <= 16'h0;
                            13'd203: pixel_data <= 16'h0;
                            13'd204: pixel_data <= 16'h0;
                            13'd205: pixel_data <= 16'h0;
                            13'd206: pixel_data <= 16'h0;
                            13'd207: pixel_data <= 16'h0;
                            13'd208: pixel_data <= 16'h0;
                            13'd209: pixel_data <= 16'h0;
                            13'd210: pixel_data <= 16'h840;
                            13'd211: pixel_data <= 16'h860;
                            13'd212: pixel_data <= 16'hE731;
                            13'd213: pixel_data <= 16'h0;
                            13'd214: pixel_data <= 16'hEEF3;
                            13'd215: pixel_data <= 16'h0;
                            13'd216: pixel_data <= 16'h1880;
                            13'd217: pixel_data <= 16'h0;
                            13'd218: pixel_data <= 16'hE70F;
                            13'd219: pixel_data <= 16'h0;
                            13'd220: pixel_data <= 16'h1860;
                            13'd221: pixel_data <= 16'h0;
                            13'd222: pixel_data <= 16'h800;
                            13'd223: pixel_data <= 16'h800;
                            13'd224: pixel_data <= 16'h0;
                            13'd225: pixel_data <= 16'hEF30;
                            13'd226: pixel_data <= 16'h0;
                            13'd227: pixel_data <= 16'h840;
                            13'd228: pixel_data <= 16'h0;
                            13'd229: pixel_data <= 16'h0;
                            13'd230: pixel_data <= 16'h0;
                            13'd231: pixel_data <= 16'h800;
                            13'd232: pixel_data <= 16'h0;
                            13'd233: pixel_data <= 16'h0;
                            13'd234: pixel_data <= 16'h0;
                            13'd235: pixel_data <= 16'hEF0F;
                            13'd236: pixel_data <= 16'h0;
                            13'd237: pixel_data <= 16'h20C0;
                            13'd238: pixel_data <= 16'hE710;
                            13'd239: pixel_data <= 16'h840;
                            13'd240: pixel_data <= 16'h840;
                            13'd241: pixel_data <= 16'hE710;
                            13'd242: pixel_data <= 16'h0;
                            13'd243: pixel_data <= 16'h0;
                            13'd244: pixel_data <= 16'h800;
                            13'd245: pixel_data <= 16'h0;
                            13'd246: pixel_data <= 16'hEF31;
                            13'd247: pixel_data <= 16'h0;
                            13'd248: pixel_data <= 16'h20;
                            13'd249: pixel_data <= 16'h0;
                            13'd250: pixel_data <= 16'h860;
                            13'd251: pixel_data <= 16'hF749;
                            13'd252: pixel_data <= 16'hFF69;
                            13'd253: pixel_data <= 16'h840;
                            13'd254: pixel_data <= 16'h0;
                            13'd255: pixel_data <= 16'hEF2F;
                            13'd256: pixel_data <= 16'h1880;
                            13'd257: pixel_data <= 16'h1860;
                            13'd258: pixel_data <= 16'hEEF1;
                            13'd259: pixel_data <= 16'h0;
                            13'd260: pixel_data <= 16'h0;
                            13'd261: pixel_data <= 16'h0;
                            13'd262: pixel_data <= 16'h0;
                            13'd263: pixel_data <= 16'h800;
                            13'd264: pixel_data <= 16'h0;
                            13'd265: pixel_data <= 16'hFF66;
                            13'd266: pixel_data <= 16'hF765;
                            13'd267: pixel_data <= 16'h0;
                            13'd268: pixel_data <= 16'h0;
                            13'd269: pixel_data <= 16'h0;
                            13'd270: pixel_data <= 16'h0;
                            13'd271: pixel_data <= 16'h0;
                            13'd272: pixel_data <= 16'h0;
                            13'd273: pixel_data <= 16'h0;
                            13'd274: pixel_data <= 16'h0;
                            13'd275: pixel_data <= 16'h0;
                            13'd276: pixel_data <= 16'h0;
                            13'd277: pixel_data <= 16'h0;
                            13'd278: pixel_data <= 16'h0;
                            13'd279: pixel_data <= 16'h0;
                            13'd280: pixel_data <= 16'h0;
                            13'd281: pixel_data <= 16'h0;
                            13'd282: pixel_data <= 16'h0;
                            13'd283: pixel_data <= 16'h0;
                            13'd284: pixel_data <= 16'h0;
                            13'd285: pixel_data <= 16'h0;
                            13'd286: pixel_data <= 16'h0;
                            13'd287: pixel_data <= 16'h0;
                            13'd288: pixel_data <= 16'h0;
                            13'd289: pixel_data <= 16'h0;
                            13'd290: pixel_data <= 16'h0;
                            13'd291: pixel_data <= 16'h0;
                            13'd292: pixel_data <= 16'h0;
                            13'd293: pixel_data <= 16'h0;
                            13'd294: pixel_data <= 16'h0;
                            13'd295: pixel_data <= 16'h0;
                            13'd296: pixel_data <= 16'h0;
                            13'd297: pixel_data <= 16'h0;
                            13'd298: pixel_data <= 16'h0;
                            13'd299: pixel_data <= 16'h0;
                            13'd300: pixel_data <= 16'h0;
                            13'd301: pixel_data <= 16'h0;
                            13'd302: pixel_data <= 16'h0;
                            13'd303: pixel_data <= 16'h0;
                            13'd304: pixel_data <= 16'h0;
                            13'd305: pixel_data <= 16'h0;
                            13'd306: pixel_data <= 16'h0;
                            13'd307: pixel_data <= 16'h0;
                            13'd308: pixel_data <= 16'h860;
                            13'd309: pixel_data <= 16'hE711;
                            13'd310: pixel_data <= 16'h0;
                            13'd311: pixel_data <= 16'h840;
                            13'd312: pixel_data <= 16'h0;
                            13'd313: pixel_data <= 16'h1080;
                            13'd314: pixel_data <= 16'hF72E;
                            13'd315: pixel_data <= 16'h1860;
                            13'd316: pixel_data <= 16'h1840;
                            13'd317: pixel_data <= 16'h1840;
                            13'd318: pixel_data <= 16'h0;
                            13'd319: pixel_data <= 16'h800;
                            13'd320: pixel_data <= 16'h0;
                            13'd321: pixel_data <= 16'hE70F;
                            13'd322: pixel_data <= 16'h0;
                            13'd323: pixel_data <= 16'h0;
                            13'd324: pixel_data <= 16'h800;
                            13'd325: pixel_data <= 16'h0;
                            13'd326: pixel_data <= 16'h800;
                            13'd327: pixel_data <= 16'h0;
                            13'd328: pixel_data <= 16'h20;
                            13'd329: pixel_data <= 16'h0;
                            13'd330: pixel_data <= 16'h800;
                            13'd331: pixel_data <= 16'hEF10;
                            13'd332: pixel_data <= 16'h20A0;
                            13'd333: pixel_data <= 16'h1880;
                            13'd334: pixel_data <= 16'hEF31;
                            13'd335: pixel_data <= 16'h800;
                            13'd336: pixel_data <= 16'h840;
                            13'd337: pixel_data <= 16'hEF10;
                            13'd338: pixel_data <= 16'h1880;
                            13'd339: pixel_data <= 16'h0;
                            13'd340: pixel_data <= 16'h1080;
                            13'd341: pixel_data <= 16'h1080;
                            13'd342: pixel_data <= 16'hE6F0;
                            13'd343: pixel_data <= 16'h840;
                            13'd344: pixel_data <= 16'h0;
                            13'd345: pixel_data <= 16'h0;
                            13'd346: pixel_data <= 16'h0;
                            13'd347: pixel_data <= 16'hEF2D;
                            13'd348: pixel_data <= 16'h0;
                            13'd349: pixel_data <= 16'hF72E;
                            13'd350: pixel_data <= 16'h1880;
                            13'd351: pixel_data <= 16'hF72E;
                            13'd352: pixel_data <= 16'h2080;
                            13'd353: pixel_data <= 16'h1840;
                            13'd354: pixel_data <= 16'hEF12;
                            13'd355: pixel_data <= 16'h1860;
                            13'd356: pixel_data <= 16'h0;
                            13'd357: pixel_data <= 16'h1080;
                            13'd358: pixel_data <= 16'h40;
                            13'd359: pixel_data <= 16'h0;
                            13'd360: pixel_data <= 16'h0;
                            13'd361: pixel_data <= 16'hFF66;
                            13'd362: pixel_data <= 16'hF766;
                            13'd363: pixel_data <= 16'h860;
                            13'd364: pixel_data <= 16'h0;
                            13'd365: pixel_data <= 16'h0;
                            13'd366: pixel_data <= 16'h0;
                            13'd367: pixel_data <= 16'h0;
                            13'd368: pixel_data <= 16'h0;
                            13'd369: pixel_data <= 16'h0;
                            13'd370: pixel_data <= 16'h0;
                            13'd371: pixel_data <= 16'h0;
                            13'd372: pixel_data <= 16'h0;
                            13'd373: pixel_data <= 16'h0;
                            13'd374: pixel_data <= 16'h0;
                            13'd375: pixel_data <= 16'h0;
                            13'd376: pixel_data <= 16'h0;
                            13'd377: pixel_data <= 16'h0;
                            13'd378: pixel_data <= 16'h0;
                            13'd379: pixel_data <= 16'h0;
                            13'd380: pixel_data <= 16'h0;
                            13'd381: pixel_data <= 16'h0;
                            13'd382: pixel_data <= 16'h0;
                            13'd383: pixel_data <= 16'h0;
                            13'd384: pixel_data <= 16'h0;
                            13'd385: pixel_data <= 16'h0;
                            13'd386: pixel_data <= 16'h0;
                            13'd387: pixel_data <= 16'h0;
                            13'd388: pixel_data <= 16'h0;
                            13'd389: pixel_data <= 16'h0;
                            13'd390: pixel_data <= 16'h0;
                            13'd391: pixel_data <= 16'h0;
                            13'd392: pixel_data <= 16'h0;
                            13'd393: pixel_data <= 16'h0;
                            13'd394: pixel_data <= 16'h0;
                            13'd395: pixel_data <= 16'h0;
                            13'd396: pixel_data <= 16'h0;
                            13'd397: pixel_data <= 16'h0;
                            13'd398: pixel_data <= 16'h0;
                            13'd399: pixel_data <= 16'h0;
                            13'd400: pixel_data <= 16'h800;
                            13'd401: pixel_data <= 16'h0;
                            13'd402: pixel_data <= 16'h0;
                            13'd403: pixel_data <= 16'h0;
                            13'd404: pixel_data <= 16'h20;
                            13'd405: pixel_data <= 16'hEF11;
                            13'd406: pixel_data <= 16'h0;
                            13'd407: pixel_data <= 16'h0;
                            13'd408: pixel_data <= 16'h0;
                            13'd409: pixel_data <= 16'h1080;
                            13'd410: pixel_data <= 16'hEF2D;
                            13'd411: pixel_data <= 16'hF730;
                            13'd412: pixel_data <= 16'hEF10;
                            13'd413: pixel_data <= 16'hEF10;
                            13'd414: pixel_data <= 16'hEEF3;
                            13'd415: pixel_data <= 16'h800;
                            13'd416: pixel_data <= 16'h0;
                            13'd417: pixel_data <= 16'hEF51;
                            13'd418: pixel_data <= 16'h0;
                            13'd419: pixel_data <= 16'h800;
                            13'd420: pixel_data <= 16'h800;
                            13'd421: pixel_data <= 16'h800;
                            13'd422: pixel_data <= 16'h0;
                            13'd423: pixel_data <= 16'h0;
                            13'd424: pixel_data <= 16'h0;
                            13'd425: pixel_data <= 16'h20;
                            13'd426: pixel_data <= 16'h20;
                            13'd427: pixel_data <= 16'hEF10;
                            13'd428: pixel_data <= 16'h20A0;
                            13'd429: pixel_data <= 16'h20C0;
                            13'd430: pixel_data <= 16'hEF10;
                            13'd431: pixel_data <= 16'h0;
                            13'd432: pixel_data <= 16'h0;
                            13'd433: pixel_data <= 16'hEF30;
                            13'd434: pixel_data <= 16'h1880;
                            13'd435: pixel_data <= 16'h20;
                            13'd436: pixel_data <= 16'h20;
                            13'd437: pixel_data <= 16'h1880;
                            13'd438: pixel_data <= 16'hEF10;
                            13'd439: pixel_data <= 16'h0;
                            13'd440: pixel_data <= 16'h800;
                            13'd441: pixel_data <= 16'h0;
                            13'd442: pixel_data <= 16'h0;
                            13'd443: pixel_data <= 16'hEF30;
                            13'd444: pixel_data <= 16'h0;
                            13'd445: pixel_data <= 16'hF72C;
                            13'd446: pixel_data <= 16'h28C0;
                            13'd447: pixel_data <= 16'hEF0D;
                            13'd448: pixel_data <= 16'h0;
                            13'd449: pixel_data <= 16'h0;
                            13'd450: pixel_data <= 16'h0;
                            13'd451: pixel_data <= 16'hEF11;
                            13'd452: pixel_data <= 16'hEF30;
                            13'd453: pixel_data <= 16'hE711;
                            13'd454: pixel_data <= 16'h840;
                            13'd455: pixel_data <= 16'h0;
                            13'd456: pixel_data <= 16'h860;
                            13'd457: pixel_data <= 16'hF749;
                            13'd458: pixel_data <= 16'hF728;
                            13'd459: pixel_data <= 16'h1080;
                            13'd460: pixel_data <= 16'h0;
                            13'd461: pixel_data <= 16'h20;
                            13'd462: pixel_data <= 16'h0;
                            13'd463: pixel_data <= 16'h0;
                            13'd464: pixel_data <= 16'h0;
                            13'd465: pixel_data <= 16'h0;
                            13'd466: pixel_data <= 16'h0;
                            13'd467: pixel_data <= 16'h0;
                            13'd468: pixel_data <= 16'h0;
                            13'd469: pixel_data <= 16'h0;
                            13'd470: pixel_data <= 16'h0;
                            13'd471: pixel_data <= 16'h0;
                            13'd472: pixel_data <= 16'h0;
                            13'd473: pixel_data <= 16'h0;
                            13'd474: pixel_data <= 16'h0;
                            13'd475: pixel_data <= 16'h0;
                            13'd476: pixel_data <= 16'h0;
                            13'd477: pixel_data <= 16'h0;
                            13'd478: pixel_data <= 16'h0;
                            13'd479: pixel_data <= 16'h0;
                            13'd480: pixel_data <= 16'h0;
                            13'd481: pixel_data <= 16'h0;
                            13'd482: pixel_data <= 16'h0;
                            13'd483: pixel_data <= 16'h0;
                            13'd484: pixel_data <= 16'h0;
                            13'd485: pixel_data <= 16'h0;
                            13'd486: pixel_data <= 16'h0;
                            13'd487: pixel_data <= 16'h0;
                            13'd488: pixel_data <= 16'h0;
                            13'd489: pixel_data <= 16'h0;
                            13'd490: pixel_data <= 16'h0;
                            13'd491: pixel_data <= 16'h0;
                            13'd492: pixel_data <= 16'h0;
                            13'd493: pixel_data <= 16'h0;
                            13'd494: pixel_data <= 16'h0;
                            13'd495: pixel_data <= 16'h0;
                            13'd496: pixel_data <= 16'h0;
                            13'd497: pixel_data <= 16'h0;
                            13'd498: pixel_data <= 16'h0;
                            13'd499: pixel_data <= 16'h0;
                            13'd500: pixel_data <= 16'h800;
                            13'd501: pixel_data <= 16'hEF10;
                            13'd502: pixel_data <= 16'h1860;
                            13'd503: pixel_data <= 16'h0;
                            13'd504: pixel_data <= 16'h0;
                            13'd505: pixel_data <= 16'h0;
                            13'd506: pixel_data <= 16'hEF0F;
                            13'd507: pixel_data <= 16'h0;
                            13'd508: pixel_data <= 16'h800;
                            13'd509: pixel_data <= 16'h0;
                            13'd510: pixel_data <= 16'h20;
                            13'd511: pixel_data <= 16'h0;
                            13'd512: pixel_data <= 16'h20;
                            13'd513: pixel_data <= 16'hE710;
                            13'd514: pixel_data <= 16'h1080;
                            13'd515: pixel_data <= 16'h0;
                            13'd516: pixel_data <= 16'h0;
                            13'd517: pixel_data <= 16'h0;
                            13'd518: pixel_data <= 16'h0;
                            13'd519: pixel_data <= 16'h20;
                            13'd520: pixel_data <= 16'h0;
                            13'd521: pixel_data <= 16'h20;
                            13'd522: pixel_data <= 16'h880;
                            13'd523: pixel_data <= 16'hE710;
                            13'd524: pixel_data <= 16'h0;
                            13'd525: pixel_data <= 16'h1880;
                            13'd526: pixel_data <= 16'hEF31;
                            13'd527: pixel_data <= 16'h800;
                            13'd528: pixel_data <= 16'h0;
                            13'd529: pixel_data <= 16'hEF10;
                            13'd530: pixel_data <= 16'h1080;
                            13'd531: pixel_data <= 16'h860;
                            13'd532: pixel_data <= 16'h20;
                            13'd533: pixel_data <= 16'h1080;
                            13'd534: pixel_data <= 16'hEF11;
                            13'd535: pixel_data <= 16'h840;
                            13'd536: pixel_data <= 16'h0;
                            13'd537: pixel_data <= 16'h0;
                            13'd538: pixel_data <= 16'h0;
                            13'd539: pixel_data <= 16'hE70F;
                            13'd540: pixel_data <= 16'h20E0;
                            13'd541: pixel_data <= 16'hEF0C;
                            13'd542: pixel_data <= 16'h1880;
                            13'd543: pixel_data <= 16'hF72D;
                            13'd544: pixel_data <= 16'h1080;
                            13'd545: pixel_data <= 16'h840;
                            13'd546: pixel_data <= 16'h0;
                            13'd547: pixel_data <= 16'h840;
                            13'd548: pixel_data <= 16'h840;
                            13'd549: pixel_data <= 16'h0;
                            13'd550: pixel_data <= 16'hEF32;
                            13'd551: pixel_data <= 16'h20;
                            13'd552: pixel_data <= 16'h0;
                            13'd553: pixel_data <= 16'hEF2D;
                            13'd554: pixel_data <= 16'hEF2E;
                            13'd555: pixel_data <= 16'h40;
                            13'd556: pixel_data <= 16'h20;
                            13'd557: pixel_data <= 16'h0;
                            13'd558: pixel_data <= 16'h0;
                            13'd559: pixel_data <= 16'h0;
                            13'd560: pixel_data <= 16'h0;
                            13'd561: pixel_data <= 16'h0;
                            13'd562: pixel_data <= 16'h0;
                            13'd563: pixel_data <= 16'h0;
                            13'd564: pixel_data <= 16'h0;
                            13'd565: pixel_data <= 16'h0;
                            13'd566: pixel_data <= 16'h0;
                            13'd567: pixel_data <= 16'h0;
                            13'd568: pixel_data <= 16'h0;
                            13'd569: pixel_data <= 16'h0;
                            13'd570: pixel_data <= 16'h0;
                            13'd571: pixel_data <= 16'h0;
                            13'd572: pixel_data <= 16'h0;
                            13'd573: pixel_data <= 16'h0;
                            13'd574: pixel_data <= 16'h0;
                            13'd575: pixel_data <= 16'h0;
                            13'd576: pixel_data <= 16'h0;
                            13'd577: pixel_data <= 16'h0;
                            13'd578: pixel_data <= 16'h0;
                            13'd579: pixel_data <= 16'h0;
                            13'd580: pixel_data <= 16'h0;
                            13'd581: pixel_data <= 16'h0;
                            13'd582: pixel_data <= 16'h0;
                            13'd583: pixel_data <= 16'h0;
                            13'd584: pixel_data <= 16'h0;
                            13'd585: pixel_data <= 16'h0;
                            13'd586: pixel_data <= 16'h0;
                            13'd587: pixel_data <= 16'h0;
                            13'd588: pixel_data <= 16'h0;
                            13'd589: pixel_data <= 16'h0;
                            13'd590: pixel_data <= 16'h0;
                            13'd591: pixel_data <= 16'h21;
                            13'd592: pixel_data <= 16'h0;
                            13'd593: pixel_data <= 16'h20;
                            13'd594: pixel_data <= 16'h0;
                            13'd595: pixel_data <= 16'h0;
                            13'd596: pixel_data <= 16'h0;
                            13'd597: pixel_data <= 16'hEEEF;
                            13'd598: pixel_data <= 16'h1880;
                            13'd599: pixel_data <= 16'h0;
                            13'd600: pixel_data <= 16'h840;
                            13'd601: pixel_data <= 16'h0;
                            13'd602: pixel_data <= 16'hEF2F;
                            13'd603: pixel_data <= 16'h0;
                            13'd604: pixel_data <= 16'h0;
                            13'd605: pixel_data <= 16'h840;
                            13'd606: pixel_data <= 16'h20;
                            13'd607: pixel_data <= 16'h0;
                            13'd608: pixel_data <= 16'h20;
                            13'd609: pixel_data <= 16'hE72F;
                            13'd610: pixel_data <= 16'h18E0;
                            13'd611: pixel_data <= 16'h840;
                            13'd612: pixel_data <= 16'h0;
                            13'd613: pixel_data <= 16'h0;
                            13'd614: pixel_data <= 16'h20;
                            13'd615: pixel_data <= 16'h20;
                            13'd616: pixel_data <= 16'h20;
                            13'd617: pixel_data <= 16'h20;
                            13'd618: pixel_data <= 16'h40;
                            13'd619: pixel_data <= 16'hE710;
                            13'd620: pixel_data <= 16'h18C0;
                            13'd621: pixel_data <= 16'h0;
                            13'd622: pixel_data <= 16'hEF10;
                            13'd623: pixel_data <= 16'h0;
                            13'd624: pixel_data <= 16'h0;
                            13'd625: pixel_data <= 16'hEF11;
                            13'd626: pixel_data <= 16'h1080;
                            13'd627: pixel_data <= 16'h40;
                            13'd628: pixel_data <= 16'h40;
                            13'd629: pixel_data <= 16'h1880;
                            13'd630: pixel_data <= 16'hEF2E;
                            13'd631: pixel_data <= 16'h840;
                            13'd632: pixel_data <= 16'h0;
                            13'd633: pixel_data <= 16'h20;
                            13'd634: pixel_data <= 16'h0;
                            13'd635: pixel_data <= 16'hE70F;
                            13'd636: pixel_data <= 16'h0;
                            13'd637: pixel_data <= 16'h1880;
                            13'd638: pixel_data <= 16'hEF2F;
                            13'd639: pixel_data <= 16'hEF2D;
                            13'd640: pixel_data <= 16'h1080;
                            13'd641: pixel_data <= 16'h860;
                            13'd642: pixel_data <= 16'h20;
                            13'd643: pixel_data <= 16'h0;
                            13'd644: pixel_data <= 16'h0;
                            13'd645: pixel_data <= 16'h0;
                            13'd646: pixel_data <= 16'hE710;
                            13'd647: pixel_data <= 16'h0;
                            13'd648: pixel_data <= 16'h0;
                            13'd649: pixel_data <= 16'h1880;
                            13'd650: pixel_data <= 16'h1860;
                            13'd651: pixel_data <= 16'h20;
                            13'd652: pixel_data <= 16'h0;
                            13'd653: pixel_data <= 16'h20;
                            13'd654: pixel_data <= 16'h20;
                            13'd655: pixel_data <= 16'h0;
                            13'd656: pixel_data <= 16'h0;
                            13'd657: pixel_data <= 16'h0;
                            13'd658: pixel_data <= 16'h0;
                            13'd659: pixel_data <= 16'h0;
                            13'd660: pixel_data <= 16'h0;
                            13'd661: pixel_data <= 16'h0;
                            13'd662: pixel_data <= 16'h0;
                            13'd663: pixel_data <= 16'h0;
                            13'd664: pixel_data <= 16'h0;
                            13'd665: pixel_data <= 16'h0;
                            13'd666: pixel_data <= 16'h0;
                            13'd667: pixel_data <= 16'h0;
                            13'd668: pixel_data <= 16'h0;
                            13'd669: pixel_data <= 16'h0;
                            13'd670: pixel_data <= 16'h0;
                            13'd671: pixel_data <= 16'h0;
                            13'd672: pixel_data <= 16'h0;
                            13'd673: pixel_data <= 16'h0;
                            13'd674: pixel_data <= 16'h0;
                            13'd675: pixel_data <= 16'h0;
                            13'd676: pixel_data <= 16'h0;
                            13'd677: pixel_data <= 16'h0;
                            13'd678: pixel_data <= 16'h0;
                            13'd679: pixel_data <= 16'h0;
                            13'd680: pixel_data <= 16'h0;
                            13'd681: pixel_data <= 16'h0;
                            13'd682: pixel_data <= 16'h0;
                            13'd683: pixel_data <= 16'h0;
                            13'd684: pixel_data <= 16'h0;
                            13'd685: pixel_data <= 16'h0;
                            13'd686: pixel_data <= 16'h0;
                            13'd687: pixel_data <= 16'h20;
                            13'd688: pixel_data <= 16'h0;
                            13'd689: pixel_data <= 16'h20;
                            13'd690: pixel_data <= 16'h0;
                            13'd691: pixel_data <= 16'h20;
                            13'd692: pixel_data <= 16'h0;
                            13'd693: pixel_data <= 16'hEF10;
                            13'd694: pixel_data <= 16'h1880;
                            13'd695: pixel_data <= 16'h0;
                            13'd696: pixel_data <= 16'h0;
                            13'd697: pixel_data <= 16'h0;
                            13'd698: pixel_data <= 16'hEF2E;
                            13'd699: pixel_data <= 16'h0;
                            13'd700: pixel_data <= 16'h0;
                            13'd701: pixel_data <= 16'h1080;
                            13'd702: pixel_data <= 16'h860;
                            13'd703: pixel_data <= 16'h0;
                            13'd704: pixel_data <= 16'h0;
                            13'd705: pixel_data <= 16'hE72C;
                            13'd706: pixel_data <= 16'h20E0;
                            13'd707: pixel_data <= 16'h0;
                            13'd708: pixel_data <= 16'h0;
                            13'd709: pixel_data <= 16'h0;
                            13'd710: pixel_data <= 16'h20;
                            13'd711: pixel_data <= 16'h0;
                            13'd712: pixel_data <= 16'h0;
                            13'd713: pixel_data <= 16'h0;
                            13'd714: pixel_data <= 16'h840;
                            13'd715: pixel_data <= 16'hE6F0;
                            13'd716: pixel_data <= 16'h0;
                            13'd717: pixel_data <= 16'h2080;
                            13'd718: pixel_data <= 16'hF70D;
                            13'd719: pixel_data <= 16'h2080;
                            13'd720: pixel_data <= 16'h0;
                            13'd721: pixel_data <= 16'hEF31;
                            13'd722: pixel_data <= 16'h0;
                            13'd723: pixel_data <= 16'h840;
                            13'd724: pixel_data <= 16'h0;
                            13'd725: pixel_data <= 16'h2080;
                            13'd726: pixel_data <= 16'hFF4A;
                            13'd727: pixel_data <= 16'h1880;
                            13'd728: pixel_data <= 16'h0;
                            13'd729: pixel_data <= 16'h0;
                            13'd730: pixel_data <= 16'h840;
                            13'd731: pixel_data <= 16'hEF30;
                            13'd732: pixel_data <= 16'h1880;
                            13'd733: pixel_data <= 16'h1840;
                            13'd734: pixel_data <= 16'hEEF0;
                            13'd735: pixel_data <= 16'hEF0E;
                            13'd736: pixel_data <= 16'h1080;
                            13'd737: pixel_data <= 16'h0;
                            13'd738: pixel_data <= 16'h0;
                            13'd739: pixel_data <= 16'h0;
                            13'd740: pixel_data <= 16'h0;
                            13'd741: pixel_data <= 16'h10A0;
                            13'd742: pixel_data <= 16'hE730;
                            13'd743: pixel_data <= 16'h0;
                            13'd744: pixel_data <= 16'h0;
                            13'd745: pixel_data <= 16'hFF2B;
                            13'd746: pixel_data <= 16'hFF2A;
                            13'd747: pixel_data <= 16'h0;
                            13'd748: pixel_data <= 16'h20;
                            13'd749: pixel_data <= 16'h0;
                            13'd750: pixel_data <= 16'h0;
                            13'd751: pixel_data <= 16'h0;
                            13'd752: pixel_data <= 16'h0;
                            13'd753: pixel_data <= 16'h0;
                            13'd754: pixel_data <= 16'h0;
                            13'd755: pixel_data <= 16'h0;
                            13'd756: pixel_data <= 16'h0;
                            13'd757: pixel_data <= 16'h0;
                            13'd758: pixel_data <= 16'h0;
                            13'd759: pixel_data <= 16'h0;
                            13'd760: pixel_data <= 16'h0;
                            13'd761: pixel_data <= 16'h0;
                            13'd762: pixel_data <= 16'h0;
                            13'd763: pixel_data <= 16'h0;
                            13'd764: pixel_data <= 16'h0;
                            13'd765: pixel_data <= 16'h0;
                            13'd766: pixel_data <= 16'h0;
                            13'd767: pixel_data <= 16'h0;
                            13'd768: pixel_data <= 16'h0;
                            13'd769: pixel_data <= 16'h0;
                            13'd770: pixel_data <= 16'h0;
                            13'd771: pixel_data <= 16'h0;
                            13'd772: pixel_data <= 16'h0;
                            13'd773: pixel_data <= 16'h0;
                            13'd774: pixel_data <= 16'h0;
                            13'd775: pixel_data <= 16'h0;
                            13'd776: pixel_data <= 16'h0;
                            13'd777: pixel_data <= 16'h0;
                            13'd778: pixel_data <= 16'h0;
                            13'd779: pixel_data <= 16'h0;
                            13'd780: pixel_data <= 16'h0;
                            13'd781: pixel_data <= 16'h0;
                            13'd782: pixel_data <= 16'h0;
                            13'd783: pixel_data <= 16'h0;
                            13'd784: pixel_data <= 16'h0;
                            13'd785: pixel_data <= 16'h0;
                            13'd786: pixel_data <= 16'h20;
                            13'd787: pixel_data <= 16'h0;
                            13'd788: pixel_data <= 16'h0;
                            13'd789: pixel_data <= 16'hEF33;
                            13'd790: pixel_data <= 16'h0;
                            13'd791: pixel_data <= 16'h0;
                            13'd792: pixel_data <= 16'h20;
                            13'd793: pixel_data <= 16'h840;
                            13'd794: pixel_data <= 16'hEF31;
                            13'd795: pixel_data <= 16'hEF10;
                            13'd796: pixel_data <= 16'hE710;
                            13'd797: pixel_data <= 16'hE731;
                            13'd798: pixel_data <= 16'hDEF2;
                            13'd799: pixel_data <= 16'h0;
                            13'd800: pixel_data <= 16'h0;
                            13'd801: pixel_data <= 16'hEF2F;
                            13'd802: pixel_data <= 16'hEF2D;
                            13'd803: pixel_data <= 16'hEF0F;
                            13'd804: pixel_data <= 16'hEF12;
                            13'd805: pixel_data <= 16'hE6F4;
                            13'd806: pixel_data <= 16'h0;
                            13'd807: pixel_data <= 16'h0;
                            13'd808: pixel_data <= 16'h0;
                            13'd809: pixel_data <= 16'h0;
                            13'd810: pixel_data <= 16'h0;
                            13'd811: pixel_data <= 16'h1880;
                            13'd812: pixel_data <= 16'hEEF0;
                            13'd813: pixel_data <= 16'hF711;
                            13'd814: pixel_data <= 16'h2060;
                            13'd815: pixel_data <= 16'hEF10;
                            13'd816: pixel_data <= 16'hEF31;
                            13'd817: pixel_data <= 16'h0;
                            13'd818: pixel_data <= 16'h860;
                            13'd819: pixel_data <= 16'h0;
                            13'd820: pixel_data <= 16'hEF13;
                            13'd821: pixel_data <= 16'hF70D;
                            13'd822: pixel_data <= 16'hF70C;
                            13'd823: pixel_data <= 16'hEF0E;
                            13'd824: pixel_data <= 16'hE713;
                            13'd825: pixel_data <= 16'h0;
                            13'd826: pixel_data <= 16'h0;
                            13'd827: pixel_data <= 16'hE6D2;
                            13'd828: pixel_data <= 16'h0;
                            13'd829: pixel_data <= 16'h0;
                            13'd830: pixel_data <= 16'h800;
                            13'd831: pixel_data <= 16'hEF12;
                            13'd832: pixel_data <= 16'h0;
                            13'd833: pixel_data <= 16'h0;
                            13'd834: pixel_data <= 16'hEEF4;
                            13'd835: pixel_data <= 16'hF732;
                            13'd836: pixel_data <= 16'hE6EF;
                            13'd837: pixel_data <= 16'hE72F;
                            13'd838: pixel_data <= 16'h860;
                            13'd839: pixel_data <= 16'h0;
                            13'd840: pixel_data <= 16'h800;
                            13'd841: pixel_data <= 16'hFF2E;
                            13'd842: pixel_data <= 16'hEEED;
                            13'd843: pixel_data <= 16'h840;
                            13'd844: pixel_data <= 16'h0;
                            13'd845: pixel_data <= 16'h0;
                            13'd846: pixel_data <= 16'h0;
                            13'd847: pixel_data <= 16'h0;
                            13'd848: pixel_data <= 16'h0;
                            13'd849: pixel_data <= 16'h0;
                            13'd850: pixel_data <= 16'h0;
                            13'd851: pixel_data <= 16'h0;
                            13'd852: pixel_data <= 16'h0;
                            13'd853: pixel_data <= 16'h0;
                            13'd854: pixel_data <= 16'h0;
                            13'd855: pixel_data <= 16'h0;
                            13'd856: pixel_data <= 16'h0;
                            13'd857: pixel_data <= 16'h0;
                            13'd858: pixel_data <= 16'h0;
                            13'd859: pixel_data <= 16'h0;
                            13'd860: pixel_data <= 16'h0;
                            13'd861: pixel_data <= 16'h0;
                            13'd862: pixel_data <= 16'h0;
                            13'd863: pixel_data <= 16'h0;
                            13'd864: pixel_data <= 16'h0;
                            13'd865: pixel_data <= 16'h0;
                            13'd866: pixel_data <= 16'h0;
                            13'd867: pixel_data <= 16'h0;
                            13'd868: pixel_data <= 16'h0;
                            13'd869: pixel_data <= 16'h0;
                            13'd870: pixel_data <= 16'h0;
                            13'd871: pixel_data <= 16'h0;
                            13'd872: pixel_data <= 16'h0;
                            13'd873: pixel_data <= 16'h0;
                            13'd874: pixel_data <= 16'h0;
                            13'd875: pixel_data <= 16'h0;
                            13'd876: pixel_data <= 16'h0;
                            13'd877: pixel_data <= 16'h0;
                            13'd878: pixel_data <= 16'h0;
                            13'd879: pixel_data <= 16'h0;
                            13'd880: pixel_data <= 16'h0;
                            13'd881: pixel_data <= 16'h20;
                            13'd882: pixel_data <= 16'h0;
                            13'd883: pixel_data <= 16'h0;
                            13'd884: pixel_data <= 16'h0;
                            13'd885: pixel_data <= 16'h800;
                            13'd886: pixel_data <= 16'h0;
                            13'd887: pixel_data <= 16'h20;
                            13'd888: pixel_data <= 16'h40;
                            13'd889: pixel_data <= 16'h800;
                            13'd890: pixel_data <= 16'h0;
                            13'd891: pixel_data <= 16'h0;
                            13'd892: pixel_data <= 16'h860;
                            13'd893: pixel_data <= 16'h20;
                            13'd894: pixel_data <= 16'h40;
                            13'd895: pixel_data <= 16'h20;
                            13'd896: pixel_data <= 16'h0;
                            13'd897: pixel_data <= 16'h0;
                            13'd898: pixel_data <= 16'h0;
                            13'd899: pixel_data <= 16'h0;
                            13'd900: pixel_data <= 16'h800;
                            13'd901: pixel_data <= 16'h0;
                            13'd902: pixel_data <= 16'h0;
                            13'd903: pixel_data <= 16'h20;
                            13'd904: pixel_data <= 16'h20;
                            13'd905: pixel_data <= 16'h0;
                            13'd906: pixel_data <= 16'h20;
                            13'd907: pixel_data <= 16'h800;
                            13'd908: pixel_data <= 16'h0;
                            13'd909: pixel_data <= 16'h1000;
                            13'd910: pixel_data <= 16'h800;
                            13'd911: pixel_data <= 16'h800;
                            13'd912: pixel_data <= 16'h0;
                            13'd913: pixel_data <= 16'h840;
                            13'd914: pixel_data <= 16'h800;
                            13'd915: pixel_data <= 16'h0;
                            13'd916: pixel_data <= 16'h800;
                            13'd917: pixel_data <= 16'h800;
                            13'd918: pixel_data <= 16'h0;
                            13'd919: pixel_data <= 16'h0;
                            13'd920: pixel_data <= 16'h840;
                            13'd921: pixel_data <= 16'h0;
                            13'd922: pixel_data <= 16'h800;
                            13'd923: pixel_data <= 16'h0;
                            13'd924: pixel_data <= 16'h0;
                            13'd925: pixel_data <= 16'h0;
                            13'd926: pixel_data <= 16'h0;
                            13'd927: pixel_data <= 16'h0;
                            13'd928: pixel_data <= 16'h0;
                            13'd929: pixel_data <= 16'h800;
                            13'd930: pixel_data <= 16'h800;
                            13'd931: pixel_data <= 16'h800;
                            13'd932: pixel_data <= 16'h0;
                            13'd933: pixel_data <= 16'h840;
                            13'd934: pixel_data <= 16'h20;
                            13'd935: pixel_data <= 16'h0;
                            13'd936: pixel_data <= 16'h0;
                            13'd937: pixel_data <= 16'h800;
                            13'd938: pixel_data <= 16'h0;
                            13'd939: pixel_data <= 16'h40;
                            13'd940: pixel_data <= 16'h21;
                            13'd941: pixel_data <= 16'h0;
                            13'd942: pixel_data <= 16'h0;
                            13'd943: pixel_data <= 16'h0;
                            13'd944: pixel_data <= 16'h0;
                            13'd945: pixel_data <= 16'h0;
                            13'd946: pixel_data <= 16'h0;
                            13'd947: pixel_data <= 16'h0;
                            13'd948: pixel_data <= 16'h0;
                            13'd949: pixel_data <= 16'h0;
                            13'd950: pixel_data <= 16'h0;
                            13'd951: pixel_data <= 16'h0;
                            13'd952: pixel_data <= 16'h0;
                            13'd953: pixel_data <= 16'h0;
                            13'd954: pixel_data <= 16'h0;
                            13'd955: pixel_data <= 16'h0;
                            13'd956: pixel_data <= 16'h0;
                            13'd957: pixel_data <= 16'h0;
                            13'd958: pixel_data <= 16'h0;
                            13'd959: pixel_data <= 16'h0;
                            13'd960: pixel_data <= 16'h0;
                            13'd961: pixel_data <= 16'h0;
                            13'd962: pixel_data <= 16'h0;
                            13'd963: pixel_data <= 16'h0;
                            13'd964: pixel_data <= 16'h0;
                            13'd965: pixel_data <= 16'h0;
                            13'd966: pixel_data <= 16'h0;
                            13'd967: pixel_data <= 16'h0;
                            13'd968: pixel_data <= 16'h0;
                            13'd969: pixel_data <= 16'h0;
                            13'd970: pixel_data <= 16'h0;
                            13'd971: pixel_data <= 16'h0;
                            13'd972: pixel_data <= 16'h0;
                            13'd973: pixel_data <= 16'h0;
                            13'd974: pixel_data <= 16'h0;
                            13'd975: pixel_data <= 16'h0;
                            13'd976: pixel_data <= 16'h0;
                            13'd977: pixel_data <= 16'h0;
                            13'd978: pixel_data <= 16'h20;
                            13'd979: pixel_data <= 16'h0;
                            13'd980: pixel_data <= 16'h0;
                            13'd981: pixel_data <= 16'h801;
                            13'd982: pixel_data <= 16'h0;
                            13'd983: pixel_data <= 16'h0;
                            13'd984: pixel_data <= 16'h0;
                            13'd985: pixel_data <= 16'h0;
                            13'd986: pixel_data <= 16'h0;
                            13'd987: pixel_data <= 16'h801;
                            13'd988: pixel_data <= 16'h0;
                            13'd989: pixel_data <= 16'h21;
                            13'd990: pixel_data <= 16'h0;
                            13'd991: pixel_data <= 16'h0;
                            13'd992: pixel_data <= 16'h0;
                            13'd993: pixel_data <= 16'h800;
                            13'd994: pixel_data <= 16'h800;
                            13'd995: pixel_data <= 16'h801;
                            13'd996: pixel_data <= 16'h0;
                            13'd997: pixel_data <= 16'h0;
                            13'd998: pixel_data <= 16'h0;
                            13'd999: pixel_data <= 16'h0;
                            13'd1000: pixel_data <= 16'h20;
                            13'd1001: pixel_data <= 16'h20;
                            13'd1002: pixel_data <= 16'h0;
                            13'd1003: pixel_data <= 16'h800;
                            13'd1004: pixel_data <= 16'h800;
                            13'd1005: pixel_data <= 16'h800;
                            13'd1006: pixel_data <= 16'h800;
                            13'd1007: pixel_data <= 16'h0;
                            13'd1008: pixel_data <= 16'h20;
                            13'd1009: pixel_data <= 16'h0;
                            13'd1010: pixel_data <= 16'h0;
                            13'd1011: pixel_data <= 16'h800;
                            13'd1012: pixel_data <= 16'h800;
                            13'd1013: pixel_data <= 16'h0;
                            13'd1014: pixel_data <= 16'h0;
                            13'd1015: pixel_data <= 16'h0;
                            13'd1016: pixel_data <= 16'h0;
                            13'd1017: pixel_data <= 16'h0;
                            13'd1018: pixel_data <= 16'h0;
                            13'd1019: pixel_data <= 16'h0;
                            13'd1020: pixel_data <= 16'h0;
                            13'd1021: pixel_data <= 16'h0;
                            13'd1022: pixel_data <= 16'h20;
                            13'd1023: pixel_data <= 16'h0;
                            13'd1024: pixel_data <= 16'h840;
                            13'd1025: pixel_data <= 16'h800;
                            13'd1026: pixel_data <= 16'h800;
                            13'd1027: pixel_data <= 16'h800;
                            13'd1028: pixel_data <= 16'h0;
                            13'd1029: pixel_data <= 16'h0;
                            13'd1030: pixel_data <= 16'h20;
                            13'd1031: pixel_data <= 16'h0;
                            13'd1032: pixel_data <= 16'h0;
                            13'd1033: pixel_data <= 16'h0;
                            13'd1034: pixel_data <= 16'h0;
                            13'd1035: pixel_data <= 16'h0;
                            13'd1036: pixel_data <= 16'h0;
                            13'd1037: pixel_data <= 16'h800;
                            13'd1038: pixel_data <= 16'h800;
                            13'd1039: pixel_data <= 16'h0;
                            13'd1040: pixel_data <= 16'h0;
                            13'd1041: pixel_data <= 16'h0;
                            13'd1042: pixel_data <= 16'h0;
                            13'd1043: pixel_data <= 16'h0;
                            13'd1044: pixel_data <= 16'h0;
                            13'd1045: pixel_data <= 16'h0;
                            13'd1046: pixel_data <= 16'h0;
                            13'd1047: pixel_data <= 16'h0;
                            13'd1048: pixel_data <= 16'h0;
                            13'd1049: pixel_data <= 16'h0;
                            13'd1050: pixel_data <= 16'h0;
                            13'd1051: pixel_data <= 16'h0;
                            13'd1052: pixel_data <= 16'h0;
                            13'd1053: pixel_data <= 16'h0;
                            13'd1054: pixel_data <= 16'h0;
                            13'd1055: pixel_data <= 16'h0;
                            13'd1056: pixel_data <= 16'h0;
                            13'd1057: pixel_data <= 16'h0;
                            13'd1058: pixel_data <= 16'h0;
                            13'd1059: pixel_data <= 16'h0;
                            13'd1060: pixel_data <= 16'h0;
                            13'd1061: pixel_data <= 16'h0;
                            13'd1062: pixel_data <= 16'h0;
                            13'd1063: pixel_data <= 16'h0;
                            13'd1064: pixel_data <= 16'h0;
                            13'd1065: pixel_data <= 16'h0;
                            13'd1066: pixel_data <= 16'h0;
                            13'd1067: pixel_data <= 16'h0;
                            13'd1068: pixel_data <= 16'h0;
                            13'd1069: pixel_data <= 16'h0;
                            13'd1070: pixel_data <= 16'h0;
                            13'd1071: pixel_data <= 16'h0;
                            13'd1072: pixel_data <= 16'h0;
                            13'd1073: pixel_data <= 16'h0;
                            13'd1074: pixel_data <= 16'h0;
                            13'd1075: pixel_data <= 16'h0;
                            13'd1076: pixel_data <= 16'h0;
                            13'd1077: pixel_data <= 16'h0;
                            13'd1078: pixel_data <= 16'h0;
                            13'd1079: pixel_data <= 16'h0;
                            13'd1080: pixel_data <= 16'h0;
                            13'd1081: pixel_data <= 16'h0;
                            13'd1082: pixel_data <= 16'h0;
                            13'd1083: pixel_data <= 16'h0;
                            13'd1084: pixel_data <= 16'h0;
                            13'd1085: pixel_data <= 16'h0;
                            13'd1086: pixel_data <= 16'h0;
                            13'd1087: pixel_data <= 16'h0;
                            13'd1088: pixel_data <= 16'h0;
                            13'd1089: pixel_data <= 16'h0;
                            13'd1090: pixel_data <= 16'h0;
                            13'd1091: pixel_data <= 16'h0;
                            13'd1092: pixel_data <= 16'h0;
                            13'd1093: pixel_data <= 16'h0;
                            13'd1094: pixel_data <= 16'h0;
                            13'd1095: pixel_data <= 16'h0;
                            13'd1096: pixel_data <= 16'h0;
                            13'd1097: pixel_data <= 16'h0;
                            13'd1098: pixel_data <= 16'h0;
                            13'd1099: pixel_data <= 16'h0;
                            13'd1100: pixel_data <= 16'h0;
                            13'd1101: pixel_data <= 16'h0;
                            13'd1102: pixel_data <= 16'h0;
                            13'd1103: pixel_data <= 16'h0;
                            13'd1104: pixel_data <= 16'h0;
                            13'd1105: pixel_data <= 16'h0;
                            13'd1106: pixel_data <= 16'h0;
                            13'd1107: pixel_data <= 16'h0;
                            13'd1108: pixel_data <= 16'h0;
                            13'd1109: pixel_data <= 16'h0;
                            13'd1110: pixel_data <= 16'h0;
                            13'd1111: pixel_data <= 16'h0;
                            13'd1112: pixel_data <= 16'h0;
                            13'd1113: pixel_data <= 16'h0;
                            13'd1114: pixel_data <= 16'h0;
                            13'd1115: pixel_data <= 16'h0;
                            13'd1116: pixel_data <= 16'h0;
                            13'd1117: pixel_data <= 16'h0;
                            13'd1118: pixel_data <= 16'h0;
                            13'd1119: pixel_data <= 16'h0;
                            13'd1120: pixel_data <= 16'h0;
                            13'd1121: pixel_data <= 16'h0;
                            13'd1122: pixel_data <= 16'h0;
                            13'd1123: pixel_data <= 16'h0;
                            13'd1124: pixel_data <= 16'h0;
                            13'd1125: pixel_data <= 16'h0;
                            13'd1126: pixel_data <= 16'h0;
                            13'd1127: pixel_data <= 16'h0;
                            13'd1128: pixel_data <= 16'h0;
                            13'd1129: pixel_data <= 16'h0;
                            13'd1130: pixel_data <= 16'h0;
                            13'd1131: pixel_data <= 16'h0;
                            13'd1132: pixel_data <= 16'h0;
                            13'd1133: pixel_data <= 16'h0;
                            13'd1134: pixel_data <= 16'h0;
                            13'd1135: pixel_data <= 16'h0;
                            13'd1136: pixel_data <= 16'h0;
                            13'd1137: pixel_data <= 16'h0;
                            13'd1138: pixel_data <= 16'h0;
                            13'd1139: pixel_data <= 16'h0;
                            13'd1140: pixel_data <= 16'h0;
                            13'd1141: pixel_data <= 16'h0;
                            13'd1142: pixel_data <= 16'h0;
                            13'd1143: pixel_data <= 16'h0;
                            13'd1144: pixel_data <= 16'h0;
                            13'd1145: pixel_data <= 16'h0;
                            13'd1146: pixel_data <= 16'h0;
                            13'd1147: pixel_data <= 16'h0;
                            13'd1148: pixel_data <= 16'h0;
                            13'd1149: pixel_data <= 16'h0;
                            13'd1150: pixel_data <= 16'h0;
                            13'd1151: pixel_data <= 16'h0;
                            endcase
                end
             end
        else begin if((y<=63 && y>13) && ((x>20 && x<=22) || (x >28  &&  x<=30) || (x >36 && x<=38) || (x >44 && x<=46) || (x >52 && x<=54) || (x >60 && x<=62) || (x >68 && x<=70) || (x >76 && x<=78)))
            temp=2;
        else if(((y<=15 && y>13)||(y<=23 && y>21)||(y<=31 && y>29)||(y<=39 && y>37)||(y<=47 && y>45)||(y<=55 && y>53)||(y<=63 && y>61)) && ((x<=28 && x>22) || (x <=36  &&  x>30) || (x<=44 && x>38) || (x<=52 && x>46) || (x<=60 && x>54) || (x <=68 && x>62) || (x<=76  && x>70)))
            temp=2;
        else if(~((x>20 && x<=22) || (x >28  &&  x<=30) || (x >36 && x<=38) || (x >44 && x<=46) || (x >52 && x<=54) || (x >60 && x<=62) || (x >68 && x<=70) || (x >76 && x<=78)) && y>13 && ~((y<=15 && y>13)||(y<=23 && y>21)||(y<=31 && y>29)||(y<=39 && y>37)||(y<=47 && y>45)||(y<=55 && y>53)||(y<=63 && y>61))) begin
            //inserting colour to the gap spots
            if(y>=16 && y<22) begin
                if(x>22 && x<=28&&data[5][0]==1)begin
                    temp=colour[5][0];
                end
                else if(x>30&&x<=36&&data[5][1]==1)begin
                    temp=colour[5][1];
                end
                else if(x>38&&x<=44&&data[5][2]==1)begin
                    temp=colour[5][2];
                end
                else if(x>46&&x<=52&&data[5][3]==1)begin
                    temp=colour[5][3];
                end
                else if(x>54&&x<=60&&data[5][4]==1)begin
                    temp=colour[5][4];
                end
                else if(x>62&&x<=68&&data[5][5]==1)begin
                    temp=colour[5][5];
                end
                else if(x>70&&x<=76&&data[5][6]==1)begin
                    temp=colour[5][6];
                end
                else temp=3;
            end
        else if(y>=24 && y<30) begin
                if(x>22&&x<=28&&data[4][0]==1)begin
                temp=colour[4][0];
                end
                else if(x>30&&x<=36&&data[4][1]==1)begin
                    temp=colour[4][1];
                end
                else if(x>38&&x<=44&&data[4][2]==1)begin
                    temp=colour[4][2];
                end
                else if(x>46&&x<=52&&data[4][3]==1)begin
                    temp=colour[4][3];
                end
                else if(x>54&&x<=60&&data[4][4]==1)begin
                    temp=colour[4][4];
                end
                else if(x>62&&x<=68&&data[4][5]==1)begin
                    temp=colour[4][5];
                end
                else if(x>70&&x<=76&&data[4][6]==1)begin
                    temp=colour[4][6];
                end
                else temp=3;
            end
        else if(y>=32 && y<38) begin
                if(x>22&&x<=28&&data[3][0]==1)begin
                temp=colour[3][0];
                end
                else if(x>30&&x<=36&&data[3][1]==1)begin
                    temp=colour[3][1];
                end
                else if(x>38&&x<=44&&data[3][2]==1)begin
                    temp=colour[3][2];
                end
                else if(x>46&&x<=52&&data[3][3]==1)begin
                    temp=colour[3][3];
                end
                else if(x>54&&x<=60&&data[3][4]==1)begin
                    temp=colour[3][4];
                end
                else if(x>62&&x<=68&&data[3][5]==1)begin
                    temp=colour[3][5];
                end
                else if(x>70&&x<=76&&data[3][6]==1)begin
                    temp=colour[3][6];
                end
                else temp=3;
            end
        else if(y>=40 && y<46) begin
                if(x>22&&x<=28&&data[2][0]==1)begin
                temp=colour[2][0];
                end
                else if(x>30 && x<=36 && data[2][1]==1)begin
                    temp=colour[2][1];
                end
                else if(x>38&&x<=44&&data[2][2]==1)begin
                    temp=colour[2][2];
                end
                else if(x>46&&x<=52&&data[2][3]==1)begin
                    temp=colour[2][3];
                end
                else if(x>54&&x<=60&&data[2][4]==1)begin
                    temp=colour[2][4];
                end
                else if(x>62&&x<=68&&data[2][5]==1)begin
                    temp=colour[2][5];
                end
                else if(x>70&&x<=76&&data[2][6]==1)begin
                    temp=colour[2][6];
                end
                else temp=3;
            end
        else if(y>=48 && y<54) begin
                if(x>22&&x<=28&&data[1][0]==1)begin
                temp=colour[1][0];
                end
                else if(x>30&&x<=36&&data[1][1]==1)begin
                    temp=colour[1][1];
                end
                else if(x>38&&x<=44&&data[1][2]==1)begin
                    temp=colour[1][2];
                end
                else if(x>46&&x<=52&&data[1][3]==1)begin
                    temp=colour[1][3];
                end
                else if(x>54&&x<=60&&data[1][4]==1)begin
                    temp=colour[1][4];
                end
                else if(x>62&&x<=68&&data[1][5]==1)begin
                    temp=colour[1][5];
                end
                else if(x>70 && x<=76&&data[1][6]==1)begin
                    temp=colour[1][6];
                end
                else temp=3;
            end
        else if(y>=56 && y<62) begin
                if(x>22&&x<=28&&data[0][0]==1)begin
                temp=colour[0][0];
                end
                else if(x>30&&x<=36&&data[0][1]==1)begin
                    temp=colour[0][1];
                end
                else if(x>38&&x<=44&&data[0][2]==1)begin
                    temp=colour[0][2];
                end
                else if(x>46&&x<=52&&data[0][3]==1)begin
                    temp=colour[0][3];
                end
                else if(x>54&&x<=60&&data[0][4]==1)begin
                    temp=colour[0][4];
                end
                else if(x>62&&x<=68&&data[0][5]==1)begin
                    temp=colour[0][5];
                end
                else if(x>70 && x<=76&&data[0][6]==1)begin
                    temp=colour[0][6];
                end
                else temp=3;
        end
    end
    
    else
        temp=3;
    end
        case(temp)
        3'd0: pixel_data = 16'hF800;//red
        3'd1: pixel_data = 16'hFFE0;//yellow
        3'd2: pixel_data = 16'h00FF;//blue
        3'd3: pixel_data = 16'h0000;//black
        3'd4: pixel_data = 16'h0;//white
        
    endcase
    
    case(pos)
        3'd0: location=23;
        3'd1: location=31;
        3'd2: location=39;
        3'd3: location=47;
        3'd4: location=55;
        3'd5: location=63;
        3'd6: location=71;
    endcase        
    
                   
    end
    
    always @ (posedge c) begin
 
        
        if (reset==1) begin
        player=0;
        data[0]<=8'd0;
        data[1]<=8'd0;
        data[2]<=8'd0;
        data[3]<=8'd0;
        data[4]<=8'd0;
        data[5]<=8'd0;
        data[6]<=8'd0;
        colour[0]<=8'd0;
        colour[1]<=8'd0;
        colour[2]<=8'd0;
        colour[3]<=8'd0;
        colour[4]<=8'd0;
        colour[5]<=8'd0;
        colour[6]<=8'd0;
        end
        else
            player<=~player;
        case(dir)
        3'd0: if(c==1) begin
                
                if(data[4][0]==1 && data[5][0]==0) begin
                    data[5][0]=1; colour[5][0]=player; end
                else if(data[3][0]==1 && data[4][0]==0) begin
                    data[4][0]=1; colour[4][0]=player; end
                else if(data[2][0]==1 && data[3][0]==0) begin
                    data[3][0]=1; colour[3][0]=player; end
                else if(data[1][0]==1 && data[2][0]==0) begin
                    data[2][0]=1; colour[2][0]=player; end
                else if(data[0][0]==1 && data[1][0]==0) begin
                    data[1][0]=1; colour[1][0]=player; end
                else if(data[0][0]==0) begin
                    data[0][0]=1; colour[0][0]=player; end
                end
        3'd1: if(c==1) begin
                
              if(data[4][1]==1 && data[5][1]==0) begin
                    data[5][1]=1; colour[5][1]=player; end
                else if(data[3][1]==1 && data[4][1]==0) begin
                    data[4][1]=1; colour[4][1]=player; end
                else if(data[2][1]==1 && data[3][1]==0) begin
                    data[3][1]=1; colour[3][1]=player; end
                else if(data[1][1]==1 && data[2][1]==0) begin
                    data[2][1]=1; colour[2][1]=player; end
                else if(data[0][1]==1 && data[1][1]==0) begin
                    data[1][1]=1; colour[1][1]=player; end
                else if(data[0][1]==0)begin
                    data[0][1]=1; colour[0][1]=player; end
                end
        3'd2: if(c==1) begin
                
               if(data[4][2]==1 && data[5][2]==0) begin
                    data[5][2]=1; colour[5][2]=player; end
                else if(data[3][2]==1 && data[4][2]==0) begin
                    data[4][2]=1; colour[4][2]=player; end
                else if(data[2][2]==1 && data[3][2]==0) begin
                    data[3][2]=1; colour[3][2]=player; end
                else if(data[1][2]==1 && data[2][2]==0) begin
                    data[2][2]=1; colour[2][2]=player; end
                else if(data[0][2]==1 && data[1][2]==0) begin
                    data[1][2]=1; colour[1][2]=player; end
                else if(data[0][2]==0) begin
                    data[0][2]=1; colour[0][2]=player; end
                end
          3'd3: if(c==1) begin
                
                if(data[4][3]==1 && data[5][3]==0) begin
                    data[5][3]=1; colour[5][3]=player; end
                else if(data[3][3]==1 && data[4][3]==0) begin
                    data[4][3]=1; colour[4][3]=player; end
                else if(data[2][3]==1 && data[3][3]==0) begin
                    data[3][3]=1; colour[3][3]=player; end
                else if(data[1][3]==1 && data[2][3]==0) begin
                    data[2][3]=1; colour[2][3]=player; end
                else if(data[0][3]==1 && data[1][3]==0) begin
                    data[1][3]=1; colour[1][3]=player; end
                else if(data[0][3]==0) begin
                    data[0][3]=1; colour[0][3]=player; end
              end
         3'd4: if(c==1) begin
                
                if(data[4][4]==1 && data[5][4]==0) begin
                    data[5][4]=1; colour[5][4]=player; end
                else if(data[3][4]==1 && data[4][4]==0) begin
                    data[4][4]=1; colour[4][4]=player; end
                else if(data[2][4]==1 && data[3][4]==0) begin
                    data[3][4]=1; colour[3][4]=player; end
                else if(data[1][4]==1 && data[2][4]==0) begin
                    data[2][4]=1; colour[2][4]=player; end
                else if(data[0][4]==1 && data[1][4]==0) begin
                    data[1][4]=1; colour[1][4]=player; end
                else if(data[0][4]==0) begin
                    data[0][4]=1; colour[0][4]=player; end
                end
          3'd5: if(c==1) begin
                
                if(data[4][5]==1 && data[5][5]==0) begin
                    data[5][5]=1; colour[5][5]=player; end
                else if(data[3][5]==1 && data[4][5]==0) begin
                    data[4][5]=1; colour[4][5]=player; end
                else if(data[2][5]==1 && data[3][5]==0) begin
                    data[3][5]=1; colour[3][5]=player; end
                else if(data[1][5]==1 && data[2][5]==0) begin
                    data[2][5]=1; colour[2][5]=player; end
                else if(data[0][5]==1 && data[1][5]==0) begin
                    data[1][5]=1; colour[1][5]=player; end
                else if(data[0][5]==0) begin
                    data[0][5]=1; colour[0][5]=player; end
            end
          3'd6: if(c==1) begin
              
              if(data[4][6]==1 && data[5][6]==0) begin
                  data[5][6]=1; colour[5][6]=player; end
              else if(data[3][6]==1 && data[4][6]==0) begin
                  data[4][6]=1; colour[4][6]=player; end
              else if(data[2][6]==1 && data[3][6]==0) begin
                  data[3][6]=1; colour[3][6]=player; end
              else if(data[1][6]==1 && data[2][6]==0) begin
                  data[2][6]=1; colour[2][6]=player; end
              else if(data[0][6]==1 && data[1][6]==0) begin
                  data[1][6]=1; colour[1][6]=player; end
              else if(data[0][6]==0) begin
                  data[0][6]=1; colour[0][6]=player; end
              end
        endcase
    end
endmodule