`timescale 1ns / 1ns
`include "pc.v"

module pc_TB;
    reg clk;
    reg reset; //reset = 0
    reg pc_write; //pc_write = 1
    reg [31:0] pc_in; //pc_out = pc_in
    wire [31:0] pc_out; //pc_out = pc_out + 4

    pc pc (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always begin
        #5;  // Espera 5 unidades de tiempo
        clk <= ~clk;  // Invierte el estado del reloj
    end

    initial begin
        $dumpfile("pc_tb.vcd"); $dumpvars(0, pc_TB);
        clk = 0;
        reset = 1;
        #10;
        reset = 0;
        pc_write = 0;
        #50;
        pc_in = 8;
        pc_write = 1;
        #10;
        $finish;
    end
endmodule