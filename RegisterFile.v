module RegisterFile (
  input wire clk,            // Señal de reloj
  input wire rst,            // Para poner los valores de los registros en 0
  input wire [4:0] rs1,      // Número de registro rs1
  input wire [4:0] rs2,      // Número de registro rs2
  input wire WriteEnable,    // Habilitación de escritura
  input wire [31:0] data,    // Datos de escritura
  output reg [31:0] data1,   // Contenido de rs1
  output reg [31:0] data2,   // Contenido de rs2
  input wire [4:0] rd      // Número de registro destino
);

  reg [31:0] registers [31:0]; // Registro de 32 bits
  reg [31:0] i;                // Contador
// Escritura en registros
  always@(rst) begin
    if (rst == 1) begin
      registers[0] <= 32'b0; registers[1] <= 32'b0;registers[2] <= 32'b00000000000000000000000111110100;registers[3] <= 32'b00010000000000000000000000000000;registers[4] <= 32'b0;registers[5] <= 32'b0;registers[6] <= 32'b0;registers[7] <= 32'b0;registers[8] <= 32'b0;registers[9] <= 32'b0;
      registers[10] <= 32'b0;registers[11] <= 32'b0;registers[12] <= 32'b0;registers[13] <= 32'b0;registers[14] <= 32'b0;registers[15] <= 32'b0;registers[16] <= 32'b0;registers[17] <= 32'b0;registers[18] <= 32'b0;registers[19] <= 32'b0;
      registers[20] <= 32'b0;registers[21] <= 32'b0;registers[22] <= 32'b0;registers[23] <= 32'b0;registers[24] <= 32'b0;registers[25] <= 32'b0;registers[26] <= 32'b0;registers[27] <= 32'b0;registers[28] <= 32'b0;registers[29] <= 32'b0;
      registers[30] <= 32'b0;registers[31] <= 32'b0;
    end
  end
  always @(posedge clk) begin
    if ((rs1 == 5'b00000) && (rs2 == 5'b00000) && (rd == 5'b00000)) begin
      $display("Registros:");
      for (i = 0; i < 32; i = i + 1) begin
        $display("Registro[%0d]: %b", i, registers[i]);
      end
    end
    data1 <= registers[rs1];
    data2 <= registers[rs2];
  end

  always @(negedge clk) begin
    if(WriteEnable == 1) begin
      if (rd != 0) begin
        registers[rd] <= data;
      end
    end
  end

endmodule
