# -NCNU FPGA 期末專案
功能說明:
玩家與FPGA對戰.
module project1 (
  input  clk,/時脈
  input  s1,s2,s3,start /剪刀,石頭,布,開始 接到 4-bit SW
  output reg [1:0]fpga_choice, /FPGA的出拳
  output reg [2:0] result, /結果  接到LED燈
  output reg[2:0]A_count, 
  output [7:0]R,G,B,
  output E,
  input clear
);
reg [7:0]random; //random 隨機產生一個數字
always@(posedge clk)
begin
	if(random>=231)random<=0;
	random<=random+1+s1+s2+s3;
end

parameter S0 = 2'b11, S1 = 2'b01, S2 = 2'b10;//平手,FPGA贏,玩家贏
parameter U0 = 2'b00, U1 = 2'b01, U2 = 2'b10;// 剪刀, 石頭, 布
reg [1:0] user;
always @ (posedge start) begin
   if (start) begin
		fpga_choice= random % 3;  /取隨機數字的餘數 0為剪刀 1為石頭 2為布/
   end
end
always @ (posedge s1,posedge s2,posedge s3) begin
		  if(s1==1)  /當剪刀按下時候 將剪刀的狀態賦予user
			user <=U0;
		  else if(s2==1)begin  /當石頭按下時候 將石頭的狀態賦予user
			user <=U1gˊ投
		  end
	     else if(s3==1)begin /當布按下時候 將布的狀態賦予user
         user <=U2;
		  end
end	  
always @(user)begin /當user改變時
   case (user)      /抓user
      U0: begin
         case (fpga_choice)//抓FPGA出拳
          0: result <= S0; // draw  平手 
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
