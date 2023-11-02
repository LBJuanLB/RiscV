//Integrantes: -Luis Sebastian Conde Toro
//             -Juan Jose Espinosa Mendez
//Asignatura: Arquitectura de computadores
//Periodo: 2023-2
//Profesor: Gustavo Adolfo Gutierrez Sabogal


module alu(
    input clk,
    input [31:0] operand1,
    input [31:0] operand2,
    input [2:0] funct3_alu,
    input Type_alu,
    output reg [31:0] result
);

reg bit_significativo;
reg [31:0] conteo;

    always @(*)
    begin 
        case (funct3_alu)
            3'b000: 
                if (Type_alu)
                    result = operand1 - operand2; //SUB
                else
                    result = operand1 + operand2; //ADD
            3'b100:
                if (Type_alu)
                    result = operand1 ^ operand2;    //XOR
                else
                    result = operand2 + 32'b0; //LUI   
            3'b110:
                if(Type_alu)
                    result = operand1 | operand2;    //OR
            3'b111:
                result = operand1 & operand2;    //AND
            3'b010:
                if (Type_alu)
                    result = (operand1 < operand2) && ~(operand2[31]) && ~(operand2[31] & ~operand1[31]) && ~(operand2[31] & operand1[31]);  //SLT(U) - Operand1 < Operand2
                else
                    result = (operand1 < operand2); //SLT - Operand1 < Operand2 
            3'b001:
                if(Type_alu)
                    begin
                    bit_significativo = operand1[31];
                    result = {operand1>>operand2};
                    
                    for (conteo=0; conteo<operand2;conteo=conteo+1 ) begin
                        result[31-conteo]=bit_significativo;
                    end //SRA
                    end
                else
                    result = (operand1 << operand2); //SLL
            3'b101:
                if (Type_alu)
                  result = (operand1 >= operand2); //BGE - Operand1 >= Operand2
                else
                  result = (operand1 >> operand2); //SRL
            3'b011:
                if (Type_alu)
                    result = operand1 * operand2; //MUL
                else
                    result = operand1 / operand2; //DIV
        endcase
    end
endmodule