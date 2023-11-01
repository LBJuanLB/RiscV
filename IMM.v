module IMM (
    input [24:0] immediate,
    input [2:0] funct,
    output reg [31:0] imm32
);
    always @(*) begin
        case (funct)
            //Tipo I
            3'b000: 
                assign imm32 = {{20{immediate[24]}}, immediate[24:13]};
            //Tipo S
            3'b001:
                assign imm32= {{20{immediate[24]}},immediate[24:18],immediate[4:0]};
            //Tipo B
            3'b010:
                assign imm32= {{20{immediate[24]}},immediate[24],immediate[0],immediate[23:18],immediate[4:1]};
            //TIpo U
            3'b011:
                assign imm32 = {{12{immediate[24]}}, immediate[24:5]};
            //Tipo J
            3'b100:
                assign imm32 = {{12{immediate[24]}}, immediate[24],immediate[12:5],immediate[13],immediate[23:14]};
        endcase
    end
    
endmodule