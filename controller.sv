`timescale 1ns/1ns
module controller(
	input clk,
	input rst,
	input CO1,
	input CO2,
	input gt,
	input start,
	output logic readMem,
	output logic writeMem,
	input rdyMem,
	output logic select_addr,
	output logic select_D,
	output logic incP1,
	output logic inzP1,
	output logic incP2,
	output logic inzP2,
	output logic incLd,
	output logic en_D1,
	output logic en_D2,
	output logic done,
	output logic [3:0] PS
);
	logic [3:0] ps,ns;
	assign PS = ps;
always@(ps,CO1,CO2,gt,start) begin
		ns =  4'd0;
			case(ps)
				4'd0: begin //idle
					done = 0;
					inzP1 = 0;
					inzP2 = 0;
					incP1 = 0;
					incP2 = 0;
					incLd = 0;
					ns = (start)? 4'd1: 4'b0;
					if(ns == 4'd1) begin
							inzP1 = 1;
							inzP2 = 1;
							incP1 = 0;
							incP2 = 0;
							end
					end
				4'd1: begin //addr loading
					ns = 4'd2;
					if(ns == 4'd2) begin
							select_addr = 0;
							readMem = 1;
							writeMem = 0;
							en_D2 = 0;
							en_D1 = 1;
							incP1 = 0;
							incP2 = 0;
							inzP1 = 0;
							inzP2 = 0;
							incLd = 0;
							end
					end


				4'd2:   begin// D1 loading
					ns = 4'd3;
					if(ns == 4'd3) begin
							select_addr  = 1;
							en_D1 = 0;
							en_D2 = 1;
							incP2 = 0;
							end
					end


				4'd3:   begin// D2 loading
					ns = (gt)? 4'd4:4'd6;
					if(ns == 4'd6) incP2 = 1;
					else if(ns == 4'd4) begin
							    writeMem = 1;
						            readMem = 0;
					                    select_D = 0;						
							    end
					end


				4'd4:   begin// swap 1
					ns = 4'd5;
					if(ns == 3'd5) begin
						       select_addr = 0;
						       select_D = 1;							
						       end
					end


				4'd5:   begin// swap 2
					ns = 4'd6;
					if(ns == 4'd6) incP2 = 1;
					end


				4'd6:   begin// increament p2
					ns = (CO2)? 4'd7:4'd2;
					if(ns == 4'd7) begin
							incP1 = 1;
							incLd = 1;
							end
					else if(ns == 4'd2)begin
							select_addr = 0;
							readMem = 1;
							writeMem = 0;
							en_D2 = 0;
							en_D1 = 1;
							incP1 = 0;
							incP2 = 0;
							inzP1 = 0;
							inzP2 = 0;	
							incLd = 0;							
							end
					end


				4'd7:   begin// increament p1
					ns = (CO1)?4'd8:4'd2;
					if(ns == 4'd2) begin
							select_addr = 0;
							readMem = 1;
							writeMem = 0;
							en_D2 = 0;
							en_D1 = 1;
							incP1 = 0;
							incP2 = 0;
							inzP1 = 0;
							inzP2 = 0;	
							incLd = 0;
							end
					end


				4'd8:   begin// done
					done = 1;
					writeMem = 0;
					ns = 4'd0;
					end


				default ns = 4'd0;
			endcase
	end

always@(posedge clk,posedge rst) begin
	if(rst)
		ps<= 4'd0;
	else
		ps<=ns;
	end
endmodule
