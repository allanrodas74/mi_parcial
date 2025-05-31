`default_nettype none
`timescale 1ns / 1ps

module tb ();
  // Señales estándar de TinyTapeout
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  wire [7:0] uo_out;

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
    ena = 1;
    rst_n = 0;  // Reset inicial
    #10 rst_n = 1;
    
    // Prueba 1: Suma (a=3, b=5)
    ui_in = 8'b0000_0011;  // a=3, b=0 (op=00)
    #20;
    
    // Prueba 2: Resta (a=8, b=3)
    ui_in = 8'b0000_1000;  // a=8, b=0 (op=01)
    #20;
    
    $finish;
  end
endmodule
