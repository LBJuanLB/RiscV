`timescale 1ns/1ns
`include "CPU.v"

module CPU_TB;
    reg reset;
    reg rst;
    reg clk;

    CPU cpu (
        .reset(reset),
        .rst(rst),
        .clk(clk)
    );

    always begin
    #5;  // Espera 5 unidades de tiempo
    clk <= ~clk;  // Invierte el estado del reloj
    end

    initial begin
    $dumpfile("CPU_TB.vcd"); $dumpvars(0, CPU_TB);
    clk=1;
    rst = 1;
    #10;
    rst = 0;
    reset = 1;
    #10;
    reset = 0;
    #100000;

    $finish;
    end
endmodule