`timescale 1ns / 1ps

module timer_display(
input clk25,
input [31:0] timer,
input tvalid,
output reg[3:0] vga_red,
output reg[3:0] vga_green,
output reg[3:0] vga_blue,
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
    reg[11:0] color;
   initial   hCounter = 10'b0;
   initial   vCounter = 10'b0;  
   initial   address = 17'b0;   
   initial   blank = 1'b1;    
   initial   color <= 12'b000000001111;
   
   always@(posedge clk25)begin
            // score split into tens and ones digits
            tens <= timer[31:16];
            ones <= timer[15:0];
            
            if( hCounter == hMaxCount-1 )begin
   				hCounter <=  10'b0;
   				if (vCounter == vMaxCount-1 )
   					vCounter <=  10'b0;
   				else
   					vCounter <= vCounter+1;
   				end
   			else
   				hCounter <= hCounter+1;
   
   			if (blank ==0 && tvalid) begin
   			    
              case (tens)
               0: begin
                       color = 12'b111100000000;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (hCounter > 163 && hCounter < 173 && vCounter > 93 && vCounter < 107) begin
                               vga_red <= 0;
                               vga_blue <= 0;
                               vga_green <= 0;
                           end
                           else begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];    
                           end
                       end
                   end
               1: begin 
                       color = 12'b111100001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (hCounter > 166 && hCounter < 170 && vCounter > 90 && vCounter < 110) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin
                              vga_red <= 0;
                              vga_blue <= 0;
                              vga_green <= 0;
                           end
                       end
                  end
               2: begin
                      color = 12'b111100001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if ((hCounter < 163 && vCounter > 100) || (hCounter > 173 && vCounter < 100)) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
                   
               3: begin
                       color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if (hCounter > 173) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
              
               4: begin
                    color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if ((vCounter < 100 && hCounter < 163) || (vCounter > 98 && vCounter < 101)) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if (hCounter > 173) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
                   
               5: begin
                        color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if ((hCounter < 163 && vCounter < 100) || (hCounter > 173 && vCounter > 100)) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
                   
               6: begin
                        color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if ((hCounter < 163) || (hCounter > 173 && vCounter > 100)) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
                   
               7: begin
                        color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || hCounter > 173) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               vga_red <= 0;
                               vga_blue <= 0;
                               vga_green <= 0;
                           end
                       end
                   end
                   
               8: begin
                        color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                      vga_red <= color[11:8];
                                                      vga_blue <= color[7:4];
                                                      vga_green <= color[3:0];
                           end
                           else begin 
                               if ((hCounter < 163) || (hCounter > 173)) begin
                                                          vga_red <= color[11:8];
                                                          vga_blue <= color[7:4];
                                                          vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
                   
               9: begin
                        color <= 12'b000000001111;
                       if (hCounter > 160 && hCounter < 176 && vCounter > 90 && vCounter < 110) begin
                           if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                               vga_red <= color[11:8];
                               vga_blue <= color[7:4];
                               vga_green <= color[3:0];
                           end
                           else begin 
                               if ((hCounter < 163 && vCounter < 100) || (hCounter > 173)) begin
                                  vga_red <= color[11:8];
                                  vga_blue <= color[7:4];
                                  vga_green <= color[3:0];
                               end
                               else begin
                                   vga_red <= 0;
                                   vga_blue <= 0;
                                   vga_green <= 0;
                               end
                           end
                       end
                   end
               
                       
                   
                   default: begin
                      vga_red   <= 4'b0;
                      vga_green <= 4'b0;
                      vga_blue  <= 4'b0;
                       end 
              endcase
                                  
   			    case (ones)
                0: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (hCounter > 193 && hCounter < 203 && vCounter > 93 && vCounter < 107) begin
                                vga_red <= 0;
                                vga_blue <= 0;
                                vga_green <= 0;
                            end
                            else begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];           
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                1: begin 
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (hCounter > 196 && hCounter < 200 && vCounter > 90 && vCounter < 110) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin
                               vga_red <= 0;
                               vga_blue <= 0;
                               vga_green <= 0;
                            end
                        end
                        else begin
                            if (hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) begin
                               vga_red <= 0;
                               vga_blue <= 0;
                               vga_green <= 0; 
                            end
                        end
                   end
                2: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if ((hCounter < 193 && vCounter > 100) || (hCounter > 203 && vCounter < 100)) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                3: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if (hCounter > 203) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
               
                4: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if ((vCounter < 100 && hCounter < 193) || (vCounter > 98 && vCounter < 101)) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if (hCounter > 203) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                5: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if ((hCounter < 193 && vCounter < 100) || (hCounter > 203 && vCounter > 100)) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                6: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if ((hCounter < 193) || (hCounter > 203 && vCounter > 100)) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                7: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || hCounter > 203) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                vga_red <= 0;
                                vga_blue <= 0;
                                vga_green <= 0;
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                8: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if ((hCounter < 193) || (hCounter > 203)) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    
                9: begin
                        if (hCounter > 190 && hCounter < 206 && vCounter > 90 && vCounter < 110) begin
                            if (vCounter < 93 || (vCounter > 98 && vCounter < 101) || vCounter > 107) begin
                                                       vga_red <= color[11:8];
                                                       vga_blue <= color[7:4];
                                                       vga_green <= color[3:0];
                            end
                            else begin 
                                if ((hCounter < 193 && vCounter < 100) || (hCounter > 203)) begin
                                                           vga_red <= color[11:8];
                                                           vga_blue <= color[7:4];
                                                           vga_green <= color[3:0];
                                end
                                else begin
                                    vga_red <= 0;
                                    vga_blue <= 0;
                                    vga_green <= 0;
                                end
                            end
                        end
                                                    else begin
                                                        if ((hCounter >= 176 && hCounter <= 190 && vCounter > 90 && vCounter < 110) || hCounter >= 206) begin
                                                           vga_red <= 0;
                                                           vga_blue <= 0;
                                                           vga_green <= 0; 
                                                        end
                                                    end
                    end
                    default: begin
                       vga_red   <= 4'b0;
                       vga_green <= 4'b0;
                       vga_blue  <= 4'b0;
                    end 
                endcase
                
   				end
   			else begin
   				vga_red   <= 4'b0;
   				vga_green <= 4'b0;
   				vga_blue  <= 4'b0;
   			     end;

                        // A 320 by 240 image is placed in the middle of a
                        //  640 by 480 screen
   			if(  vCounter  >= 120 || vCounter  < 90) begin
   				address <= 17'b0; 
   				blank <= 1;
   				end
   			else begin
   				if ( hCounter  < 480 && hCounter  >= 159) begin
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
