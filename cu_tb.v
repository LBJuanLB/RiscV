`include "CU.v"
`timescale 1ns/1ns

module CU_TB;
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire Type_alu;
    wire [2:0]Type_dm;
    wire salida_funct3;
    wire store;
    wire controlALU;
    wire controlRF;
    wire we;
    wire [2:0] funct_imm;

    CU cu (
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

    initial begin
        $dumpfile("cu_tb.vcd"); $dumpvars(0, CU_TB);
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
    end
endmodule