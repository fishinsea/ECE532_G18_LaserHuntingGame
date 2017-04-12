`timescale 1ns / 1ps

module gg_display(
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
               if (((hCounter >= 150 && hCounter <= 230) || (hCounter >= 250 && hCounter <= 330)) && vCounter >= 170 && vCounter <= 270) begin
                   if (hCounter <= 230) begin
                       if (hCounter <= 160 || vCounter <= 180 || vCounter >= 260 || (hCounter >= 220 && vCounter >= 220) || (vCounter >= 216 && vCounter <= 225 && hCounter >= 190)) begin
                           red = 4'b0110;
                           blue = 0;
                           green = 0;
                       end
                       else begin
                           red = 0;
                           blue = 0;
                           green = 0;
                       end
                   end
                   
                   if (hCounter >= 250) begin
                       if (hCounter <= 260 || vCounter <= 180 || vCounter >= 260 || (hCounter >= 320 && vCounter >= 220) || (vCounter >= 216 && vCounter <= 225 && hCounter >= 290)) begin
                           red = 4'b0110;
                           blue = 0;
                           green = 0;
                       end
                       else begin
                           red = 0;
                           blue = 0;
                           green = 0;
                       end
                   end
               end
               else begin
                   red = 0;
                   blue = 0;
                   green = 0;
               end
           end

                        // A 320 by 240 image is placed in the middle of a
                        //  640 by 480 screen
   			if(  vCounter  >= 270 || vCounter  <= 170) begin
   				address <= 17'b0; 
   				blank <= 1;
   				end
   			else begin
   				if ( hCounter  <= 330 && hCounter  >= 150) begin
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
