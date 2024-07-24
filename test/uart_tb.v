module uart_tb;

    reg clk;
    reg rst_n;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire [7:0] rx_data;
    wire rx_ready;
    wire tx_busy;

    uart_top uut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(tx),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .tx_busy(tx_busy)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    initial begin
        rst_n = 0;
        tx_start = 0;
        tx_data = 8'b10101010;
        #100;
        rst_n = 1;
        #100;
        tx_start = 1;
        #20;
        tx_start = 0;
        #200000;
        $stop;
    end

endmodule
