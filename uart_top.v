module uart_top (
    input wire clk,
    input wire rst_n,
    input wire rx,
    input wire tx_start,
    input wire [7:0] tx_data,
    output wire tx,
    output wire [7:0] rx_data,
    output wire rx_ready,
    output wire tx_busy
);

    uart_tx uart_tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    uart_rx uart_rx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

endmodule
