`timescale 1ns / 1ps

module pause_display(
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
               if ((hCounter >= 95 && hCounter <= 135) || (hCounter >= 145 && hCounter <= 185) || (hCounter >= 195 && hCounter <= 235) || (hCounter >= 245 && hCounter <= 285) || (hCounter >= 295 && hCounter <= 335) || (hCounter >= 345 && hCounter <= 385)) begin
                   // P
                   if (hCounter <= 135) begin
                       if (hCounter <= 100 || vCounter <= 195 || (hCounter >= 130 && vCounter <= 220) || (vCounter >= 218 && vCounter <= 223)) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           red = 0;
                           blue = 0;
                           green = 0;
                       end
                   end
                   
                   // A
                   if (hCounter >= 145 && hCounter <= 185) begin
                       // diagonals
                       if ((hCounter + vCounter >= 343 && hCounter + vCounter <= 350) || (vCounter - hCounter >= 13 && vCounter - hCounter <= 20)) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           // horizontal and vertical 
                           // first: center horizontal line
                           // second: two legs
                           // third: short top line
                           if ((vCounter >= 218 && vCounter <= 223) || (vCounter >= 180 && (hCounter <= 150 || hCounter >= 180)) || (vCounter <= 195 && (hCounter >=155 && hCounter <= 175))) begin
                               red = 4'b1111;
                               blue = 4'b1000;
                               green = 4'b1000;
                           end
                           else begin
                               red = 0;
                               blue = 0;
                               green = 0;
                           end
                       end
                   end
                   
                   // U
                   if (hCounter >= 195 && hCounter <= 235) begin
                       if (hCounter <= 200 || hCounter >= 230 || vCounter >= 245) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           red = 0;
                           blue = 0;
                           green = 0;
                       end
                   end
                   
                   // S
                   if (hCounter >= 245 && hCounter <= 285) begin
                       if (vCounter <= 195 || (vCounter >= 218 && vCounter <= 223) || vCounter >= 245) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           if ((hCounter <= 250 && vCounter <= 220) || (hCounter >= 280 && vCounter >= 220)) begin
                               red = 4'b1111;
                               blue = 4'b1000;
                               green = 4'b1000;
                           end
                           else begin
                               red = 0;
                               blue = 0;
                               green = 0;
                           end
                       end
                   end
                   
                   // E
                   if (hCounter >= 295 && hCounter <= 335) begin
                       if (vCounter <= 195 || (vCounter >= 218 && vCounter <= 223) || vCounter >= 245) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           if (hCounter <= 300) begin
                               red = 4'b1111;
                               blue = 4'b1000;
                               green = 4'b1000;
                           end
                           else begin
                               red = 0;
                               blue = 0;
                               green = 0;
                           end
                       end
                   end
                   
                   // D
                   if (hCounter >= 345) begin
                       // diagonals
                       if (((hCounter - vCounter >= 175) && (hCounter - vCounter <= 185)) || ((hCounter + vCounter >= 615) && (hCounter + vCounter <= 625))) begin
                           red = 4'b1111;
                           blue = 4'b1000;
                           green = 4'b1000;
                       end
                       else begin
                           // verticals and horizontals
                           if (hCounter <= 350 || (hCounter <= 370 && (vCounter <= 195 || vCounter >= 245)) || (hCounter >= 380 && (vCounter >= 205 && vCounter <= 235))) begin
                               red = 4'b1111;
                               blue = 4'b1000;
                               green = 4'b1000;
                           end
                           else begin
                               red = 0;
                               blue = 0;
                               green = 0;
                           end
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
   			if(  vCounter  >= 250 || vCounter  <= 190) begin
   				address <= 17'b0; 
   				blank <= 1;
   				end
   			else begin
   				if ( hCounter  <= 385 && hCounter  >= 95) begin
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
