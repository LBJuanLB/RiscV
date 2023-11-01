module sumador (
    input [31:0] pc,  // Entrada de 32 bits
    output reg [31:0] sum_out  // Salida de 32 bits
);


always @* begin
sum_out = 32'b00000000000000000000000000000100 + pc;  // Suma de una constante 4 y B
end
endmodule

