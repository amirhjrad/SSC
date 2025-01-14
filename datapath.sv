`timescale 1ns/1ns
module register_8bit_P1(input clk,rst,inzP1,incP1,output logic [7:0]PO1,output logic CO1);
always @(posedge clk,posedge rst) begin
	if(rst) PO1 <= 8'd0;
	else begin
		if(inzP1) PO1<=8'd0;	
		else if(incP1)begin
			PO1<=PO1+1;
			//CO1 = (PO1 == 8'b11111110)?1'b1:1'b0;
			end
		end
end
assign CO1 = &(PO1);
endmodule



module register_8bit_P2(input clk,rst,inzP2,incP2,incLd,input [7:0] PI1,output logic [7:0]PO2,output logic CO2);
always @(posedge clk,posedge rst) begin
	if(rst) PO2 <= 8'd0;
	else begin
		if(inzP2)
			PO2<={7'b0,1'b1};	
		if(incP2)begin
			PO2<=PO2+1;
			if(PO2 == 8'b11111111) CO2<=1'b1;
			else CO2 <= 1'b0;
		end
		if(incLd)
			PO2<=PI1 + 2;
	end
end
endmodule






module register_16bit(input clk,rst,ld,input [15:0]PI,output logic [15:0] PO);
always @(posedge clk,posedge rst) begin
	if (rst)
		PO<=16'd0;
	else begin
	if(ld)
		PO<=PI;
	end
end
endmodule






module MUX #(parameter BIT_SIZE) (input s,input [BIT_SIZE-1:0] a,b,output [BIT_SIZE-1:0] w);
	assign w=(~s)?a:b;
endmodule





module comparator(input [15:0] P1,P2,output gt);
	assign gt=(P1>P2)?1'b1:1'b0;
endmodule
