// Code your design here

module BranchUnit(
  input [31:0] RUrs2,
  input [31:0] RUrs1,
  input [4:0] BrOp,
  output reg NextPCSrc
);
  
  always@(*) begin
    case(BrOp)
      5'b01000:
        //RUrs2 == RUrs1
        if (RUrs2 == RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b01001:
        //RUrs2 != RUrs1
        if (RUrs2 != RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b01100:
        //RUrs2 < RUrs1
        if (RUrs2 < RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b01101:
        //RUrs2 >= RUrs1
        if (RUrs2 >= RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b01110:
        //RUrs2 < RUrs1 (U)
        if (RUrs2 < RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b01111: 
        //RUrs2 >= RUrs1 (U)
        if (RUrs2 >= RUrs1)begin
          NextPCSrc = 1;
        end else begin
          NextPCSrc = 0;
        end
      
      5'b11111:
        NextPCSrc = 1;
      
      5'b00000:
        NextPCSrc = 0;
    endcase
  end
endmodule