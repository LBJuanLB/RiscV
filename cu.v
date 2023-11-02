module CU(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg Type_alu,
    output reg [2:0]Type_dm,
    output reg [2:0]salida_funct3,
    output reg store,
    output reg controlALU,
    output reg controlOp1,
    output reg [1:0]controlRF,
    output reg we,
    output reg [2:0] funct_imm,
    output reg [4:0] BrOp
);

always @(*) begin
    case (opcode)
        //Tipo R
        7'b0110011: begin
            store = 1'b0;
            BrOp = 5'b00000;
            controlALU = 1'b0;
            controlOp1 = 1'b0;
            we = 1'b1;
            controlRF = 2'b01;
            case (funct3)
                3'b000: begin
                            salida_funct3 = 3'b000;
                            if(funct7 == 7'b0000000) begin 
                                Type_alu = 1'b0; //add 
                            end else if(funct7 == 7'b0100000) begin
                                Type_alu = 1'b1; //sub
                            end
                        end

                3'b001: begin
                            salida_funct3 = 3'b001;
                            Type_alu = 1'b0; //sll
                        end

                3'b010: begin
                            salida_funct3 = 3'b010;
                            Type_alu = 1'b0; //slt
                        end
                3'b011: begin
                            salida_funct3 = 3'b010;
                            Type_alu = 1'b1; //sltu
                        end
                3'b100: begin
                            salida_funct3 = 3'b100;
                            Type_alu = 1'b0; //xor
                        end
                3'b101: begin
                            salida_funct3 = 3'b101;
                            if(funct7 == 7'b0000000) begin 
                                Type_alu = 1'b0; //srl
                            end else if(funct7 == 7'b0100000) begin
                                salida_funct3 = 3'b001;
                                Type_alu = 1'b1; //sra
                            end
                        end
                3'b110: begin
                            salida_funct3 = 3'b110;
                            Type_alu = 1'b0; //or
                        end
                3'b111: begin
                            salida_funct3 = 3'b111;
                            Type_alu = 1'b0; //and
                        end
            endcase
        end
        //Tipo I
        7'b0010011: begin
            store = 1'b0;
            BrOp = 5'b00000;
            controlALU = 1'b1;
            controlOp1 = 1'b0;
            we = 1'b1;
            controlRF = 2'b01;
            funct_imm = 3'b000;
            case (funct3)
                3'b000: begin
                            salida_funct3 = 3'b000;
                            Type_alu = 1'b0; //addi
                        end
                3'b001: begin
                            salida_funct3 = 3'b001;
                            Type_alu = 1'b0; //slli
                        end
                3'b010: begin
                            salida_funct3 = 3'b010;
                            Type_alu = 1'b0; //slti
                        end
                3'b011: begin
                            salida_funct3 = 3'b010;
                            Type_alu = 1'b1; //sltiu
                        end
                3'b100: begin
                            salida_funct3 = 3'b100;
                            Type_alu = 1'b0; //xori
                        end
                3'b101: begin
                            salida_funct3 = 3'b101;
                            if(funct7 == 7'b0000000) begin 
                                Type_alu = 1'b0; //srli
                            end else if(funct7 == 7'b0100000) begin
                                salida_funct3 = 3'b010;
                                Type_alu = 1'b1; //srai
                            end
                        end
                3'b110: begin
                            salida_funct3 = 3'b110;
                            Type_alu = 1'b0; //ori
                        end
                3'b111: begin
                            salida_funct3 = 3'b111;
                            Type_alu = 1'b0; //andi
                        end
            endcase
        end
        //Tipo I de cargue/guardado
        7'b0000011: begin
            BrOp = 5'b00000;
            store = 1'b0;
            we = 1'b1;
            controlRF = 2'b00;
            funct_imm = 3'b000;
            case (funct3)
                3'b000: begin
                            Type_dm = 3'b000;
                             //lb
                        end
                3'b001: begin
                            Type_dm = 3'b001;
                             //lh
                        end
                3'b010: begin
                            Type_dm = 3'b010;
                             //lw
                        end
                3'b100: begin
                            Type_dm = 3'b011;
                             //lbu
                        end
                3'b101: begin
                            Type_dm = 3'b100;
                             //lhu
                        end
            endcase
        end
        //Tipo S
        7'b0100011: begin
            BrOp = 5'b00000;
            store = 1'b1;
            we = 1'b0;
            funct_imm = 3'b001;
            Type_dm = funct3;
        end
        //Tipo B
        7'b1100011: begin
            store = 1'b0;
            BrOp = 5'b00000;
            we = 1'b0;
            controlALU  = 1'b1;
            controlOp1 = 1'b1;
            funct_imm = 3'b010;
            case (funct3)
                3'b000: begin
                            BrOp = 5'b01000; //beq
                        end
                3'b001: begin
                            BrOp = 5'b01001; //bne
                        end
                3'b100: begin
                            BrOp = 5'b01100; //blt
                        end
                3'b101: begin
                            BrOp = 5'b01101; //bge
                        end
                3'b110: begin
                            BrOp = 5'b01110; //bltu
                        end
                3'b111: begin
                            BrOp = 5'b01111; //bgeu
                        end 
            endcase
        end
        //Tipo U - lui
        7'b0110111: begin
            store = 1'b0;
            
            BrOp = 5'b00000;
            we = 1'b1;
            salida_funct3 = 3'b100;
            controlALU = 1'b1;
        end
        //Tipo U - auipc
        7'b0010111: begin
            store = 1'b0;
            BrOp = 5'b00000;
            we = 1'b0;
            funct_imm = 3'b011; 
        end
        //Tipo I - jalr
        7'b1100111: begin
            store = 1'b0;
            controlALU = 1'b1;
            we = 1'b1;
            controlRF = 2'b11;
            funct_imm = 3'b000;
            controlOp1 = 1'b0;
            BrOp = 5'b11111; //jalr
        end
        //Tipo J - jal
        7'b1101111: begin
            store = 1'b0;
            controlALU = 1'b1;
            we = 1'b1;
            controlRF = 2'b11;
            funct_imm = 3'b100;
            controlOp1 = 1'b1;
            BrOp = 5'b11111; //jal
        end
        //Tipo I - ecall y ebreak
        7'b1101111: begin
            store = 1'b0;
            BrOp = 5'b00000;
            funct_imm = 3'b000;
        end
    endcase
end
endmodule