`timescale 1ns/1ps
module tt_um_allanrodas74(
  input [7:0] io_in,
  output [7:0] io_out
);
  // Entradas
  wire [7:0] a = io_in[7:0];
  wire [7:0] b = io_in[15:8];
  wire [2:0] op = io_in[18:16];
  
  // Salidas
  reg [7:0] result;
  assign io_out = result;
  
  // Sumador Prefix de 8 bits
  wire [7:0] sum;
  prefix_adder_8bit adder(
    .a(a),
    .b(b),
    .sum(sum)
  );
  
  // Operaciones ALU
  always @(*) begin
    case(op)
      3'b000: result = sum;           // Suma
      3'b001: result = a - b;         // Resta
      3'b010: result = a & b;         // AND
      3'b011: result = a | b;         // OR
      3'b100: result = a ^ b;         // XOR
      3'b101: result = ~(a & b);      // NAND
      3'b110: result = ~(a | b);      // NOR
      3'b111: result = ~a;            // NOT
    endcase
  end
endmodule
