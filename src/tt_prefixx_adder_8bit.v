module prefix_adder_8bit(
  input [7:0] a,
  input [7:0] b,
  output [7:0] sum
);
  wire [7:0] p, g;
  wire [7:0] c;
  
  // Etapa de pre-procesamiento
  assign p = a ^ b;
  assign g = a & b;
  
  // Etapa de prefix (Kogge-Stone)
  wire [6:0] p1, g1;
  wire [4:0] p2, g2;
  wire [0:0] p3, g3;
  
  // Primera etapa
  assign p1[0] = p[0] & p[1];
  assign g1[0] = (p[0] & g[1]) | g[0];
  assign p1[1] = p[1] & p[2];
  assign g1[1] = (p[1] & g[2]) | g[1];
  assign p1[2] = p[2] & p[3];
  assign g1[2] = (p[2] & g[3]) | g[2];
  assign p1[3] = p[3] & p[4];
  assign g1[3] = (p[3] & g[4]) | g[3];
  assign p1[4] = p[4] & p[5];
  assign g1[4] = (p[4] & g[5]) | g[4];
  assign p1[5] = p[5] & p[6];
  assign g1[5] = (p[5] & g[6]) | g[5];
  assign p1[6] = p[6] & p[7];
  assign g1[6] = (p[6] & g[7]) | g[6];
  
  // Segunda etapa
  assign p2[0] = p1[0] & p1[2];
  assign g2[0] = (p1[0] & g1[2]) | g1[0];
  assign p2[1] = p1[1] & p1[3];
  assign g2[1] = (p1[1] & g1[3]) | g1[1];
  assign p2[2] = p1[2] & p1[4];
  assign g2[2] = (p1[2] & g1[4]) | g1[2];
  assign p2[3] = p1[3] & p1[5];
  assign g2[3] = (p1[3] & g1[5]) | g1[3];
  assign p2[4] = p1[4] & p1[6];
  assign g2[4] = (p1[4] & g1[6]) | g1[4];
  
  // Tercera etapa
  assign p3[0] = p2[0] & p2[3];
  assign g3[0] = (p2[0] & g2[3]) | g2[0];
  
  // Cálculo de carries
  assign c[0] = 0;
  assign c[1] = g[0];
  assign c[2] = g1[0];
  assign c[3] = g1[1];
  assign c[4] = g2[0];
  assign c[5] = g2[1];
  assign c[6] = g2[2];
  assign c[7] = g3[0];
  
  // Suma final
  assign sum = p ^ {c[6:0], 1'b0};
endmodule
