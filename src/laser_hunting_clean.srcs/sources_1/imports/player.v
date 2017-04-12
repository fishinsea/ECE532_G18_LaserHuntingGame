`timescale 1 ns / 1 ps

module player (
	clk,
	speaker,
	vcc,
	audiocontrol
);

input clk;
input [2:0] audiocontrol;
output speaker;
output vcc;

reg [23:0] counter_4Hz;
reg [2:0] counter_6MHz;
reg [13:0] count;
reg [13:0] origin;
reg audio_reg;
reg clk_6MHz;
reg clk_4Hz;
reg [4:0] note;
reg [7:0] len;
reg [7:0] lentwo;
reg [7:0] lenthree;
reg temp;

assign speaker = audio_reg;

initial begin 
    counter_6MHz = 0;
    counter_4Hz = 0;
    count = 0;
    origin = 0;
    audio_reg = 0;
    clk_6MHz = 0;
    clk_4Hz = 0;
    note = 0;
    temp = 1'b1;
    len = 0;
    lentwo = 0;
    lenthree = 0;
end

assign vcc = temp;

always @ (posedge clk) begin
    if (!audiocontrol[0]) begin
        temp <= 0;
    end
    else begin
        temp <= ~temp;
    end
end

always @ (posedge clk) begin
	counter_6MHz <= counter_6MHz + 1'b1;
	if (counter_6MHz == 4) begin
		clk_6MHz = ~clk_6MHz;
		counter_6MHz <= 24'b0;
	end
end

always @ (posedge clk) begin
	counter_4Hz <= counter_4Hz + 1'b1;
	if (counter_4Hz == 11999996) begin	
		clk_4Hz = ~clk_4Hz;
		counter_4Hz <= 24'b0;
	end
end

always @ (posedge clk_6MHz) begin
    if(count == 16383) begin
        count = origin;
        audio_reg = ~audio_reg;
    end else
		count = count + 1;
end


always @ (posedge clk_4Hz) begin
	case (note)
		'd1: origin <= 'd4916;
		'd2: origin <= 'd6168;
		'd3: origin <= 'd7281;
		'd4: origin <= 'd7791;
		'd5: origin <= 'd8730;
		'd6: origin <= 'd9565;
		'd7: origin <= 'd10310;
		'd8: origin <= 'd010647;
		'd9: origin <= 'd011272;
		'd10: origin <= 'd011831;
		'd11: origin <= 'd012087;
		'd12: origin <= 'd012556;
		'd13: origin <= 'd012974;
		'd14: origin <= 'd013346;
		'd15: origin <= 'd13516;
		'd16: origin <= 'd13829;
		'd17: origin <= 'd14108;
		'd18: origin <= 'd11535;
		'd19: origin <= 'd14470;
		'd20: origin <= 'd14678;
		'd21: origin <= 'd14864;
		default: origin <= 'd011111;
    endcase             
end

always @ (posedge clk_4Hz) begin
    if (!audiocontrol[1]) begin
	if (len == 63)
		len <= 0;
    else
		len <= len + 1;
	
	case (len)
		0: note <= 3;
		1: note <= 3;
		2: note <= 3;
		3: note <= 3;
		4: note <= 5;
		5: note <= 5;
		6: note <= 5;
		7: note <= 6;
		8: note <= 8;
		9: note <= 8;
		10: note <= 8;
		11: note <= 6;
		12: note <= 6;
		13: note <= 6;
		14: note <= 6;
		15: note <= 12;
		16: note <= 12;
		17: note <= 12;
		18: note <= 15;
		19: note <= 15;
		20: note <= 15;
		21: note <= 15;
		22: note <= 15;
		23: note <= 9;
		24: note <= 9;
		25: note <= 9;
		26: note <= 9;
		27: note <= 9;
		28: note <= 9;
		29: note <= 9;
		30: note <= 9;
		31: note <= 9;
		32: note <= 9;
		33: note <= 9;
		34: note <= 10;
		35: note <= 7;
		36: note <= 7;
		37: note <= 6;
		38: note <= 6;
		39: note <= 5;
		40: note <= 5;
		41: note <= 5;
		42: note <= 6;
		43: note <= 8;
		44: note <= 8;
		45: note <= 9;
		46: note <= 9;
		47: note <= 3;
		48: note <= 3;
		49: note <= 8;
		50: note <= 8;
		51: note <= 8;
		52: note <= 5;
		53: note <= 5;
		54: note <= 8;
		55: note <= 5;
		56: note <= 5;
		57: note <= 5;
		58: note <= 5;
		59: note <= 5;
		60: note <= 5;
		61: note <= 5;
		62: note <= 5;
		63: note <= 5;
	endcase    
	end
	else begin
	   if (!audiocontrol[2]) begin
	   if (lentwo == 63)
            lentwo <= 0;
       else
            lentwo <= lentwo + 1;
            
	   case (lentwo)
	        0: note <= 13;
            1: note <= 19;
            2: note <= 13;
            3: note <= 19;
            4: note <= 13;
            5: note <= 19;
            6: note <= 13;
            7: note <= 19;
            8: note <= 13;
            9: note <= 19;
            10: note <= 13;
            11: note <= 19;
            12: note <= 13;
            13: note <= 19;
            14: note <= 13;
            15: note <= 19;
            16: note <= 13;
            17: note <= 19;
            18: note <= 13;
            19: note <= 19;
            20: note <= 13;
            21: note <= 19;
            22: note <= 13;
            23: note <= 19;
            24: note <= 13;
            25: note <= 19;
            26: note <= 13;
            27: note <= 19;
            28: note <= 13;
            29: note <= 19;
            30: note <= 13;
            31: note <= 19;
            32: note <= 13;
            33: note <= 19;
            34: note <= 13;
            35: note <= 19;
            36: note <= 13;
            37: note <= 19;
            38: note <= 13;
            39: note <= 19;
            40: note <= 13;
            41: note <= 19;
            42: note <= 13;
            43: note <= 19;
            44: note <= 13;
            45: note <= 19;
            46: note <= 13;
            47: note <= 19;
            48: note <= 13;
            49: note <= 19;
            50: note <= 13;
            51: note <= 19;
            52: note <= 13;
            53: note <= 19;
            54: note <= 13;
            55: note <= 19;
            56: note <= 13;
            57: note <= 19;
            58: note <= 13;
            59: note <= 19;
            60: note <= 13;
            61: note <= 19;
            62: note <= 13;
            63: note <= 19;
            endcase
            end
            
            else begin
             if (lenthree == 56)
                       lenthree <= 0;
                  else
                       lenthree <= lenthree + 1;
                       
                  case (lenthree)
                       0: note <= 6;
                       1: note <= 7;
                       2: note <= 8;
                       3: note <= 8;
                       4: note <= 7;
                       5: note <= 8;
                       6: note <= 8;
                       7: note <= 10;
                       8: note <= 10;
                       9: note <= 7;
                       10: note <= 7;
                       11: note <= 7;
                       12: note <= 7;
                       13: note <= 7;
                       14: note <= 7;
                       15: note <= 3;
                       16: note <= 3;
                       17: note <= 6;
                       18: note <= 6;
                       19: note <= 5;
                       20: note <= 6;
                       21: note <= 6;
                       22: note <= 8;
                       23: note <= 8;
                       24: note <= 5;
                       25: note <= 5;
                       26: note <= 5;
                       27: note <= 5;
                       28: note <= 5;
                       29: note <= 5;
                       30: note <= 3;
                       31: note <= 3;
                       32: note <= 4;
                       33: note <= 4;
                       34: note <= 3;
                       35: note <= 3;
                       36: note <= 4;
                       37: note <= 4;
                       38: note <= 8;
                       39: note <= 8;
                       40: note <= 3;
                       41: note <= 3;
                       42: note <= 8;
                       43: note <= 8;
                       44: note <= 8;
                       45: note <= 8;
                       46: note <= 8;
                       47: note <= 7;
                       48: note <= 7;
                       49: note <= 4;
                       50: note <= 4;
                       51: note <= 4;
                       52: note <= 7;
                       53: note <= 7;
                       54: note <= 7;
                       55: note <= 7;
                       endcase
            
            end
        end
	
	        
end
endmodule

