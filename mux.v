module mux(
  input wire control,    
  input wire [31:0] entrada1, // Puede ser el data1
  input wire [31:0] entrada2, // Puede ser el data2           
  output reg [31:0] salida 
);

  always @* begin
    if (control == 1'b0)
      salida = entrada1;
    else if (control == 1'b1)
      salida = entrada2;
    else
      salida = 32'b00000000000000000000000000000000; // Otros casos
  end

endmodule
