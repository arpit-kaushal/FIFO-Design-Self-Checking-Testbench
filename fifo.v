`timescale 1ns / 1ps

module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout,
    output full,
    output empty,
    output reg overflow
);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

reg [$clog2(DEPTH):0] wr_ptr;
reg [$clog2(DEPTH):0] rd_ptr;
reg [$clog2(DEPTH)+1:0] count;

assign full  = (count == DEPTH);
assign empty = (count == 0);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count  <= 0;
        dout   <= 0;
        overflow <= 0;
    end else begin

        overflow <= 0;

        // Write Operation
        if(wr_en) begin
            if(!full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end else begin
                overflow <= 1;
            end
        end

        // Read Operation
        if(rd_en) begin
            if(!empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
        end

    end
end

endmodule
