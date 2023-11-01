//Integrantes: -Luis Sebastian Conde Toro
//             -Juan Jose Espinosa Mendez
//Asignatura: Arquitectura de computadores
//Periodo: 2023-2
//Profesor: Gustavo Adolfo Gutierrez Sabogal
`timescale 1ns/1ns
`include "alu.v"

module alu_tb();
  reg [31:0] operand1 = 32'b00111111111111111111111111111111; 
  reg [31:0] operand2 = 32'b00111111111111111111111111111111; 
  reg [2:0] funct3_alu;
  reg Type_alu;
  wire [31:0] result; 

  alu alu_instance( //Instancia ALU
    .operand1(operand1),
    .operand2(operand2),
    .funct3_alu(funct3_alu),
      .Type_alu(Type_alu),
      .result(result)
  );

  initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);

    //Caso de prueba 1: Suma - ADD (funct3_alu = 000 Type_alu = 0 )
    funct3_alu = 3'b000;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 1 - ADD");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);
    
    //Caso de prueba 2: Resta - SUB (funct3_alu = 000 Type_alu = 1)
    funct3_alu = 3'b000;
    Type_alu = 1'b1;
    #10
    $display("Caso de prueba 2 - SUB");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 3: XOR (funct3_alu = 100 Type_alu = 0 )
    funct3_alu = 3'b100;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 3 - XOR");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 4: OR (funct3_alu = 110)
    funct3_alu = 3'b110;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 4 - OR");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 5: AND (funct3_alu = 111 Type_alu = 0 )
    funct3_alu = 3'b111;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 5 - AND");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 6: Menor que sin signo (U) - SLT(U) (funct3_alu = 010 Type_alu = 1)
    funct3_alu = 3'b010;
    Type_alu = 1'b1;
    #10
    $display("Caso de prueba 6 - SLT(U)");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 7: Menor que - SLT (funct3_alu = 010 Type_alu = 0)
    funct3_alu = 3'b010;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 7 - SLT");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 8: Shift Left Logical - SLL (funct3_alu = 001)
    operand1 = 32'b00111111111111111111111111111111;
    operand2 = 32'b00000000000000000000000000000001;
    funct3_alu = 3'b001;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 8 - SLL");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 9: Mayor igual que - BGE (funct3_alu = 101 Type_alu = 1)
    operand1 = 32'b00111111111111111111111111111111;
    operand2 = 32'b00111111111111111111111111111111;
    funct3_alu = 3'b101;
    Type_alu = 1'b1;
    #10
    $display("Caso de prueba 9 - BGE");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 10: Shift right logical - SRL (funct3_alu = 101 Type_alu = 0)
    operand1 = 32'b00111111111111111111111111111111;
    operand2 = 32'b00000000000000000000000000000011;
    funct3_alu = 3'b101;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 10 - SRL");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 11: Multiplicacion - MUL (funct3_alu = 011 Type_alu = 1)
    operand1 = 32'b00111111111111111111111111111111;
    operand2 = 32'b00000000000000000000000000000011;
    funct3_alu = 3'b011;
    Type_alu = 1'b1;
    #10
    $display("Caso de prueba 11 - MUL");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);

    //Caso de prueba 12: División - DIV (funct3_alu = 011 Type_alu = 0)
    funct3_alu = 3'b011;
    Type_alu = 1'b0;
    #10
    $display("Caso de prueba 12 - DIV");
    $display("Operando 1: %b", operand1);
    $display("Operando 2: %b", operand2);
    $display("Resultado:  %b", result);
    
    $finish;
  end
endmodule
