module uart_tx (
    input wire clk,           // System clock
    input wire rst_n,         // Active low reset
    input wire tx_start,      // Start transmission signal
    input wire [7:0] tx_data, // Data to transmit
    output reg tx,            // UART transmit output
    output reg tx_busy        // Transmit busy flag
);

    parameter CLK_FREQ = 50000000; // System clock frequency
    parameter BAUD_RATE = 9600;    // UART baud rate
    localparam BAUD_COUNT = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_counter;
    reg [3:0] bit_counter;
    reg [9:0] shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx <= 1'b1;
            tx_busy <= 1'b0;
            baud_counter <= 0;
            bit_counter <= 0;
            shift_reg <= 0;
        end else begin
            if (tx_start && !tx_busy) begin
                tx_busy <= 1'b1;
                shift_reg <= {1'b1, tx_data, 1'b0}; // Start bit, data, stop bit
            end

            if (tx_busy) begin
                if (baud_counter == BAUD_COUNT - 1) begin
                    baud_counter <= 0;
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_counter <= bit_counter + 1;
                    
                    if (bit_counter == 10) begin
                        tx_busy <= 1'b0;
                        bit_counter <= 0;
                    end
                end else begin
                    baud_counter <= baud_counter + 1;
                end
            end
        end
    end
endmodule
