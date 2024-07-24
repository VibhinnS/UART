module uart_rx (
    input wire clk,           // System clock
    input wire rst_n,         // Active low reset
    input wire rx,            // UART receive input
    output reg [7:0] rx_data, // Received data
    output reg rx_ready       // Data ready flag
);

    parameter CLK_FREQ = 50000000; // System clock frequency
    parameter BAUD_RATE = 9600;    // UART baud rate
    localparam BAUD_COUNT = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_counter;
    reg [3:0] bit_counter;
    reg [9:0] shift_reg;
    reg rx_sample;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_data <= 0;
            rx_ready <= 0;
            baud_counter <= 0;
            bit_counter <= 0;
            shift_reg <= 0;
            rx_sample <= 1'b1;
        end else begin
            rx_sample <= rx;

            if (!rx_sample && !rx_ready && bit_counter == 0) begin
                baud_counter <= BAUD_COUNT / 2; // Start bit detected
            end

            if (baud_counter == BAUD_COUNT - 1) begin
                baud_counter <= 0;

                if (bit_counter > 0) begin
                    shift_reg <= {rx_sample, shift_reg[9:1]};
                    bit_counter <= bit_counter + 1;

                    if (bit_counter == 10) begin
                        rx_data <= shift_reg[8:1]; // Data bits
                        rx_ready <= 1'b1;
                        bit_counter <= 0;
                    end
                end else begin
                    bit_counter <= bit_counter + 1; // Count start bit
                end
            end else if (bit_counter > 0) begin
                baud_counter <= baud_counter + 1;
            end
        end
    end
endmodule
