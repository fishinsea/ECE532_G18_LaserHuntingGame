`timescale 1ns / 1ps

module menu(
input clk25,
input tvalid,
output reg[3:0] red,
output reg[3:0] green,
output reg[3:0] blue,
output reg vga_hsync,
output reg vga_vsync

    );
    //Timing constants
      parameter hRez   = 640;
      parameter hStartSync   = 640+16;
      parameter hEndSync     = 640+16+96;
      parameter hMaxCount    = 800;

      parameter vRez         = 480;
      parameter vStartSync   = 480+10;
      parameter vEndSync     = 480+10+2;
      parameter vMaxCount    = 480+10+2+33;

    parameter hsync_active   =0;
    parameter vsync_active  = 0;
    reg[9:0] hCounter;
    reg[9:0] vCounter;
    reg[16:0] address;
    reg blank;
    reg[15:0] tens;
    reg[15:0] ones;
   initial   hCounter = 10'b0;
   initial   vCounter = 10'b0;
   initial   address = 17'b0;
   initial   blank = 1'b1;


   always@(posedge clk25)begin

            if( hCounter == hMaxCount-1 )begin
   				hCounter <=  10'b0;
   				if (vCounter == vMaxCount-1 )
   					vCounter <=  10'b0;
   				else
   					vCounter <= vCounter+1;
   				end
   			else
   				hCounter <= hCounter+1;

           if (blank == 0) begin
               //1P 
               if (hCounter > 30 && hCounter < 290 && vCounter > 270 && vCounter < 450) begin
                   //box
                   if ((hCounter <= 35 || hCounter >= 285) || (vCounter <= 275 || vCounter >= 445))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end

                   //1
                   else if ((hCounter >= 133 && hCounter <= 138) && (vCounter >= 295 && vCounter <= 425))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end

                   //P
                   else if (((hCounter >= 170 && hCounter <= 175) && (vCounter >= 295 && vCounter <= 425)) || ((hCounter >= 175 && hCounter <= 255) && (vCounter >= 295 && vCounter <= 300)) || ((hCounter >= 175 && hCounter <= 255) && (vCounter >= 360 && vCounter <= 365))|| ((hCounter >= 250 && hCounter <= 255) && (vCounter >= 300 && vCounter <= 360)))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end
                   else begin
                        red = 0;
                        blue = 0;
                        green = 0;
                   end
               end 
               
               //2P 
               else if (hCounter > 350 && hCounter < 610 && vCounter > 270 && vCounter < 450) begin
                   //box
                   if ((hCounter <= 355 || hCounter >=605) || (vCounter <= 275 || vCounter >= 445))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end
                   //2
                   else if (((hCounter >= 390 && hCounter <= 470) && (vCounter >= 295 && vCounter <= 300)) || ((hCounter >= 465 && hCounter <= 470) && (vCounter >= 300 && vCounter <= 360))|| ((hCounter >= 390 && hCounter <= 470) && (vCounter >= 360 && vCounter <= 365))|| ((hCounter >= 390 && hCounter <= 395) && (vCounter > 365 && vCounter < 425)) || ((hCounter >= 390 && hCounter <= 470) && (vCounter >= 425 && vCounter <= 430)))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end
                   
//                   else if 
                   //P
                   else if (((hCounter >= 490 && hCounter <= 495) && (vCounter >= 295 && vCounter <= 425)) || ((hCounter >= 495 && hCounter <= 575) && (vCounter >= 295 && vCounter <= 300)) || ((hCounter >= 495 && hCounter <= 575) && (vCounter >= 360 && vCounter <= 365))|| ((hCounter >= 570 && hCounter <= 575) && (vCounter >= 300 && vCounter <= 360)))
                   begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                   end
                   else begin
                        red = 0;
                        blue = 0;
                        green = 0;
                   end
               end 
               
               
               //MENU
               //M
               else if ((hCounter >= 30 && hCounter <= 35 && vCounter >= 20 && vCounter <= 120) || (hCounter >= 115 && hCounter <= 120 && vCounter >= 20 && vCounter <= 120)|| (vCounter - hCounter + 17 >= 0 && vCounter - hCounter + 17 <= 7 && hCounter >= 35 && hCounter <= 75) || (hCounter + vCounter >= 133 && hCounter + vCounter <= 140 && hCounter >= 75 && hCounter <= 115))
               begin
                      red = 4'b1111;
                      blue = 4'b1111;
                      green = 4'b1111;
               end
               //E
               else if ((hCounter >= 140 && hCounter <= 145 && vCounter >= 20 && vCounter <= 120) || (hCounter >= 145 && hCounter <= 230 && vCounter >= 20 && vCounter <= 25)|| (hCounter >= 145 && hCounter <= 230 && vCounter >= 67 && vCounter <= 73)|| (hCounter >= 145 && hCounter <= 230 && vCounter >= 115 && vCounter <= 120))
                      begin
                         red = 4'b1111;
                         blue = 4'b1111;
                         green = 4'b1111;
                      end
               //N
               else if ((hCounter >= 250 && hCounter <= 255 && vCounter >= 20 && vCounter <= 120) || (hCounter >= 340 && hCounter <= 345 && vCounter >= 20 && vCounter <= 120)|| (vCounter - hCounter + 240 >= 0 && vCounter - hCounter + 240 <= 7 && hCounter >= 255 && hCounter <= 345))
                     begin
                        red = 4'b1111;
                        blue = 4'b1111;
                        green = 4'b1111;
                     end
               //U
               else if ((hCounter >= 380 && hCounter <= 385 && vCounter >= 20 && vCounter <= 120) || (hCounter >= 465 && hCounter <= 470 && vCounter >= 20 && vCounter <= 120)|| (hCounter >= 385 && hCounter <= 465) && (vCounter >= 115) && (vCounter <= 120))
                    begin
                       red = 4'b1111;
                       blue = 4'b1111;
                       green = 4'b1111;
                    end
               
               else begin
                   red = 0;
                   blue = 0;
                   green = 0;
               end
               
               
            end

                        // A 320 by 240 image is placed in the middle of a
                        //  640 by 480 screen
   			if(  vCounter  >= 450 || vCounter  <= 10) begin
   				address <= 17'b0;
   				blank <= 1;
   				end
   			else begin
   				if ( hCounter  <= 605 && hCounter  >= 20) begin
   					blank <= 0;
   					address <= address+1;
   					end
   				else
   					blank <= 1;
   				end;

   			// Are we in the hSync pulse? (one has been added to include frame_buffer_latency)
   			if( hCounter > hStartSync && hCounter <= hEndSync)
   				vga_hsync <= hsync_active;
   			else
   				vga_hsync <= ~ hsync_active;


   			// Are we in the vSync pulse?
   			if( vCounter >= vStartSync && vCounter < vEndSync )
   				vga_vsync <= vsync_active;
   			else
   				vga_vsync <= ~ vsync_active;
   end
endmodule
