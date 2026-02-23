# 2-D Integral Image Hardware Accelerator

## Project Overview
This repository contains the RTL design, simulation, and implementation of a hardware accelerator for computing 2-D Integral Images. The integral image is a crucial preprocessing step in computer vision and image processing algorithms (such as Haar cascades), allowing for the rapid calculation of sums over sub-image regions using only simple addition operations. 

The system is fully modeled as a Finite State Machine with Datapath (FSMD) using VHDL. It features a clear separation between the Control Unit and the Datapath, ensuring scalability and optimized hardware resource utilization.

## Features & Architecture
* **FSMD Architecture:** The core design separates the control logic (FSM) from the data processing units (Datapath).
* **CPU/Memory Interfacing:** Provides a standard I/O interface allowing a CPU to set the base addresses for the original image and the resulting integral image, along with the matrix size (from 5x5 up to 256x256). It operates via simple `Start` and `Done` handshake signals.
* **Line Buffer Integration:** Utilizes a 512 x 24-bit line buffer to store previously computed rows, significantly optimizing memory access and reducing latency during calculation.
* **Algorithmic Efficiency:** Implements the core integral image equation: 
  `I_out(r,c) = I_out(r-1,c) + I_out(r,c-1) - I_out(r-1,c-1) + I_in(r-1,c-1)` entirely in hardware using a custom compute block.

## Development Environment
* **Hardware Description Language:** VHDL
* **Simulation:** ModelSim SE
* **Synthesis & Implementation:** Xilinx Vivado 2018.3
* **Target Hardware:** FPGA (Configured for ZedBoard, easily adaptable to other development boards)

## 📂 Repository Structure
* `/src`: Contains all VHDL source files for the individual modules (Registers, Multiplexers, Adders, Comparators, Line Buffer, Control Unit, Datapath, and the Top-Level Microprocessor).
* `/sim`: Contains the testbench files used for behavioral simulation and waveform verification.
* `/docs`: Project report and detailed RTL block diagrams. Read this to comprehend about the system.

## Usage

### 1. Simulation (ModelSim)
To verify the behavioral logic of the design:
1. Open ModelSim and create a new project.
2. Add all `.vhd` files from the `/src` directory.
3. Add the `tb_microprocessor.vhd` testbench file from the `/sim` directory.
4. Compile all files and run the simulation. The testbench provides a 10ns clock period and simulates the `Start`, processing, and `Done` signaling.

### 2. Synthesis (Vivado)
To synthesize the design for FPGA deployment:
1. Create a new RTL project in Xilinx Vivado.
2. Import the VHDL sources from `/src`.
3. Add the timing constraint file (e.g., `create_clock -name clk -period 10.000 [get_ports clock]`).
4. Run Synthesis. Ensure timing constraints are met (Total Negative Slack should be 0.000 ns).
