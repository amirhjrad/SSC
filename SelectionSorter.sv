module SelectionSorter(input clk,rst,start,output logic done,GT,CO1_t,CO2_t,rdyMem_t,output logic [3:0]ps,output logic [15:0]D1_PO_t,D2_PO_t,outBus_t,inBus_t,output logic [7:0] PO1_t,PO2_t,addrBus_t,output logic readMem_t,writeMem_t);


	wire [7:0] PO1;	
	wire inzP1,incP1,CO1;
	register_8bit_P1 P1(clk,rst,inzP1,incP1,PO1, CO1);
	
	wire [7:0] PI1,PO2;
	assign PI1 = PO1;
	wire inzP2,incP2,incLd,CO2;
	register_8bit_P2 P2(clk,rst,inzP2,incP2,incLd,PI1,PO2,CO2);

	wire [7:0] addrBus;
	MUX #(8) address(select_addr, PO1,PO2,addrBus);

	wire [15:0] inBus,outBus;
	wire writeMem,readMem,rdyMem;
	//Memory memory(clk, rst, readMem, writeMem, addrBus, inBus, rdyMem, outBus);

	wire [15:0] D1_PO;
	wire en_D1;
	register_16bit D1(clk,rst,en_D1,outBus,D1_PO);

	wire [15:0] D2_PO;
	wire en_D2;
	register_16bit D2(clk,rst,en_D2,outBus,D2_PO);	

	wire gt;
	comparator cmp(D1_PO,D2_PO, gt);

	MUX #(16) sel_Ds(select_D, D1_PO,D2_PO,inBus);
	
	wire [3:0] PS;
	controller ctrler(clk,rst,CO1,CO2,gt,start,readMem,writeMem,rdyMem,select_addr,select_D,incP1,inzP1,incP2,inzP2,incLd,en_D1,en_D2,done,PS);

	
	assign rdyMem_t = rdyMem;
	assign CO1_t = CO1;
	assign CO2_t = CO2;
	assign inBus_t = inBus;
	assign writeMem_t = writeMem;
	assign outBus_t = outBus;
	assign addrBus_t = addrBus;
	assign readMem_t = readMem;
	assign GT = gt;
	assign ps = PS;
	assign D1_PO_t = D1_PO;
	assign D2_PO_t = D2_PO;
	assign PO1_t = PO1;
	assign PO2_t = PO2;

endmodule
