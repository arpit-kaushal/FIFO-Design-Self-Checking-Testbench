`timescale 1ns / 1ps

module tb_fifo;

parameter DATA_WIDTH = 8;
parameter DEPTH = 8;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] din;
wire [DATA_WIDTH-1:0] dout;
wire full;
wire empty;
wire overflow;

// Expected Queue
reg [DATA_WIDTH-1:0] expected_mem [0:DEPTH-1];
integer write_count = 0;
integer read_count  = 0;
integer errors = 0;

fifo #(DATA_WIDTH, DEPTH) DUT (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty),
    .overflow(overflow)
);

// Clock generation
always #5 clk = ~clk;

// Write Task
task write_data(input [7:0] data);
begin
    @(posedge clk);
    wr_en = 1;
    rd_en = 0;
    din = data;

    expected_mem[write_count] = data;
    write_count = write_count + 1;

    @(posedge clk);
    wr_en = 0;
end
endtask

// Read Task
task read_data;
begin
    @(posedge clk);
    wr_en = 0;
    rd_en = 1;

    @(posedge clk);

    if(dout !== expected_mem[read_count]) begin
        $display("❌ ERROR: Expected = %0d, Got = %0d",
                 expected_mem[read_count], dout);
        errors = errors + 1;
    end else begin
        $display("✅ PASS: Read %0d correct", dout);
    end

    read_count = read_count + 1;
    rd_en = 0;
end
endtask

initial begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;

    #20 rst = 0;

    $display("========== FIFO TEST START ==========");

    // Write Full FIFO
    repeat(DEPTH)
        write_data($random);

    // Check Full condition
    if(full)
        $display("✅ FIFO FULL detected correctly");
    else begin
        $display("❌ FIFO FULL NOT detected");
        errors = errors + 1;
    end

    // Overflow Test
    write_data(8'hAA);
    if(overflow)
        $display("✅ Overflow detected correctly");
    else begin
        $display("❌ Overflow NOT detected");
        errors = errors + 1;
    end

    // Read all data
    repeat(DEPTH)
        read_data();

    if(empty)
        $display("✅ FIFO EMPTY detected correctly");
    else begin
        $display("❌ FIFO EMPTY NOT detected");
        errors = errors + 1;
    end

    if(errors == 0)
        $display("🎉 ALL TESTS PASSED!");
    else
        $display("❌ TEST FAILED with %0d errors", errors);

    $finish;
end

endmodule
