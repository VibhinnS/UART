# UART Communication Module in Verilog

## Overview

We made a UART (Universal Asynchronous Receiver/Transmitter) communication module in Verilog. The module includes both a UART transmitter and a UART receiver, designed to facilitate reliable serial communication at a baud rate of 9600 with 8-bit data frames.
## Features

- **UART Transmitter**: Implements data transmission with start, data, and stop bits.
- **UART Receiver**: Implements data reception with start, data, and stop bits.
- **Finite State Machine (FSM)**: Ensures precise timing control and data integrity.
- **Simulation and FPGA Deployment**: Verified functionality using a 50 MHz clock.

## File Structure

- `transmitter/uart_tx.v`: UART transmitter module.
- `receiver/uart_rx.v`: UART receiver module.
- `uart_top.v`: Top-level module integrating both transmitter and receiver. In the root of the directory itself
- `test/uart_tb.v`: Testbench for simulating the UART modules.

## UART Transmitter (`uart_tx.v`)

The UART transmitter sends 8-bit data over a serial line with a specified baud rate. It includes start and stop bits to frame the data.

### Params - 

- `CLK_FREQ`: System clock frequency (default: 50 MHz).
- `BAUD_RATE`: UART baud rate (default: 9600).

### Ports

- `clk`: System clock input.
- `rst_n`: Active low reset input.
- `tx_start`: Signal to start transmission.
- `tx_data`: 8-bit data to transmit.
- `tx`: UART transmit output.
- `tx_busy`: Transmit busy flag.

## UART Receiver (`uart_rx.v`)

The UART receiver receives 8-bit data over a serial line with a specified baud rate. It detects start and stop bits to frame the data.

### Params - 

- `CLK_FREQ`: System clock frequency (default: 50 MHz).
- `BAUD_RATE`: UART baud rate (default: 9600).

### Ports

- `clk`: System clock input.
- `rst_n`: Active low reset input.
- `rx`: UART receive input.
- `rx_data`: 8-bit received data.
- `rx_ready`: Data ready flag.

## Top Module (`uart_top.v`)

The top module integrates both the UART transmitter and receiver. It connects the transmitter output to the receiver input for loopback testing.

### Ports

- `clk`: System clock input.
- `rst_n`: Active low reset input.
- `rx`: UART receive input (connected to `tx` for loopback).
- `tx_start`: Signal to start transmission.
- `tx_data`: 8-bit data to transmit.
- `tx`: UART transmit output.
- `rx_data`: 8-bit received data.
- `rx_ready`: Data ready flag.
- `tx_busy`: Transmit busy flag.

## Testbench (`uart_tb.v`)

The testbench simulates the UART modules to verify functionality. It initializes the system, sends a byte of data, and checks the received data.

### Simulation Commands

I have used EDA Playground online compiler for this. Please refer to the website for running the code :) Ran the testbench code to verify the functionality of the code. 
