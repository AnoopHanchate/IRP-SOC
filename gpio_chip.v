`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2023 23:59:32
// Design Name: 
// Module Name: gpio_chip
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


module gpio_chip(
input wire PCLK,
input wire PRESETn,
input wire PWrite,
input wire [3:0] PADDR,
input wire [7:0] PWDATA,
input wire PSEL,
input wire PENABLE,

output reg [7:0]PRDATA=0,
inout  pin1,pin2,pin3,pin4,pin5,pin6,pin7,pin8
);
wire PREADY;
reg  state,next;
integer i;
localparam IDLE=1'b0 ,SETUP=1'b1;
reg [7:0] psl=0,dir=0,set=0,clr=0,out=0,in=0;

assign PREADY = (PSEL && PENABLE) ? 1'b1 : 1'b0;
assign pin1=psl[0] && dir[0]? out[0] : 1'bZ;
assign pin2=psl[1] && dir[1]? out[1] : 1'bZ;
assign pin3=psl[2] && dir[2]? out[2] : 1'bZ;
assign pin4=psl[3] && dir[3]? out[3] : 1'bZ;
assign pin5=psl[4] && dir[4]? out[4] : 1'bZ;
assign pin6=psl[5] && dir[5]? out[5] : 1'bZ;
assign pin7=psl[6] && dir[6]? out[6] : 1'bZ;
assign pin8=psl[7] && dir[7]? out[7] : 1'bZ;


always @(posedge PCLK)
begin
if(PRESETn) 
    state<=IDLE;
else
    state<=next;
end

always @(negedge PCLK)
begin
next <=IDLE;
case(state)
IDLE:begin
    if(PREADY)
        next <=SETUP;
    else
        next <=IDLE;
end

SETUP:begin
    if(!PREADY)
      next <=IDLE;
    	
		
	if (PADDR[3:0] == 4'h0 && PWrite == 1) begin //data write
			 psl <=PWDATA[7:0];
     
		    end	
	 
	 if (PADDR[3:0] == 4'h4 && PWrite == 1) begin //data write

			 dir <=PWDATA[7:0];
     
		    end	
		    if (PADDR[3:0] == 4'h8 && PWrite == 1) begin //data write
	         set <=PWDATA[7:0];
     
		    end	
		    if (PADDR[3:0] == 4'hC && PWrite == 1) begin //data write
	    	 clr <=PWDATA[7:0];
     
		    end	
	else if(PADDR[3:0] == 4'h0 && PWrite == 0)begin	//data read                    
	       PRDATA[7:0] <= in;
          end 
	
  	 
	 
	 next<=SETUP;
    end


endcase

end

always @(posedge PCLK)
begin
    
    for(i=0;i<8;i=i+1)begin
	     if(set[i] && !clr[i])begin
		  out[i] <=1'b1;			
	     end
	     else if(clr[i])begin
	  	  out[i] <=1'b0; 
		  end
	if(i==0)begin	  
	if(!dir[i] &&  psl[i]) in[0]<=pin1;
	end
	
	if(i==1)begin
	if(!dir[i] &&  psl[i]) in[1]<=pin2;
	end
	
	if(i==2)begin
	if(!dir[i] &&  psl[i]) in[2]<=pin3;
	end
	
	if(i==3)begin
	if(!dir[i] &&  psl[i]) in[3]<=pin4;
	end
	
	if(i==4)begin
	if(!dir[i] &&  psl[i]) in[4]<=pin5;
	end
	
	if(i==5)begin
	if(!dir[i] &&  psl[i]) in[5]<=pin6;
	end
	
	if(i==6)begin
	if(!dir[i] &&  psl[i]) in[6]<=pin7;
	end
	
	if(i==7)begin
	if(!dir[i] &&  psl[i]) in[7]<=pin8;
   end
	     

end	
end 
endmodule
