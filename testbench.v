`timescale 1ns/1ns
`include "InstructionMemory.v"
`include "CU.v"

module CPU_TB;
  wire [31:0] instruction;
  reg clk;
  reg pc;

  reg [6:0] opcode;
  reg [2:0] funct3;
  reg [6:0] funct7;
  reg [11:0] imm;
  reg store;

  //--------------------PROVENIENTES DE CU--------------------
  reg Type_alu;
  reg [2:0]Type_dm;
  reg salida_funct3;
  reg store;
  reg controlALU;
  reg controlRF;
  reg we;
  reg [2:0] funct_imm;
  
  InstructionMemory im (
      .pc(pc),
      .instruction(instruction)
   );

  CU cu (
      .clk(clk),
      .opcode(opcode),
      .funct3(funct3),
      .funct7(funct7),
      .Type_alu(Type_alu),
      .Type_dm(Type_dm),
      .salida_funct3(salida_funct3),
      .store(store),
      .controlALU(controlALU),
      .controlRF(controlRF),
      .we(we),
      .funct_imm(funct_imm)
  );
  
  
  always begin
    #5;  // Espera 5 unidades de tiempo
    clk <= ~clk;  // Invierte el estado del reloj
  end
  
  initial begin
    $dumpfile("waveform.vcd"); $dumpvars(0, CPU_TB);

    $readmemb("instrucciones.txt", im.mem);

    #10;
    pc=0;
    #10;
    //----------------------------------------------------
    opcode = instruction[6:0];
    funct3 = instruction[14:12];
    if(opcode == 7'b0110011) begin //Tipo R
      funct7 = instruction[31:25];
    end else if(opcode == 7'b0010011 or opcode == 7'b0000011 or opcode == 7'b1100111 or opcode == 7'b1110011) begin // Tipo I
      imm = instruction[31:20];
    end else if(opcode == 7'b0100011) begin // Tipo S
      imm = {instruction[31:25], instruction[11:7]};
    end else begin
      $display("Instruccion no soportada por ahora");
    end
    $finish;
  end


endmodule