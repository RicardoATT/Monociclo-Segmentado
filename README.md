# The segmented single-cycle processor

![RTL View](assets/images/segmentedRTL.PNG)
![WaveForm View](assets/images/segmentedWave.png)

## Abstract
A segmented single-cycle processor (or pipelined processor) is a type of central processing unit (CPU) design in computer architecture. In a pipelined processor, the execution of instructions is divided into several stages or segments, so each stage of processing is performed in a different clock cycle. Pipelining aims to increase processor efficiency by allowing multiple instructions to execute in parallel, thereby improving overall performance. The implementation was carried out using the Quartus environment, which is a software tool produced by Altera for the analysis and synthesis of designs made in Hardware Description Languages (HDL or Hardware Description Language), which for this project Verilog was used. To simulate internal signals, the ModelSim simulator was used, which is free and distributed by Altera. Finally, the Instruction Set Architecture (ISA) used was RISC-V, because it is available under an open source license, which allows anyone to implement and manufacture RISC-V-based hardware without intellectual property restrictions, encouraging innovation and collaboration in hardware development. This project is part of the courses offered by the [Largarto Initiative](https://lagarto.ipn.mx/) of the National Polytechnic Institute (IPN).

## Tools used
- Quartus 20.1.1.
- rars 1.6.

## Programming languages
- Verilog.
- Assembly.

## Features
### What does the project contain?
- **ALU:** It is the Arithmetic Logic Unit, which is responsible for performing all the logical and mathematical operations of the processor.
- **BJControl:**
- **BranchPredictor:**
- **Decode:**
- **DecodeALU:**
- **Forwarding:**
- **FullAdder:**
- **FullAdderN:**
- **Hazard:**
- **IMemory:**
- **Memory:**
- **Monociclo:**
- **mux_3_to_1:**
- **RegisterFile:**
- **SignExtend:**
- **SignExtendPC:**

### How to install the tools?
See the [software installation](docs/softwareInstallation.md)

### How to build and run the project?
See the [build information](docs/buildInformation.md)

### How to simulate bubble sort in the project?
See the [example information](docs/exampleInformation.md)
