`timescale 1ns/1ns
module testTB();
	wire [7:0] PO2;
	logic [7:0] PI1;
	logic clk,rst,inzP2,incP2,CO2,incLd;
	register_8bit_P2 UUT(clk,rst,inzP2,incP2,incLd,PI1,PO2,CO2);
	initial begin
	#1 PI1 = 8'd4;
	#10 rst = 1'b0;
	#10  clk = 1'b0;
    	#10 inzP2 = 1'b1;
	#10 inzP2 = 1'b0;
	#400 incP2 = 1'b1;
	#100 incP2 = 1'b0;
	#10 incLd = 1'b1;
	#10 incLd = 0;
	#10 incP2 = 1;
	#10 PI1 = 8'd50; 
	#100 incLd = 1;
    	#6000 $stop;
	end
always #3 clk = ~clk;
endmodule
