`timescale 1ns/1ns
`include "IMM.v"

module IMM_tb;
    reg [24:0] immediate;
    reg [2:0] funct;
    wire [31:0] imm32;

    IMM imm_instance(
        .immediate(immediate),
        .funct(funct),
        .imm32(imm32)
    );

    initial begin
        $dumpfile("IMM_tb.vcd");
        $dumpvars(0,IMM_tb);

        immediate =25'b0111111111110001000000001;
        funct = 3'b000; //Tipo I
        #10;
        immediate=25'b1000000000000001000000001;
        funct = 3'b000; //Tipo I
        #10;
        immediate =25'b0000011000010001000000100;
        funct = 3'b001; //Tipo S
        #10;
        immediate =25'b0000000001100010100011110;
        funct = 3'b010; //Tipo B
        #10;
        immediate=25'b0000000111100000000001001;
        funct = 3'b100; //Tipo J
        #10;
        $finish;
    end
    
endmodule