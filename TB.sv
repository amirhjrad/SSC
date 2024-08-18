`timescale 1ns / 1ns
module TB();
	logic clk,rst,start;
	wire done,GT,readMem_t,writeMem_t,CO1_t,CO2_t,rdyMem;
	wire [15:0] D1_PO_t,D2_PO_t,outBus_t,inBus_t;
	wire [3:0] ps;
	wire [7:0] PO1_t,PO2_t,addrBus_t;
	SelectionSorter UUT(clk,rst,start,done,GT,CO1_t,CO2_t,rdyMem,ps,D1_PO_t,D2_PO_t,outBus_t,inBus_t,PO1_t,PO2_t,addrBus_t,readMem_t,writeMem_t);
	initial begin
	rst = 1'b0;
	#1  clk = 1'b0;
    	#10 start = 1'b1;
	#10 start = 1'b0;
    	#1000000 $stop;
	end
always #3 clk = ~clk;
endmodule
