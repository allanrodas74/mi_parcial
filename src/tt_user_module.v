
module tt_um_allanrodas74(
  input [7:0] ui_in,
  output [7:0] uo_out
   input [7:0] uio_in,   // B[7:0] (o B[4:0] + OP[2:0])
   input ena, clk, rst_n
);
  // Entradas
wire [7:0] a = ui_in;
    wire [7:0] b = uio_in;  // Usa todos los 8 bits para B
    wire [2:0] op = uio_in[7:5];  // OP en los bits superiores de uio_in

  // Salidas
  reg [7:0] result;
  assign ui_out = result;
  
  // Sumador Prefix de 8 bits
  wire [3:0] sum;
  wire [7:0] b_neg = ~b + 1;
  wire [7:0] resta;
  prefix_adder_8bit adder(
    .a(a),
    .b(b),
    .sum(sum)
  );
  
  // Operaciones ALU
  always @(*) begin
    case(op)
      2'b000: result = sum;           // Suma
      2'b001: result = a - b;         // Resta
      2'b010: result = a & b;         // AND
      2'b011: result = a | b;         // OR
      2'b100: result = a ^ b;         // XOR
      2'b101: result = ~(a & b);      // NAND
      2'b110: result = ~(a | b);      // NOR
      2'b111: result = ~a;            // NOT
    endcase
  end
endmodule
