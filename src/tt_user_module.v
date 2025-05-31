
module tt_um_allanrodas74(
  input [7:0] ui_in,
  output [7:0] uo_out
);
  // Entradas
  wire [3:0] a = ui_in[3:0];
  wire [3:0] b = ui_in[7:4];
  wire [1:0] op = ui_in[6:5];
  
  // Salidas
  reg [7:0] result;
  assign ui_out = result;
  
  // Sumador Prefix de 8 bits
  wire [3:0] sum;
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
