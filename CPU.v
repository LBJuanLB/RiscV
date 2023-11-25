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
`include "IFID.v"
`include "IDEX.v"
`include "EXMEM.v"
`include "MEMWB.v"

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


  //IFID
  wire [31:0] instruction_ifid;
  wire [31:0] pc_out_ifid;
  wire [31:0] sum_out_ifid;
  //IDEX
  wire [31:0] data1_idex;
  wire [31:0] data2_idex;
  wire [31:0] imm_idex;
  wire [4:0] rd_idex;
  wire we_idex;
  wire [1:0] controlRF_idex;
  wire [2:0] Type_dm_idex;
  wire [31:0] sum_out_idex;
  wire store_idex;
  wire controlOp1_idex;
  wire [4:0] BrOp_idex;
  wire controlALU_idex;
  wire [31:0] pc_out_idex;
  wire Type_alu_dm_idex;
  wire [2:0] salida_funct3_idex;
  //EXMEM
  wire [31:0] sum_out_exmem;
  wire [31:0] result_exmem;
  wire [4:0] rd_exmem;
  wire we_exmem;
  wire [1:0] controlRF_exmem;
  wire [31:0] imm_exmem;
  wire [2:0] Type_dm_exmem;
  wire [31:0] data1_exmem;
  wire [31:0] data2_exmem;
  wire store_exmem;
  //MEMWB
  wire [31:0] sum_out_memwb;
  wire [31:0] result_memwb;
  wire [4:0] rd_memwb;
  wire we_memwb;
  wire [1:0] controlRF_memwb;
  wire [31:0] loadData_memwb;


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
      .WriteEnable(we_memwb),
      .data(data),
      .data1(data1),
      .data2(data2),
      .rd(rd)
    );

    mux mux1 (
      .control(controlALU_idex),
      .entrada1(data2_idex),
      .entrada2(imm_idex),
      .salida(operand2)
    );

    Mux3 mux2(
      .control(controlRF_memwb),
      .entrada1(loadData_memwb),
      .entrada2(result_memwb),
      .entrada3(sum_out_memwb),
      .salida(data)
    );

    mux mux4(
      .control(controlOp1_idex),
      .entrada1(data1_idex),
      .entrada2(pc_out_idex),
      .salida(operand1)
    );

    alu alu(
      .operand1(operand1),
      .operand2(operand2),
      .funct3_alu(salida_funct3_idex),
      .Type_alu(Type_alu_dm_idex),
      .result(result)
    );

    data_memory #(TAM)dm (
      .store(store_exmem),
      .direccion(data1_exmem),
      .store_data(data2_exmem),
      .offset(imm_exmem),
      .clk(clk),
      .Type(Type_dm_exmem),
      .load_data(load_data)
    );

    BranchUnit branch (
      .RUrs2(data2_idex),
      .RUrs1(data1_idex),
      .BrOp(BrOp_idex),
      .NextPCSrc(NextPCSrc)
    );

    mux mux3(
      .control(NextPCSrc),
      .entrada1(sum_out),
      .entrada2(result_exmem),
      .salida(pc_in)
    );


    ifid ifid (
      .clk(clk),
      .instruction_in(instruction),
      .pc_out_in(pc_out),
      .sum_out_in(sum_out),
      .instruction_out(instruction_ifid),
      .pc_out_out(pc_out_ifid),
      .sum_out_out(sum_out_ifid)
    );

    idex idex (
      .clk(clk),
      .sum_out_in(sum_out_ifid),
      .pc_out_in(pc_out_ifid),
      .data1_in(data1),
      .data2_in(data2),
      .imm_in(imm32),
      .rd_in(rd),
      .we_in(we),
      .controlRF_in(controlRF),
      .controlALU_in(controlALU),
      .store_in(store),
      .funct3_alu_in(salida_funct3),
      .Type_alu_in(Type_alu_dm),
      .Type_dm_in(Type_dm),
      .BrOp_in(BrOp),
      .controlOp1_in(controlOp1),
      .sum_out_out(sum_out_idex),
      .pc_out_out(pc_out_idex),
      .data1_out(data1_idex),
      .data2_out(data2_idex),
      .imm_out(imm_idex),
      .rd_out(rd_idex),
      .we_out(we_idex),
      .controlRF_out(controlRF_idex),
      .controlALU_out(controlALU_idex),
      .store_out(store_idex),
      .funct3_alu_out(salida_funct3_idex),
      .Type_alu_out(Type_alu_dm_idex),
      .Type_dm_out(Type_dm_idex),
      .BrOp_out(BrOp_idex),
      .controlOp1_out(controlOp1_idex)
    );
    

    exmem exmem (
      .clk(clk),
      .sum_out_in(sum_out_idex),
      .result_in(result),
      .imm_in(imm_idex),
      .rd_in(rd_idex),
      .we_in(we_idex),
      .controlRF_in(controlRF_idex),
      .Type_dm_in(Type_dm_idex),
      .data1_in(data1_idex),
      .data2_in(data2_idex),
      .store_in(store_idex),
      .sum_out_out(sum_out_exmem),
      .result_out(result_exmem),
      .imm_out(imm_exmem),
      .rd_out(rd_exmem),
      .we_out(we_exmem),
      .controlRF_out(controlRF_exmem),
      .Type_dm_out(Type_dm_exmem),
      .data1_out(data1_exmem),
      .data2_out(data2_exmem),
      .store_out(store_exmem)
    );


    memwb memwb (
      .clk(clk),
      .loadData_in(load_data),
      .sum_out_in(sum_out_exmem),
      .result_in(result_exmem),
      .controlRF_in(controlRF_exmem),
      .we_in(we_exmem),
      .rd_in(rd_exmem),
      .loadData_out(loadData_memwb),
      .sum_out_out(sum_out_memwb),
      .result_out(result_memwb),
      .controlRF_out(controlRF_memwb),
      .we_out(we_memwb),
      .rd_out(rd_memwb)
    );


    reg read = 0;
    always @(clk) begin
      if (read == 0) begin
        $readmemb("Binario_Inst.txt", im.mem);
        read = 1;
      end
        opcode = instruction_ifid[6:0];
        funct3 = instruction_ifid[14:12];
        funct7 = instruction_ifid[31:25];
        rd = instruction_ifid[11:7];
        rs1 = instruction_ifid[19:15];
        rs2 = instruction_ifid[24:20];
        immediate = instruction_ifid[31:7];
    end
    
endmodule