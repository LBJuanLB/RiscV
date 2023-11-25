module exmem(
    input wire clk,
    input wire [31:0] sum_out_in,
    input wire [31:0] result_in,
    input wire [31:0] imm_in,
    input wire [4:0] rd_in,
    input wire we_in,
    input wire [1:0] controlRF_in,
    input wire [2:0] Type_dm_in,
    input wire [31:0] data1_in,
    input wire [31:0] data2_in,
    input wire store_in,
    output reg [31:0] sum_out_out,
    output reg [31:0] result_out,
    output reg [31:0] imm_out,
    output reg [4:0] rd_out,
    output reg we_out,
    output reg [1:0] controlRF_out,
    output reg [2:0] Type_dm_out,
    output reg [31:0] data1_out,
    output reg [31:0] data2_out,
    output reg store_out
);


always @(posedge clk) begin
    sum_out_out <= sum_out_in;
    result_out <= result_in;
    imm_out <= imm_in;
    rd_out <= rd_in;
    we_out <= we_in;
    controlRF_out <= controlRF_in;
    Type_dm_out <= Type_dm_in;
    data1_out <= data1_in;
    data2_out <= data2_in;
    store_out <= store_in;
end

endmodule