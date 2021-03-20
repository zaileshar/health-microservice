module reg_file #(parameter DATA_W=32, ADDR_W=16) (
    input clk,
    input rst_n,
    input [ADDR_W-1:0] wr_addr,
    input [DATA_W-1:0] wr_data,
    input wr_en,
    input [ADDR_W-1:0] rd_addr,
    output reg [DATA_W-1:0] rd_data,
    output reg ready
);
    reg [DATA_W-1:0] memory [0:(1<<ADDR_W)-1];
    reg [2:0] state;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ready <= 1'b0;
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    ready <= 1'b1;
                    if (wr_en) begin
                        memory[wr_addr] <= wr_data;
                        state <= 3'b001;
                    end
                end
                3'b001: begin
                    ready <= 1'b0;
                    rd_data <= memory[rd_addr];
                    state <= 3'b000;
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule