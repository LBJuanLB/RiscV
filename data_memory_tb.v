`timescale 1ns/1ns
`include "data_memory.v"

module data_memory_tb;
    reg store; // Enable de guardado
    reg [31:0] direccion; // Data1 proveniente del RF valor de rs1
    reg [31:0] store_data; // Data2 proveniente del RF valor de rs2
    reg [31:0] offset; // imm proveniente de imm
    reg clk;
    reg [2:0] Type;
    wire [31:0] load_data; // Dato solicitado por cargue
    parameter TAM = 4;
    // Instancia del módulo data_memory
    data_memory #(TAM)data_memory_instance (
        .store(store),
        .direccion(direccion),
        .store_data(store_data),
        .offset(offset),
        .clk(clk),
        .Type(Type),
        .load_data(load_data)
    );
    reg [31:0] count;
    // Generación de señales de reloj
    always begin
        #5 clk = ~clk; // Genera un ciclo de reloj cada 10 unidades de tiempo
    end

    initial begin
        $dumpfile("data_memory_tb.vcd");
        $dumpvars(0, data_memory_tb);
        
        // Inicialización de señales
        clk = 1'b0;
        store = 1'b1;
        direccion = 32'b00000000000000000000000000000000;
        offset = 32'b00000000000000000000000000000000;
        store_data = 32'b01000000000000001110000010000001;
        
        Type = 3'b000;
        #10;
        for ( count= 0 ;count<32*TAM ;count = count+1 ) begin
                        $display("memory [%d] = %b",count, data_memory_instance.memory[count]);
                    end
        
        Type = 3'b001;
        #10;
        for ( count= 0 ;count<32*TAM ;count = count+1 ) begin
                        $display("memory [%d] = %b",count, data_memory_instance.memory[count]);
                    end

        Type = 3'b010;  
        #10;
        for ( count= 0 ;count<32*TAM ;count = count+1 ) begin
                        $display("memory [%d] = %b",count, data_memory_instance.memory[count]);
                    end

        direccion = 32'b00000000000000000000000000001100;
        offset = 32'b00000000000000000000000000000000;
        store_data = 32'b01000000000000001110000011111111;
        #10;
        for ( count= 0 ;count<32*TAM ;count = count+1 ) begin
                        $display("memory [%d] = %b",count, data_memory_instance.memory[count]);
                    end

        Type = 3'b000;
        store = 1'b0;
        #10
        Type = 3'b001;
        store = 1'b0;
        #10
        Type = 3'b010;
        store = 1'b0;
        #10
        Type = 3'b011;
        store = 1'b0;
        #10
        Type = 3'b100;
        store = 1'b0;
        #10
        // Finalizar la simulación
        $finish;
    end
endmodule


