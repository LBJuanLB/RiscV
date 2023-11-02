module mux(
  input wire control,    
  input wire [31: 0] entrada1, // Puede ser el data1
  input wire [31: 0] entrada2, // Puede ser el data2           
  output wire [31:0] salida 
);

  assign salida = (control == 1'b0) ? entrada1 :
             (control == 1'b1) ? entrada2 : 32'b0; // Salida alta impedancia en caso de que sel sea 2'b11

endmodule