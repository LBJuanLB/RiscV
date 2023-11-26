`include "pc.v"
`include "InstructionMemory.v"
`include "alu.v"
`include "cu.v"
`include "RegisterFile.v"
`include "data_memory.v"
`include "mux.v"
`include "IMM.v"
`include "sumador.v"
`include "branch.v"
`include "mux3.v"
module CPU (
    input reset,//Reset del PC
    input rst,//Reset del Register File
    input clk
);
  //TAMAÑO DE LA MEMORIA
  parameter TAM = 1023;

  //PC
  wire [31:0] pc_in;
  wire [31:0] pc_out;
  //Sumador
  wire [31:0] sum_out;
  //Instruction Memory
  wire [31:0] instruction;
  //CU
  reg [6:0] opcode;
  reg [2:0] funct3;
  reg [6:0] funct7;
  wire Type_alu_dm;
  wire [2:0] Type_dm;
  wire [2:0] salida_funct3;
  wire store;
  wire controlALU;
  wire [1:0]controlRF;
  wire we;
  wire [2:0] funct_imm;
  wire controlOp1;
  //IMM
  reg [24:0] immediate;
  wire [31:0] imm32;
  //Register File
  reg [4:0] rs1;
  reg [4:0] rs2;
  wire [31:0] data;
  wire [31:0] data1;
  wire [31:0] data2;
  reg [4:0] rd;
  //ALU
  wire [31:0] operand1;
  wire [31:0] operand2;
  wire [31:0] result;
  //Data Memory
  wire [31:0] load_data;
  //Branch
  wire [4:0] BrOp;
  wire NextPCSrc;

    pc pc (
      .clk(clk),
      .reset(reset),
      .pc_in(pc_in),
      .pc_out(pc_out)
    );

    sumador sumador (
      .pc(pc_out),
      .sum_out(sum_out)
    );

    InstructionMemory #(TAM)im (
      .pc(pc_out),
      .instruction(instruction)
    );

    CU cu (
      .opcode(opcode),
      .funct3(funct3),
      .funct7(funct7),
      .Type_alu(Type_alu_dm),
      .Type_dm(Type_dm),
      .salida_funct3(salida_funct3),
      .store(store),
      .controlALU(controlALU),
      .controlRF(controlRF),
      .we(we),
      .funct_imm(funct_imm),
      .BrOp(BrOp),
      .controlOp1(controlOp1)
    );

    IMM imm (
      .immediate(immediate),
      .funct(funct_imm),
      .imm32(imm32)
    );
    
    RegisterFile rf (
      .clk(clk),
      .rst(rst),
      .rs1(rs1),
      .rs2(rs2),
      .WriteEnable(we),
      .data(data),
      .data1(data1),
      .data2(data2),
      .rd(rd)
    );

    mux mux1 (
      .control(controlALU),
      .entrada1(data2),
      .entrada2(imm32),
      .salida(operand2)
    );

    Mux3 mux2(
      .control(controlRF),
      .entrada1(load_data),
      .entrada2(result),
      .entrada3(sum_out),
      .salida(data)
    );

    mux mux4(
      .control(controlOp1),
      .entrada1(data1),
      .entrada2(pc_out),
      .salida(operand1)
    );

    alu alu(
      .operand1(operand1),
      .operand2(operand2),
      .funct3_alu(salida_funct3),
      .Type_alu(Type_alu_dm),
      .result(result)
    );

    data_memory #(TAM)dm (
      .store(store),
      .direccion(data1),
      .store_data(data2),
      .offset(imm32),
      .clk(clk),
      .Type(Type_dm),
      .load_data(load_data)
    );

    BranchUnit branch (
      .RUrs2(data2),
      .RUrs1(data1),
      .BrOp(BrOp),
      .NextPCSrc(NextPCSrc)
    );

    mux mux3(
      .control(NextPCSrc),
      .entrada1(sum_out),
      .entrada2(result),
      .salida(pc_in)
    );
    reg read = 0;
    always @(clk) begin
      if (read == 0) begin
        $readmemb("Binario_Inst.txt", im.mem);
        read = 1;
      end
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];
        rd = instruction[11:7];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        immediate = instruction[31:7];
    end
endmodule