FPGA-Based Event-Driven Data Acquisition System
1. Project Overview
This project presents a hardware-level implementation of a high-resolution data acquisition (DAQ) unit designed for the Intel Cyclone IV FPGA architecture. The system is engineered to detect, capture, and measure the duration of asynchronous pulse bursts from external sensors with clock-cycle precision. Unlike traditional continuous sampling methods, this event-driven architecture optimizes data throughput and storage by recording only relevant signal transitions.

2. Technical Specifications
The design has been synthesized and validated for the Intel Cyclone IV E EP4CE6E22C8 device with the following performance metrics:

Reference Clock: 50.0 MHz.

Sampling Resolution: 20 ns per clock cycle.

Logic Resource Utilization: 166 Logic Elements (approximately 3% of available LEs).

Registers: 156 total registers.

Timing Closure: Successfully met with a Setup Slack of +13.660 ns.

Memory Blocks: Utilization of M9K blocks for internal FIFO buffering.

3. System Architecture
The repository contains a modular RTL (Register Transfer Level) design, ensuring high portability and integration readiness:

Signal Frontend: Implements synchronization logic to mitigate metastability and generates edge-detection strobes for asynchronous inputs.

Event Processor: A finite state machine (FSM) responsible for identifying burst start/end points and calculating elapsed time.

System Timer: A continuous 32-bit counter providing a global timebase for event synchronization.

Data FIFO: An asynchronous-ready buffer used to store 64-bit event data packets (timestamp and duration) prior to external transmission.

4. Verification and Validation
Functional correctness was verified using a cycle-accurate Python-based emulator. This verification environment simulates hardware behavior at the register level, allowing for:

Threshold Validation: Testing burst detection logic against varying pulse widths.

FIFO Management: Confirming the integrity of write-request signals and data alignment.

Signal Integrity: Assessing system response to high-frequency event bursts.

5. Deployment Instructions
5.1 Hardware Synthesis
Load the project via quartus/event_chip.qpf in Intel Quartus Prime.

Verify that all Verilog source files in the rtl/ directory are included in the project hierarchy.

Execute Full Compilation to generate the FPGA bitstream.

Review the TimeQuest Timing Analyzer reports to ensure all constraints are met.

5.2 Functional Simulation
Ensure a Python 3.x environment is available.

Execute the emulation script located at sim/emulator.py.

Analyze the output data to verify adherence to expected timing characteristics.

6. Repository Structure
rtl/: Contains core Verilog HDL modules.

quartus/: Project files, pin assignments, and SDC constraints.

ip/: Intel Quartus IP configuration files for FIFO and RAM components.

sim/: Verification scripts and software-based hardware models.

docs/: Technical reports and architectural visualizations.

7. License
This project is distributed under the MIT License.