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

輸出結果
![image](https://user-images.githubusercontent.com/122256841/211263964-afd30526-3973-4fce-ada5-07fe40ac3b29.png)

