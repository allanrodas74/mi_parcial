`default_nettype none
`timescale 1ns / 1ps

module tb ();
  // Señales estándar de TinyTapeout
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;   // A
  reg [7:0] uio_in;  // B + OP
  wire [7:0] uo_out; // RESULT

  // Instancia del módulo principal
  tt_um_allanrodas74 dut (
      .ui_in  (ui_in),   // Entradas de 8 bits
      .uo_out (uo_out),  // Salidas de 8 bits
      .ena    (ena),     // Enable
      .clk    (clk),     // Reloj
      .rst_n  (rst_n)    // Reset (activo bajo)
  );

  // Generación de reloj (10 ns periodo)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Inicialización y dump de señales
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
      reg [7:0] ui_in;   // A
  reg [7:0] uio_in;  // B + OP
  wire [7:0] uo_out; // RESULT
    
    // Prueba: A=3, B=5, OP=000 (suma)
    ui_in = 8'd3;
    uio_in = {3'b000, 5'd5};  // OP=000, B=5
    #20;
    $finish;
  end
endmodule
