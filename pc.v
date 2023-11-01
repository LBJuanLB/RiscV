module pc(
    input wire clk,
    input wire reset, //reset = 0
    input wire [31:0] pc_in, //pc_in = pc_out + 4
    output reg [31:0] pc_out //pc_out = pc_in
);

    always @(negedge clk) begin
        if (reset) begin
            pc_out <= 0;
        end else begin
            pc_out <= pc_in;
        end
    end


endmodule