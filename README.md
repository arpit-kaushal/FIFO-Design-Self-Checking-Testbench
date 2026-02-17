# 📦 FIFO Design with Self-Checking Testbench

## 🧠 Project Overview

This project implements a **parameterized synchronous FIFO (First-In
First-Out)** in Verilog HDL with a fully automated **self-checking
testbench**.
The design is verified using **Xilinx Vivado (XSIM)** behavioral
simulation and does not require FPGA hardware.

------------------------------------------------------------------------

## 🎯 Features

-   Parameterized Data Width
-   Parameterized FIFO Depth
-   FULL Detection
-   EMPTY Detection
-   OVERFLOW Detection
-   Self-Checking Testbench
-   Automatic PASS/FAIL Console Reporting

------------------------------------------------------------------------

## 🏗 Architecture

The FIFO consists of:

-   Memory Array
-   Write Pointer (`wr_ptr`)
-   Read Pointer (`rd_ptr`)
-   Counter (`count`)

------------------------------------------------------------------------

## ⚙ Parameters

  Parameter    Description      Default
  ------------ ---------------- ---------
  DATA_WIDTH   Data bus width   8
  DEPTH        FIFO depth       8

------------------------------------------------------------------------

## 📌 FIFO Conditions

### FULL

Triggered when `count == DEPTH`

### EMPTY

Triggered when `count == 0`

### OVERFLOW

Triggered when write enable is asserted while FIFO is FULL

------------------------------------------------------------------------

## 🧪 Self-Checking Testbench Flow

1.  Reset FIFO
2.  Fill FIFO completely
3.  Verify FULL condition
4.  Attempt extra write → Verify OVERFLOW
5.  Read all entries
6.  Compare output with expected values
7.  Verify EMPTY condition
8.  Print PASS/FAIL automatically

------------------------------------------------------------------------

## ▶ Running in Vivado

1.  Open Xilinx Vivado\
2.  Create New RTL Project\
3.  Add:
    -   `fifo.v`
    -   `tb_fifo.v`
4.  Set `tb_fifo` as Simulation Top
5.  Run Behavioral Simulation

------------------------------------------------------------------------

## 🏭 Industrial Applications

FIFO modules are widely used in:

-   UART Communication Buffers
-   Network Packet Buffers
-   DMA Controllers
-   Processor Pipelines
-   Clock Domain Crossing (Asynchronous FIFO)
-   Audio/Video Streaming Hardware
-   FPGA & ASIC Designs
-   SoC Architectures

------------------------------------------------------------------------

## 📈 Learning Outcomes

This project demonstrates:

-   Digital Memory Design
-   Pointer-Based Control Logic
-   Flag Management
-   Hardware Verification Methodology
-   Industry-Relevant RTL Coding

------------------------------------------------------------------------

## 🛠 Tools Used

-   Verilog HDL
-   Xilinx Vivado
-   XSIM Simulator

------------------------------------------------------------------------


