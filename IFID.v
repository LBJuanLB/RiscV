module ifid(
    input wire clk,
    input wire [31:0] instruction_in,
    input wire [31:0] pc_out_in,
    input wire [31:0] sum_out_in,
    output reg [31:0] instruction_out,
    output reg [31:0] pc_out_out,
    output reg [31:0] sum_out_out
);

    always @ (posedge clk) begin
        instruction_out <= instruction_in;
        pc_out_out <= pc_out_in;
        sum_out_out <= sum_out_in;
    end

endmodule