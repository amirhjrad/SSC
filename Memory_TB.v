`timescale 1ns/1ns
module Memory_TB; 
  reg clk, rst, readMem, writeMem;
  reg [7:0] addrBus;
  wire [15:0] inBus;
  wire [15:0] outBus;
  wire rdyMem;
  reg tri_en;
  reg [15:0] tri_input;

  Memory UUT(clk, rst, readMem, writeMem, addrBus, inBus, rdyMem, outBus);

  always #10 clk = ~clk;

  assign inBus = tri_en ? tri_input : 16'bz; // tri-state

  initial 
  begin
    clk <= 1'b0;  
    rst <= 1'b0;  
    readMem <= 1'b0;  
    writeMem <= 1'b0;  
    addrBus <= 16'b0;
    tri_input <= 16'b0;
    tri_en <= 1'b0;

    @(posedge clk)  rst <= 1'b1;
    @(posedge clk)  rst <= 1'b0;
    @(posedge clk)  addrBus <= 16'd3; writeMem <= 1'b1; tri_input <= 16'b0000000000001100; tri_en <= 1'b1;
    @(posedge clk)  writeMem <= 1'b0; tri_en <= 1'b0;
    @(posedge clk) ;
    @(posedge clk)  addrBus <= 16'd10; writeMem <= 1'b1; tri_input <= 16'b1111111000001111; tri_en <= 1'b1;
    @(posedge clk)  writeMem <= 1'b0; tri_en <= 1'b0;
    @(posedge clk) ;
    @(posedge clk)  addrBus <= 16'd255; writeMem <= 1'b1; tri_input <= 16'b1111111111111111; tri_en <= 1'b1;
    @(posedge clk)  writeMem <= 1'b0; tri_en <= 1'b0;
    @(posedge clk) ;
    @(posedge clk)  addrBus <= 16'd1; readMem <= 1'b1;
    @(posedge clk)  readMem <= 1'b0;
    @(posedge clk)  addrBus <= 16'd3; readMem <= 1'b1;
    @(posedge clk)  readMem <= 1'b0;
     @(posedge clk)  addrBus <= 16'd20; readMem <= 1'b1;
    @(posedge clk)  readMem <= 1'b0;
	@(posedge clk) $stop;
  end

endmodule


