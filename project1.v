module project1 (
  input  start,clk,
  input  s1,s2,s3,  
  output reg [1:0]fpga_choice,
  output reg [2:0] result,
  output reg[2:0]A_count,
  output [7:0]R,G,B,
  output E,
  input clear
);
reg [7:0]random; //random
always@(posedge clk)
begin
	if(random>=231)random<=0;
	random<=random+1+s1+s2+s3;
end

parameter S0 = 2'b11, S1 = 2'b01, S2 = 2'b10;//平手,FPGA贏,玩家贏
parameter U0 = 2'b00, U1 = 2'b01, U2 = 2'b10;// rock, paper, scissors
reg [1:0] user;
always @ (posedge start) begin
   if (start) begin
		fpga_choice= random % 3;
   end
end
always @ (posedge s1,posedge s2,posedge s3) begin
		  if(s1==1)
			user <=U0;
		  else if(s2==1)begin
			user <=U1;
		  end
	     else if(s3==1)begin
         user <=U2;
		  end
end	  
always @(user)begin
   case (user)
      U0: begin
         case (fpga_choice)
          0: result <= S0; // draw
          1: result <= S1; // fpga wins
          2: result <= S2; // user wins
          endcase
      end
      U1: begin
         case (fpga_choice)
          0: result =S2; // user wins
          1: result =S0; // draw
          2: result =S1; // fpga wins
          endcase
      end
      U2: begin
         case (fpga_choice)
          0: result =S1; // fpga wins
          1: result =S2; // user wins
          2: result =S0; // draw
          endcase
      end
   endcase		
end
	divfreq F0(CLK,CLK_div);
		assign E =1'b1;
		assign R =8'b01111111;
		assign G =8'b10111111;
		assign B =8'b11011111;
		always@(posedge CLK_div,posedge clear)
			if(clear)A_count <=3'b000;
			else A_count <= A_count+1'b1;
	endmodule
	module divfreq(input CLK, output reg CLK_div);
	reg [24:0] Count;
	always @(posedge CLK)
		begin
			if(Count > 25000)
			begin
				 Count <= 25'b0;
				 CLK_div <= ~CLK_div;
			end
			else
				Count <= Count + 1'b1;
			end
	endmodule	