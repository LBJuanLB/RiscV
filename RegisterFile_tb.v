// INTEGRANTES: -LUIS SEBASTIAN CONDE TORO
//              -JUAN JOSE ESPINOSA MENDEZ
// ASIGNATURA: ARQUITECTURA DE COMPUTADORES
// PERIODO: 2023-2

`timescale 1ns/1ns
`include "RegisterFile.v"

module RegisterFile_tb;
  reg clk;
  reg rst;
  reg [4:0] rs1, rs2;
  reg WriteEnable;
  reg [31:0] data;
  wire [31:0] data1, data2;
  reg [4:0] rd;

  // Instancia del RegisterFile
  RegisterFile rf (
    .clk(clk),
    .rst(rst),
    .rs1(rs1),
    .rs2(rs2),
    .WriteEnable(WriteEnable),
    .data(data),
    .data1(data1),
    .data2(data2),
    .rd(rd)
  );

  // Generación de señales de reloj
  always begin
    #5 clk = ~clk; // Genera un ciclo de reloj cada 10 unidades de tiempo
  end

  // Configuración de rs1 y rs2 desde el testbench
  initial begin
    $dumpfile("RegisterFile_tb.vcd");
    $dumpvars(0,RegisterFile_tb);
    
    clk = 1;
    rst = 1;      //Ponemos todos los registros con valor 0
    #10
    rst = 0;
    rs1 = 3;        // Ejemplo: Asigna la direccion 2 a rs1
    rs2 = 2;       // Ejemplo: Asigna la direccion 2 a rs2
    rd = 2;
    data = 32'b00000000000000000000000000000001;
    WriteEnable = 1; // Habilita la escritura

    // Simulación de una secuencia de escritura y lectura en registros
    #10; // Espera un ciclo de reloj
    $display("rs1 = %b, rs2 = %b, RD = %b", rs1, rs2, rd);
    $display("data1 = %b",data1);
    $display("data2 = %b",data2);

    // Comprobando que en el registro x0 no se pueda escribir
    rs1 = 0;
    rs2 = 2;
    rd = 0;
    data = 32'b11111111111111111111111111111111;
    #10
    $display("rs1 = %b, rs2 = %b, RD = %b", rs1, rs2, rd);
    $display("data1 = %b",data1);
    $display("data2 = %b",data2);

    //Para este caso supongamos que mi registro destino tiene la direccion 0, sabemos que ahí no se puede escribir por lo que para comprobarlo le damos a data (contenido de rd) un valor cualquiera, entonces si a rs1 tambien le damos la direccion 0 por medio de data1 nos va a mostrar el contenido de la direccion 0, si lo que hicimos con rd cambió algo, ahí se mostrará, y la respuesta es NO, no se hizo escritura allí porque es el registro 0 de solo lectura y esto se demuestra con data1 en 0, no cambió.

    rs1 = 1;
    rs2 = 2;
    rd = 1;
    WriteEnable = 0; //Verificamos que no escriba mientras no se lo permitamos
    #10
    WriteEnable = 1; //Permitimos que se escriba data = 32'b11111111111111111111111111111111; en el registro destino 1
    #50
    // Finaliza la simulación
    $finish;
  end
endmodule
