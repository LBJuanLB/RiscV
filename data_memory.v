module data_memory#(
  parameter TAM = 4  // Valor predeterminado de TAM
)(
  input wire store, //Enable de guardado
  input wire [31:0] direccion, //Data1 proveniente del RF valor de rs1
  input wire [31:0] store_data, //Data2 proveniente del RF valor de rs2
  input wire [31:0] offset, //imm proveniente de imm
  input wire clk,
  input wire [2:0] Type,
  output reg [31:0] load_data //Dato solicitado por cargue
);
    reg memory [(TAM*32):0]; 
    wire [31:0] address;
    assign address = (direccion+offset)*32;
    reg [31:0] data;
    reg [31:0] count;
    
    always @(Type or store or direccion or store_data or offset) begin
        if (store == 1'b0) begin
            case (Type)
                3'b000:
                begin
                    for ( count= 0 ;count<8 ;count = count+1 ) begin
                        data[count] =memory[address+count];
                    end
                    load_data= {{24{data[7]}},data[7:0]};
                end
                3'b001:
                begin
                    for ( count= 0 ;count<16 ;count = count+1 ) begin
                        data[count] =memory[address+count];
                    end   
                    load_data= {{16{data[15]}},data[15:0]};
                end
                3'b010:
                begin
                    for ( count= 0 ;count<32 ;count = count+1 ) begin
                        if (memory[address+count] === 1'bx) begin
                            data[count] = 1'b0;
                        end else begin
                            data[count] =memory[address+count];
                        end
                    end
                    load_data= {data[31:0]};
                end
                3'b011:
                begin
                    for ( count= 0 ;count<8 ;count = count+1 ) begin
                        data[count] =memory[address+count];
                    end
                    load_data= {{24{1'b0}},data[7:0]};
                end
                3'b100:
                begin
                    for ( count= 0 ;count<16 ;count = count+1 ) begin
                        data[count] =memory[address+count];
                    end
                    load_data= {{16{1'b0}},data[15:0]};
                end
            endcase
        end
    end
    always@(negedge clk) begin
        if (store == 1'b1) begin
            case (Type)
                3'b000: 
                    for ( count= 0 ;count<8 ;count = count+1 ) begin
                        memory[address+count] <=store_data[count];
                    end
                3'b001:
                    for ( count= 0 ;count<16 ;count = count+1 ) begin
                        memory[address+count] <=store_data[count];
                    end
                3'b010:
                    for ( count= 0 ;count<32 ;count = count+1 ) begin
                        memory[address+count] <=store_data[count];
                    end
            endcase
        end
    end 
endmodule