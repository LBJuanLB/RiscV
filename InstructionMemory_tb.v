`timescale 1ns/1ns
`include "InstructionMemory.v"

module InstructionMemory_tb;

  reg [32:0]pc;
  wire [31:0] instruction;
  parameter TAM = 1023;
  InstructionMemory #(TAM)im (
    .pc(pc),
    .instruction(instruction)
  );
  

  // Simulación de una secuencia de lectura de instrucciones.
  initial begin
    $dumpfile("InstructionMemory_tb.vcd");
    $dumpvars(0, InstructionMemory_tb);
    
    $readmemb("Binario_Inst.txt", im.mem);
    pc = 0; // Inicializa el contador de programa.
    #10;
    $display("Instrucción en dirección %d: %b", pc, instruction);
    pc = 4; // Inicializa el contador de programa.
    #10;
    $display("Instrucción en dirección %d: %b", pc, instruction);

    $finish; 
  end

endmodule