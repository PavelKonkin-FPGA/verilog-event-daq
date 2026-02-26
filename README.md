# FPGA-Based Event-Driven Data Acquisition System

## 1. Overview
This repository contains a high-precision hardware implementation of an event-driven data acquisition (DAQ) unit. The system is designed to identify, capture, and measure the duration of asynchronous pulse bursts with clock-cycle accuracy, providing a resource-efficient alternative to continuous data streaming.

## 2. Technical Specifications
The design is optimized for the Intel Cyclone IV E architecture (EP4CE6E22C8) and meets the following performance metrics:

* **Reference Clock:** 50 MHz (20 ns sampling resolution).
* **Resource Utilization:** 166 Logic Elements (~3% of the EP4CE6 device), demonstrating high architectural efficiency.
* **Timing Closure:** Successfully met all timing requirements with a Setup Slack of +13.660 ns.
* **I/O Configuration:** 32-bit debug output bus for real-time monitoring.

## 3. System Architecture
The project utilizes a modular RTL (Register Transfer Level) approach, ensuring scalability and ease of integration into larger SoC designs:

* **Signal Synchronization (Frontend):** Handles asynchronous input signals to prevent metastability.
* **Timebase Generator (Timer):** A continuous 32-bit counter providing a global timestamp.
* **Event Processor (FSM):** A finite state machine that implements the detection logic and manages burst-to-data conversion.
* **Buffered Storage (FIFO):** Integrated memory blocks (M9K) for asynchronous data buffering between the processor and external interfaces.

## 4. Verification Methodology
In the absence of a commercial RTL simulator, a custom **Cycle-Accurate Python Emulator** was developed to validate the system logic. 

The emulator accurately reproduces the hardware's internal states and timing behavior, allowing for:
* Verification of the burst detection thresholds.
* Validation of FIFO write-request timing.
* Stress testing with various pulse patterns before physical synthesis.

## 5. Development Environment
* **HDL:** Verilog-2001.
* **Synthesis & Implementation:** Intel Quartus Prime Lite Edition.
* **Timing Analysis:** Quartus TimeQuest Timing Analyzer.
* **Scripts:** Python 3.x for verification and data visualization.

## 6. License
This project is released under the MIT License.