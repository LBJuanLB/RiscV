module Mux3(
    input wire [31: 0] entrada1, // Puede ser el data1
    input wire [31: 0] entrada2, // Puede ser el data2
    input wire [31: 0] entrada3,    
    input wire [1:0] control,  // Señal de selección (2 bits)
    output wire [31:0] salida  // Salida del MUX
);

assign salida = (control == 2'b00) ? entrada1 :
             (control == 2'b01) ? entrada2 : entrada3; // Salida alta impedancia en caso de que sel sea 2'b11

endmodule