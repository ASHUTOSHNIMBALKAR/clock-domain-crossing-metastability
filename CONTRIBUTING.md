# Contributing to Metastability CDC Simulation

First off, thank you for considering contributing to this repository! We welcome contributions to help improve the educational value of this project.

## How Can I Contribute?

### Reporting Bugs
If you find a bug in the Verilog code, testbenches, or simulation runner scripts, please open an Issue:
- Clearly describe the bug and the steps to reproduce it.
- If applicable, attach a screenshot of the GTKWave trace or copy the compiler error log.

### Submitting Code Changes
1. Fork the repository.
2. Create a new branch for your feature or bug fix (`git checkout -b feature/amazing-feature`).
3. Add your changes. If modifying RTL code, ensure that the simulation compile targets still pass by running `make` or `run_sim.bat`.
4. Submit a Pull Request (PR) describing what you changed and why.

## Style Guide
- **Indentation**: Use 4 spaces for Verilog code.
- **Port Naming**: Keep ports lowercase (e.g. `clk`, `async_in`, `sampled`).
- **Comments**: Explain the hardware reasoning for any change clearly.
