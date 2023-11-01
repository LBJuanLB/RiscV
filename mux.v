module mux(
  input wire control,    
  input wire [31: 0] entrada1, // Puede ser el data1
  input wire [31: 0] entrada2, // Puede ser el data2           
  output wire [31:0] salida 
);

  assign salida = (control == 1'b0) ? entrada1: entrada2;

endmodule