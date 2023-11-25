module memwb(
    input wire clk,
    input wire [31:0] loadData_in,
    input wire [31:0] sum_out_in,
    input wire [31:0] result_in,
    input wire [1:0] controlRF_in,
    input wire we_in,
    input wire [4:0] rd_in,
    output reg [31:0] loadData_out,
    output reg [31:0] sum_out_out,
    output reg [31:0] result_out,
    output reg [1:0] controlRF_out,
    output reg we_out,
    output reg [4:0] rd_out
);

always @(posedge clk) begin
    loadData_out <= loadData_in;
    sum_out_out <= sum_out_in;
    result_out <= result_in;
    controlRF_out <= controlRF_in;
    we_out <= we_in;
    rd_out <= rd_in;
end

endmodule