module goertzel_filter
  (input  [13:0] input_signal,
   input  clk,
   input  rst,
   output [39:0] magnitude);
  reg [17:0] n6_q1;
  reg [17:0] n6_q2;
  wire [35:0] n16_o;
  wire [35:0] n17_o;
  wire [35:0] n20_o;
  wire [17:0] n21_o;
  wire [17:0] n22_o;
  wire [30:0] n23_o;
  wire [30:0] n25_o;
  wire [13:0] n26_o;
  wire [17:0] n28_o;
  wire [17:0] n29_o;
  wire [35:0] n30_o;
  wire [35:0] n33_o;
  wire [35:0] n36_o;
  wire [17:0] n37_o;
  wire [17:0] n38_o;
  wire [35:0] n39_o;
  wire [35:0] n42_o;
  wire [35:0] n45_o;
  wire [17:0] n46_o;
  wire [35:0] n47_o;
  wire [35:0] n48_o;
  wire [35:0] n49_o;
  wire [39:0] n50_o;
  wire [35:0] n51_o;
  wire [35:0] n52_o;
  wire [35:0] n53_o;
  wire [39:0] n54_o;
  wire [39:0] n55_o;
  reg [17:0] n84_q;
  reg [17:0] n85_q;
  wire n101_o;
  wire [39:0] n102_o;
  reg [39:0] n103_q;
  assign magnitude = n103_q;
  /* goertzel_filter.vhd:33:18  */
  always @*
    n6_q1 = n84_q; // (isignal)
  initial
    n6_q1 = 18'b000000000000000000;
  /* goertzel_filter.vhd:34:18  */
  always @*
    n6_q2 = n85_q; // (isignal)
  initial
    n6_q2 = 18'b000000000000000000;
  /* goertzel_filter.vhd:48:38  */
  assign n16_o = {{18{n6_q1[17]}}, n6_q1}; // sext
  /* goertzel_filter.vhd:48:38  */
  assign n17_o = 36'b000000000000000000000100101001111111 * n16_o; // smul
  /* goertzel_filter.vhd:48:43  */
  assign n20_o = n17_o / 36'b000000000000000000000010011100010000; // sdiv
  /* goertzel_filter.vhd:48:19  */
  assign n21_o = n20_o[17:0];  // trunc
  /* goertzel_filter.vhd:48:73  */
  assign n22_o = n21_o - n6_q2;
  /* goertzel_filter.vhd:48:109  */
  assign n23_o = {17'b0, input_signal};  //  uext
  /* goertzel_filter.vhd:48:109  */
  assign n25_o = n23_o / 31'b0000000000000000000000001100100; // udiv
  /* goertzel_filter.vhd:48:109  */
  assign n26_o = n25_o[13:0];  // trunc
  /* goertzel_filter.vhd:48:94  */
  assign n28_o = {4'b0000, n26_o};
  /* goertzel_filter.vhd:48:78  */
  assign n29_o = n22_o + n28_o;
  /* goertzel_filter.vhd:52:41  */
  assign n30_o = {{18{n6_q1[17]}}, n6_q1}; // sext
  /* goertzel_filter.vhd:52:41  */
  assign n33_o = n30_o * 36'b000000000000000000000000001110110111; // smul
  /* goertzel_filter.vhd:52:50  */
  assign n36_o = n33_o / 36'b000000000000000000000000001111101000; // sdiv
  /* goertzel_filter.vhd:52:31  */
  assign n37_o = n36_o[17:0];  // trunc
  /* goertzel_filter.vhd:52:29  */
  assign n38_o = n29_o - n37_o;
  /* goertzel_filter.vhd:53:35  */
  assign n39_o = {{18{n6_q1[17]}}, n6_q1}; // sext
  /* goertzel_filter.vhd:53:35  */
  assign n42_o = n39_o * 36'b000000000000000000000000000100110101; // smul
  /* goertzel_filter.vhd:53:42  */
  assign n45_o = n42_o / 36'b000000000000000000000000001111101000; // sdiv
  /* goertzel_filter.vhd:53:25  */
  assign n46_o = n45_o[17:0];  // trunc
  /* goertzel_filter.vhd:54:50  */
  assign n47_o = {{18{n38_o[17]}}, n38_o}; // sext
  /* goertzel_filter.vhd:54:50  */
  assign n48_o = {{18{n38_o[17]}}, n38_o}; // sext
  /* goertzel_filter.vhd:54:50  */
  assign n49_o = n47_o * n48_o; // smul
  /* goertzel_filter.vhd:54:33  */
  assign n50_o = {{4{n49_o[35]}}, n49_o}; // sext
  /* goertzel_filter.vhd:54:99  */
  assign n51_o = {{18{n46_o[17]}}, n46_o}; // sext
  /* goertzel_filter.vhd:54:99  */
  assign n52_o = {{18{n46_o[17]}}, n46_o}; // sext
  /* goertzel_filter.vhd:54:99  */
  assign n53_o = n51_o * n52_o; // smul
  /* goertzel_filter.vhd:54:83  */
  assign n54_o = {{4{n53_o[35]}}, n53_o}; // sext
  /* goertzel_filter.vhd:54:81  */
  assign n55_o = n50_o + n54_o;
  /* goertzel_filter.vhd:47:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n84_q <= 18'b000000000000000000;
    else
      n84_q <= n29_o;
  /* goertzel_filter.vhd:47:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n85_q <= 18'b000000000000000000;
    else
      n85_q <= n6_q1;
  /* goertzel_filter.vhd:31:5  */
  assign n101_o = ~rst;
  /* goertzel_filter.vhd:47:9  */
  assign n102_o = n101_o ? n55_o : n103_q;
  /* goertzel_filter.vhd:47:9  */
  always @(posedge clk)
    n103_q <= n102_o;
endmodule

