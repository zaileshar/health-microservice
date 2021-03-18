module core #(parameter WIDTH=8) (
    input clk,
    input rst_n,
    input [WIDTH-1:0] din,
    input valid_in,
    output reg [WIDTH-1:0] dout,
    output reg valid_out
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dout <= 0;
            valid_out <= 0;
        end else begin
            if (valid_in)
                dout <= din + 1'b1;
            valid_out <= valid_in;
        end
    end
endmodule